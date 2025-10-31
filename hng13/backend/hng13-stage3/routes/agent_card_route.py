from fastapi import APIRouter
from fastapi.responses import JSONResponse

router = APIRouter()

@router.get("/.well-known/agent.json")
async def agent_card():
    agent_info = {
        "name": "studyBuddyAgent",
        "description": "An agent that explains topics and creates quiz questions for students.",
        "url": "https://your-agent-domain.com/a2a/studybuddy",
        "version": "1.0.0",
        "provider": {
            "organization": "Study Buddy Labs",
            "url": "https://studybuddy.example.com"
        },
        "documentationUrl": "https://your-agent-domain.com/docs",
        "capabilities": {
            "streaming": False,
            "pushNotifications": False,
            "stateTransitionHistory": False
        },
        "defaultInputModes": ["text/plain"],
        "defaultOutputModes": ["application/json", "text/plain"],
        "skills": [
            {
                "id": "study_explain_001",
                "name": "Topic Explanation and Quiz Generation",
                "description": "Given a topic, provides a short explanation and a quiz question.",
                "inputModes": ["text/plain"],
                "outputModes": ["text/plain"],
                "examples": [
                    {
                        "input": {"parts": [{"text": "Explain gravity", "contentType": "text/plain"}]},
                        "output": {"parts": [
                            {"text": "Gravity pulls objects together. Quiz: Who proposed the law of gravity?",
                             "contentType": "text/plain"}]}
                    }
                ]
            }
        ],
        "supportsAuthenticatedExtendedCard": False
    }
    return JSONResponse(agent_info)