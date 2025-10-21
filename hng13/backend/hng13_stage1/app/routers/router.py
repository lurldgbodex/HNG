from fastapi import APIRouter, HTTPException, status, Query
from typing import Optional
from app.schemas.string_schema import StringRequest, StringResponse
from app.services.string_service import create_string_entry, get_string_entry, get_all_strings, delete_string_entry
from app.utils.natural_language_parser import parse_natural_language_query

router = APIRouter()


@router.post(
    '',
    response_model=StringResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Analyze and store a string",
    response_description="The analyzed string and its properties"
)
def analyze_string_endpoint(request: StringRequest):
    saved_string = create_string_entry(request.value)
    return {
        'id': saved_string.id,
        'value': saved_string.value,
        'properties': saved_string.properties,
        'created_at': saved_string.created_at
    }


@router.get(
    "/{string_value}",
    response_model=StringResponse,
    status_code=status.HTTP_200_OK,
    summary="Retrieve an analyzed string by its original value",
)
def get_analyzed_string(string_value: str):
    saved_string = get_string_entry(string_value)
    return {
        'id': saved_string.id,
        'value': saved_string.value,
        'properties': saved_string.properties,
        'created_at': saved_string.created_at
    }


@router.get(
    "",
    status_code=status.HTTP_200_OK,
    summary="Retrieve all analyzed strings with optional filters"
)
def get_all_analyzed_strings(
        is_palindrome: Optional[bool] = Query(None),
        min_length: Optional[int] = Query(None),
        max_length: Optional[int] = Query(None),
        word_count: Optional[int] = Query(None),
        contains_character: Optional[str] = Query(None)
):
    # Validate query parameters
    if contains_character is not None and len(contains_character) != 1:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid query parameter values or types"
        )

    try:
        strings = get_all_strings(
            is_palindrome=is_palindrome,
            min_length=min_length,
            max_length=max_length,
            word_count=word_count,
            contains_character=contains_character
        )
    except Exception:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid query parameter values or types"
        )

    return {
        "data": [
            {
                "id": s.id,
                "value": s.value,
                "properties": s.properties,
                "created_at": s.created_at
            }
            for s in strings
        ],
        "count": len(strings),
        "filters_applied": {
            "is_palindrome": is_palindrome,
            "min_length": min_length,
            "max_length": max_length,
            "word_count": word_count,
            "contains_character": contains_character
        }
    }


@router.get(
    "/filter-by-natural-language",
    status_code=status.HTTP_200_OK,
    summary="Filter strings using natural language query"
)
def filter_by_natural_language(query: str = Query(..., description="Natural language search query")):
    try:
        parsed_filters = parse_natural_language_query(query)
    except ValueError:
        raise HTTPException(
            status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
            detail="Query parsed but resulted in conflicting filters"
        )

    if not parsed_filters:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Unable to parse natural language query"
        )

    strings = get_all_strings(**parsed_filters)

    return {
        "data": [
            {
                "id": s.id,
                "value": s.value,
                "properties": s.properties,
                "created_at": s.created_at
            }
            for s in strings
        ],
        "count": len(strings),
        "interpreted_query": {
            "original": query,
            "parsed_filters": parsed_filters
        }
    }


@router.delete(
    "/{string_value}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Delete an analyzed string"
)
def delete_string(string_value: str):
    delete_string_entry(string_value)
    return None
