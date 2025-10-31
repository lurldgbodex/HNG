from core.config import generator

def generate_study_response(topic: str) -> dict:
    """
    Given a topic, generate an explanation and a quiz question

    :param topic: to generate explanation and quiz about
    :return: generated explanation and quiz
    """
    explanation_prompt = f"Explain the topic '{topic}' clearly and briefly as if teaching a high school student."
    quiz_prompt = f"Create one engaging quiz question to test understanding of '{topic}'."

    explanation = generator(explanation_prompt, max_length=80, temperature=0.7)[0]["generated_text"]
    quiz_question = generator(quiz_prompt, max_length=50, temperature=0.8)[0]['generated_text']

    return {
        "explanation": explanation.strip(),
        "quiz_question": quiz_question.strip(),
        "reply_text": f"{explanation.strip()}\n\n Quiz: {quiz_question.strip()}"
    }

