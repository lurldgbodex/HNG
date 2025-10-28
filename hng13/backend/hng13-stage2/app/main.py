import os
from fastapi import FastAPI, Depends, Query, Path
from fastapi.responses import  JSONResponse, FileResponse
from sqlalchemy.orm import Session
from app.config.database import Base, engine, get_db
from app.models.models import  Country, RefreshStatus
from app.schemas.schemas import CountryOut, StatusOut, ErrorResponse
from app.services import crud
from app.utils import utils
from datetime import datetime, timezone
from dotenv import load_dotenv
import random

load_dotenv()
CACHE_DIR = os.getenv("CACHE_DIR", "cache")

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Countries Cache API")

@app.exception_handler(Exception)
async def generic_exception_handler(request, exc):
    # keep internal server errors consistent
    return JSONResponse(status_code=500, content={"error": "Internal server error"})

@app.post("/countries/refresh", responses={
    200: {"description": "Refreshed"},
    503: {"model": ErrorResponse}
})
def refresh_countries(db: Session = Depends(get_db)):
    """
    Fetch all countries and exchange rates, then cache them in the database.
    This endpoint is transactional: if external fetch fails we don't modify DB.
    """
    # 1. Fetch external data first (fail early, don't touch DB)
    try:
        countries_raw = utils.fetch_countries()
    except Exception:
        return JSONResponse(status_code=503, content={"error": "External data source unavailable", "details": "Could not fetch data from Countries API"})
    try:
        exchange_rates = utils.fetch_exchange_rates()
    except Exception:
        return JSONResponse(status_code=503, content={"error": "External data source unavailable", "details": "Could not fetch data from Exchange rates API"})

    # 2. Process and prepare updates
    now = datetime.now(timezone.utc)
    # We'll apply changes inside a transaction; if exception occurs rollback
    try:
        # start a transaction by not committing until done
        processed = []
        for item in countries_raw:
            name = item.get("name")
            capital = item.get("capital")
            region = item.get("region")
            population = item.get("population")
            flag_url = item.get("flag")
            currency_code = utils.extract_first_currency_code(item)  # may be None

            # Required validation per spec: name and population must exist. If missing, skip store? Spec wants 400 for invalid when received from user.
            # For refresh, we assume external sources provide name & population; if missing skip this country.
            if not name or population is None:
                # Skip items missing required fields from external API
                continue

            # Default handling per spec:
            if currency_code is None:
                exchange_rate = None
                estimated_gdp = 0
            else:
                # lookup rate in exchange_rates (case-sensitive; keys are currency codes)
                rate = exchange_rates.get(currency_code)
                if rate is None:
                    exchange_rate = None
                    estimated_gdp = None
                else:
                    exchange_rate = float(rate)
                    rand_mul = random.randint(1000, 2000)
                    estimated_gdp = utils.compute_estimated_gdp(population, rand_mul, exchange_rate)

            country_data = {
                "name": name,
                "capital": capital,
                "region": region,
                "population": population,
                "currency_code": currency_code,
                "exchange_rate": exchange_rate,
                "estimated_gdp": estimated_gdp,
                "flag_url": flag_url,
                "last_refreshed_at": now
            }
            processed.append(country_data)

        # Persist: do upserts
        for cd in processed:
            crud.insert_country(db, cd)

        # update refresh status
        total = db.query(Country).count()  # count BEFORE commit will reflect pre-existing + new adds staged in flush
        # But to be safe, set total to len(processed) + existing distinct by name; simplest: commit then set from DB
        db.commit()

        # After commit, recompute totals and update RefreshStatus
        total_after = db.query(Country).count()
        rs = crud.update_refresh_status(db, last_refreshed_at=now, total_countries=total_after)
        db.commit()

        # Generate summary image
        top5 = utils.top_n_by_gdp(db, n=5)
        try:
            img_path = utils.generate_summary_image(total_after, top5, now, CACHE_DIR)
        except Exception as e:
            # don't fail the whole refresh if image generation fails, but report it in response
            return {"message": "Refreshed with partial failures", "image_error": str(e)}
        return {"message": "Refreshed", "total_countries": total_after, "last_refreshed_at": now.isoformat()}

    except Exception as e:
        db.rollback()
        raise

@app.get("/countries", response_model=list[CountryOut], responses={400: {"model": ErrorResponse}})
def get_countries(region: str = Query(None), currency: str = Query(None), sort: str = Query(None), db: Session = Depends(get_db)):
    """
    Get all countries from DB. Support ?region=Africa | ?currency=NGN | ?sort=gdp_desc
    """
    if sort and sort not in ("gdp_desc", "gdp_asc"):
        return JSONResponse(status_code=400, content={"error": "Validation failed", "details": {"sort": "unsupported sort value"}})
    countries = crud.list_countries(db, region=region, currency=currency, sort=sort)
    return countries

@app.get("/countries/image")
def get_image():
    path = os.path.join(CACHE_DIR, "summary.png")
    if not os.path.exists(path):
        return JSONResponse(status_code=404, content={"error": "Summary image not found"})
    return FileResponse(path, media_type="image/png")

@app.get("/countries/{name}", response_model=CountryOut, responses={404: {"model": ErrorResponse}})
def get_country(name: str = Path(...), db: Session = Depends(get_db)):
    c = crud.get_country_by_name(db, name)
    if not c:
        return JSONResponse(status_code=404, content={"error": "Country not found"})
    return c

@app.delete("/countries/{name}", responses={200: {"description": "Deleted"}, 404: {"model": ErrorResponse}})
def delete_country(name: str = Path(...), db: Session = Depends(get_db)):
    ok = crud.delete_country_by_name(db, name)
    if not ok:
        return JSONResponse(status_code=404, content={"error": "Country not found"})
    return {"message": "Deleted"}

@app.get("/status", response_model=StatusOut)
def get_status(db: Session = Depends(get_db)):
    rs = db.query(RefreshStatus).first()
    if not rs:
        return {"total_countries": 0, "last_refreshed_at": None}
    return {"total_countries": rs.total_countries or 0, "last_refreshed_at": rs.last_refreshed_at}
