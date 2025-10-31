from pydantic import BaseModel, Field
from typing import List, Literal, Optional

class MessagePart(BaseModel):
    kind: Literal['text', 'data', 'file']
    text: Optional[str] = None

class A2AMessage(BaseModel):
    role: Literal['user', 'agent', 'system']
    parts: List['MessagePart']
    messageId: Optional[str] = None

class MessageConfiguration(BaseModel):
    blocking: bool = True

class MessageParams(BaseModel):
    message: A2AMessage
    contextId: str
    configuration: MessageConfiguration = Field(default_factory=MessageConfiguration)

class JSONRPCRequest(BaseModel):
    jsonrpc: Literal["2.0"]
    id: str
    method: Literal['message/send', 'execute']
    params: MessageParams

class TaskResult(BaseModel):
    contextId: str
    status: Literal['completed', 'working', 'failed'] = 'completed'
    message: A2AMessage

class JSONRPCResponse(BaseModel):
    jsonrpc: Literal['2.0'] = '2.0'
    id: str
    result: TaskResult