import re
from typing import Optional


def parse_natural_language_query(query: str) -> Optional[dict]:
    query = query.lower().strip()

    filters = {}

    if "single word" in query:
        filters["word_count"] = 1

    if "palindromic" in query or "palindrome" in query:
        filters["is_palindrome"] = True

    if match := re.search(r"longer than (\d+)", query):
        filters["min_length"] = int(match.group(1)) + 1

    if match := re.search(r"shorter than (\d+)", query):
        filters["max_length"] = int(match.group(1)) - 1

    if match := re.search(r"containing the letter (\w)", query):
        filters["contains_character"] = match.group(1)

    if match := re.search(r"contain the first vowel", query):
        filters["contains_character"] = "a"

    if not filters:
        return None

    if "min_length" in filters and "max_length" in filters and filters["min_length"] > filters["max_length"]:
        raise ValueError("Conflicting filters: min_length > max_length")

    return filters
