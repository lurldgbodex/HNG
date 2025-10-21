from datetime import datetime


class StringModel:
    def __init__(self, id: str, value: str, properties: dict):
        self.id = id
        self.value = value
        self.properties = properties
        self.created_at = datetime.utcnow().isoformat() + "Z"
