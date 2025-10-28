import os
import requests
from datetime import datetime
from typing import List, Optional
from app.models.models import Country
from sqlalchemy.orm import Session
from PIL import Image, ImageDraw, ImageFont


COUNTRIES_API = "https://restcountries.com/v2/all?fields=name,capital,region,population,flag,currencies"
EXCHANGE_API = "https://open.er-api.com/v6/latest/USD"

def fetch_countries() -> List[dict]:
    r = requests.get(COUNTRIES_API, timeout=20)
    if r.status_code != 200:
        raise RuntimeError("Countries API failed")
    return r.json()

def fetch_exchange_rates() -> dict:
    r = requests.get(EXCHANGE_API, timeout=20)
    if r.status_code != 200:
        raise RuntimeError("Exchange API failed")
    payload = r.json()
    # the API returns rates under 'rates' usually
    rates = payload.get("rates")
    if rates is None:
        # may be another field name; but per spec we raise
        raise RuntimeError("Exchange API response invalid")
    return rates

def extract_first_currency_code(country_item: dict) -> Optional[str]:
    currencies = country_item.get("currencies")
    if not currencies:
        return None
    # currencies is an array of objects; take first's code
    first = currencies[0]
    code = first.get("code")
    return code

def compute_estimated_gdp(population: int, rand_mul: int, exchange_rate: Optional[float]) -> Optional[float]:
    if exchange_rate is None:
        # Spec: if currency not found -> estimated_gdp = null; if currency array empty -> estimated_gdp = 0
        return None
    # Guard dividing by zero
    if exchange_rate == 0:
        return None
    return (population * rand_mul) / exchange_rate

def generate_summary_image(total: int, top5: List[dict], last_refreshed_at: datetime, cache_dir: str):
    os.makedirs(cache_dir, exist_ok=True)
    path = os.path.join(cache_dir, "summary.png")

    width, height = 1200, 800
    img = Image.new("RGB", (width, height), "white")
    draw = ImageDraw.Draw(img)

    # Try to use a default font; if not available, Pillow will fall back
    try:
        font_title = ImageFont.truetype("arial.ttf", 40)
        font_subtitle = ImageFont.truetype("arial.ttf", 24)
        font_text = ImageFont.truetype("arial.ttf", 20)
    except Exception:
        font_title = ImageFont.load_default()
        font_subtitle = ImageFont.load_default()
        font_text = ImageFont.load_default()

    # Draw title
    y = 40
    draw.text((width // 2 - 200, y), f"Countries Summary", font=font_title, fill="black")

    # Draw timestamp
    y += 80
    timestamp = last_refreshed_at.strftime("%Y-%m-%d %H:%M:%S UTC")
    draw.text((60, y), f"Last Refreshed: {timestamp}", font=font_subtitle, fill="black")

    # Draw total countries
    y += 50
    draw.text((60, y), f"Total Countries: {total}", font=font_subtitle, fill="black")

    # Draw top 5 countries by estimated GDP
    y += 80
    draw.text((60, y), "Top 5 Countries by Estimated GDP:", font=font_subtitle, fill="black")
    y += 40

    if not top5:
        draw.text((80, y), "No countries available.", font=font_text, fill="gray")
    else:
        for i, c in enumerate(top5, start=1):
            name = c.get("name", "Unknown")
            gdp = c.get("estimated_gdp")
            gdp_str = f"{gdp:,.2f}" if gdp else "N/A"
            draw.text((80, y), f"{i}. {name:<20} — ${gdp_str}", font=font_text, fill="black")
            y += 30

        # Footer
    y = height - 50
    draw.text((width - 350, y), f"Generated at {timestamp}", font=font_text, fill="gray")

    img.save(path)
    return path

def top_n_by_gdp(db: Session, n: int = 5):
    # fetch top n by estimated_gdp desc
    q = db.query(Country).filter(Country.estimated_gdp != None).order_by(Country.estimated_gdp.desc()).limit(n)
    res = q.all()
    out = []
    for c in res:
        out.append({
            "name": c.name,
            "estimated_gdp": c.estimated_gdp
        })
    return out
