from app.models.string_model import StringModel
from app.utils.string_utils import analyze_string, compute_sha256
from fastapi import HTTPException, status

string_db = {}


def create_string_entry(value: str) -> StringModel:
    sha_hash = compute_sha256(value)

    if sha_hash in string_db:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="String already exists in the system"
        )

    properties = analyze_string(value)
    saved_data = StringModel(id=sha_hash, value=value, properties=properties)
    string_db[sha_hash] = saved_data
    return saved_data


def get_string_entry(value: str) -> StringModel:
    sha_hash = compute_sha256(value)
    saved_data = string_db.get(sha_hash)

    if not saved_data:
        raise HTTPException(status_code=404, detail="String does not exist in the system")

    return saved_data


def get_all_strings(
        is_palindrome: bool | None = None,
        min_length: int | None = None,
        max_length: int | None = None,
        word_count: int | None = None,
        contains_character: str | None = None
) -> list[StringModel]:
    results = list(string_db.values())

    if is_palindrome is not None:
        results = [s for s in results if s.properties['is_palindrome'] == is_palindrome]

    if min_length is not None:
        results = [s for s in results if s.properties['length'] >= min_length]

    if max_length is not None:
        results = [s for s in results if s.properties["length"] <= max_length]

    if word_count is not None:
        results = [s for s in results if s.properties["word_count"] == word_count]

    if contains_character is not None:
        char = contains_character.lower()
        results = [s for s in results if char in s.value.lower()]

    return results


def delete_string_entry(value: str):
    sha_hash = compute_sha256(value)

    if sha_hash not in string_db:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="String does not exist in the system"
        )

    del string_db[sha_hash]
