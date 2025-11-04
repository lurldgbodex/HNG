from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse
from uuid import uuid4
from models.a2a import (
    JSONRPCRequest, JSONRPCResponse, TaskResult, TaskStatus,
    A2AMessage, MessagePart, Artifact
)
from services.study_service import generate_study_response

router = APIRouter()

@router.post("/a2a/studybud")
async def study_buddy_endpoint(request: Request):
    body = await request.json()
    try:
        if body.get('jsonrpc') != '2.0' or "id" not in body:
            return JSONResponse(
                status_code=400,
                content={
                    "jsonrpc": "2.0",
                    "id": body.get('id'),
                    "error": {
                        "code": -32600,
                        "message": "Invalid Request: jsonrpc must be '2.0 and id is required"
                    }
                }
            )

        rpc_request = JSONRPCRequest(**body)

        messages = []
        context_id = None
        task_id = None
        config = None

        if rpc_request.method == "message/send":
            messages = [rpc_request.params.message]
            config = rpc_request.params.configuration
            task_id = str(uuid4())
            context_id = str(uuid4())
        elif rpc_request.method == "execute":
            messages = rpc_request.params.messages
            context_id = rpc_request.params.contextId
            task_id = rpc_request.params.taskId

        message = messages[-1] if messages else None
        user_input = message.parts[-1].text
        result_string = await generate_study_response(user_input)

        response_message = A2AMessage(
            role="agent",
            parts=[MessagePart(kind="text", text=result_string)],
            task_id =task_id
        )

        artifact = Artifact(name="response", parts=[MessagePart(kind="text", text=result_string)])

        history = messages + [response_message]

        task_result = TaskResult(
            id=task_id,
            contextId=context_id,
            status=TaskStatus(
                state="completed",
                messages=response_message
            ),
            artifacts=[artifact],
            history=history
        )

        response = JSONRPCResponse(
            id=rpc_request.id,
            result=task_result
        )

        return response.model_dump()

    except Exception as e:
        return JSONResponse(
            status_code=422,
            content={
                "jsonrpc": "2.0",
                "id": body.get("id"),
                "error": {
                    "code": -32602,
                    "message": f"Invalid params: {str(e)}"
                }
            }
        )
