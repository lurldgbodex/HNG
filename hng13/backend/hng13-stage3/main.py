import uvicorn
from fastapi import FastAPI
from app.routes import a2a_routes, agent_card_route
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(
    title="Study Buddy Agent",
    description="An AI-powered study assistant integrated with Telex A2A."
)

app.include_router(agent_card_route.router)
app.include_router(a2a_routes.router)

@app.get("/health")
async def health():
    return {"status": "ok", "agent": "StudyBuddyAgent"}

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)