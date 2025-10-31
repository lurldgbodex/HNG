from fastapi import APIRouter
from core.models import JSONRPCRequest, A2AMessage, MessagePart, TaskResult, JSONRPCResponse
from services.study_service import generate_study_response

router = APIRouter()

@router.post("/a2a/studybuddy")
async def study_buddy_endpoint(request: JSONRPCRequest):
    user_text = ""
    for part in request.params.message.parts:
        if part.kind == 'text' and part.text:
            user_text = part.text.strip()
            break

    if not user_text:
        reply_text = "Please enter a topic you'd like me to explain, e.g, 'Photosynthesis'."
    else:
        result = generate_study_response(user_text)
        reply_text = result['reply_text']

    reply_message = A2AMessage(
        role="agent",
        parts=[MessagePart(kind='text', text=reply_text)]
    )

    task_result = TaskResult(
        contextId=request.params.contextId,
        message=reply_message
    )

    return JSONRPCResponse(id=request.id, result=task_result)