from pydantic import BaseModel, Field, validator
from typing import Optional
from datetime import datetime

class CountryOut(BaseModel):
    id: int
    name: str
    capital: Optional[str]
    region: Optional[str]
    population: int
    currency_code: Optional[str] = Field(None)
    exchange_rate: Optional[float] = Field(None)
    estimated_gdp: Optional[float] = Field(None)
    flag_url: Optional[str] = Field(None)
    last_refreshed_at: Optional[datetime] = Field(None)

    class Config:
        orm_mode = True

class StatusOut(BaseModel):
    total_countries: int
    last_refreshed_at: Optional[datetime]

class ErrorResponse(BaseModel):
    error: str
    details: Optional[dict] = None