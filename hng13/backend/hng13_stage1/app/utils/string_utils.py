import hashlib


def compute_sha256(value: str) -> str:
    normalized = value.lower()
    return hashlib.sha256(normalized.encode('utf-8')).hexdigest()


def is_palindrome(value: str) -> bool:
    cleaned = value.lower().replace(' ', '')
    return cleaned == cleaned[::-1]


def compute_character_frequency(value: str) -> dict:
    freq = {}
    for char in value:
        freq[char] = freq.get(char, 0) + 1
    return freq


def analyze_string(value: str) -> dict:
    sha_hash = compute_sha256(value)
    return {
        'length': len(value),
        'is_palindrome': is_palindrome(value),
        'unique_characters': len(set(value)),
        'word_count': len(value.split()),
        'sha256_hash': sha_hash,
        'character_frequency_map': compute_character_frequency(value)
    }
