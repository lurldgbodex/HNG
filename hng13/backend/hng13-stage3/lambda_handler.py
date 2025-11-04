from fastapi import FastAPI
from mangum import Mangum
from app.routes.a2a_routes import router as a2a_router
from app.routes.agent_card_route import router as agent_router

app = FastAPI(
    titile="StudyBuddy Telex Agent",
    version="1.0.0",
    description="A simple Telex agent that explains study topics and generates quiz questions."
)

app.include_router(a2a_router)
app.include_router(agent_router)

handler = Mangum(app)
