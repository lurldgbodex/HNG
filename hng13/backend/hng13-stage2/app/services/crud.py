from sqlalchemy.orm import Session
from sqlalchemy import case
from app.models.models import Country, RefreshStatus
from datetime import datetime
from typing import Optional, List

def get_country_by_name(db: Session, name: str) -> Optional[Country]:
    return db.query(Country).filter(Country.name.ilike(name)).first()

def list_countries(db: Session, region: Optional[str]=None, currency: Optional[str]=None, sort: Optional[str]=None) -> List[Country]:
    q = db.query(Country)
    if region:
        q = q.filter(Country.region == region)
    if currency:
        q = q.filter(Country.currency_code == currency)

    if sort == "gdp_desc":
        q = q.order_by(
            case((Country.estimated_gdp == None, 1), else_=0),
            Country.estimated_gdp.desc()
        )
    elif sort == "gdp_asc":
        q = q.order_by(
            case((Country.estimated_gdp == None, 0), else_=1),
            Country.estimated_gdp.asc()
        )
    else:
        q = q.order_by(Country.id.asc())

    return q.all()

def delete_country_by_name(db: Session, name: str) -> bool:
    c = get_country_by_name(db, name)
    if not c:
        return False
    db.delete(c)
    db.commit()
    return True

def insert_country(db: Session, country_data: dict):
    """
    country_data must contain: name, capital, region, population, currency_code, exchange_rate, estimated_gdp, flag_url, last_refreshed_at
    Match by name case-insensitively.
    """
    name = country_data["name"]
    existing = db.query(Country).filter(Country.name.ilike(name)).first()
    if existing:
        existing.capital = country_data.get("capital")
        existing.region = country_data.get("region")
        existing.population = country_data.get("population")
        existing.currency_code = country_data.get("currency_code")
        existing.exchange_rate = country_data.get("exchange_rate")
        existing.estimated_gdp = country_data.get("estimated_gdp")
        existing.flag_url = country_data.get("flag_url")
        existing.last_refreshed_at = country_data.get("last_refreshed_at")
    else:
        existing = Country(
            name=country_data.get("name"),
            capital=country_data.get("capital"),
            region=country_data.get("region"),
            population=country_data.get("population"),
            currency_code=country_data.get("currency_code"),
            exchange_rate=country_data.get("exchange_rate"),
            estimated_gdp=country_data.get("estimated_gdp"),
            flag_url=country_data.get("flag_url"),
            last_refreshed_at=country_data.get("last_refreshed_at")
        )
        db.add(existing)
    # Note: do NOT commit here; caller controls transaction
    return existing

def update_refresh_status(db: Session, last_refreshed_at: datetime, total_countries: int):
    rs = db.query(RefreshStatus).first()
    if not rs:
        rs = RefreshStatus(last_refreshed_at=last_refreshed_at, total_countries=total_countries)
        db.add(rs)
    else:
        rs.last_refreshed_at = last_refreshed_at
        rs.total_countries = total_countries
    return rs