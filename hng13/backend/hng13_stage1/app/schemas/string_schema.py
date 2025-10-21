from pydantic import BaseModel, Field
from typing import Dict, Any


class StringRequest(BaseModel):
    value: str = Field(..., description="string to analyze")


class StringProperties(BaseModel):
    length: int
    is_palindrome: bool
    unique_characters: int
    word_count: int
    sha256_hash: str
    character_frequency_map: Dict[str, int]


class StringResponse(BaseModel):
    id: str
    value: str
    properties: StringProperties
    created_at: str
