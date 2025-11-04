import os

from dotenv import load_dotenv
from openai import OpenAI

load_dotenv()

API_TOKEN = os.getenv("API_TOKEN")
BASE_URL = os.getenv("BASE_URL")
MODEL = os.getenv("MODEL")

def query_huggingface(prompt: str):

    print(f"Prompt: {prompt}")
    client = OpenAI(
        base_url=BASE_URL,
        api_key=API_TOKEN
    )

    completion = client.chat.completions.create(
        model=MODEL,
        messages=[
            {
                "role": "user",
                "content": prompt
            }
        ]
    )
    generated = completion.choices[0].message
    content = getattr(generated, "content", str(generated))

    print(content)
    return content
