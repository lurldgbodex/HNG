from app.core.config import query_huggingface

async def generate_study_response(topic: str) -> str:
    """
    Given a topic, generate an explanation and a quiz question

    :param topic: to generate explanation and quiz about
    :return: generated explanation and quiz
    """
    explanation_prompt = f"Explain the topic '{topic}' clearly and briefly as if teaching a high school student."

    explanation = query_huggingface(explanation_prompt)

    return explanation
