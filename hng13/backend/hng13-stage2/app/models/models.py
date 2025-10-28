from sqlalchemy import Column, Integer, String, Float, DateTime
from sqlalchemy.orm import Mapped, mapped_column
from typing import Optional
from app.config.database import Base

class Country(Base):
    __tablename__ = 'countries'


    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    name: Mapped[str] = mapped_column(String(100), nullable=False)
    capital: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    region: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    population: Mapped[int] = mapped_column(Integer, nullable=False)
    currency_code: Mapped[Optional[str]] = mapped_column(String(10), nullable=True, index=True)
    exchange_rate: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    estimated_gdp: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    flag_url: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)
    last_refreshed_at: Mapped[Optional[DateTime]] = mapped_column(DateTime, nullable=True)


class RefreshStatus(Base):
    __tablename__ = 'refresh_status'

    id = Column(Integer, primary_key=True, index=True)
    last_refreshed_at = Column(DateTime(timezone=True), nullable=True)
    total_countries = Column(Integer, nullable=True)
