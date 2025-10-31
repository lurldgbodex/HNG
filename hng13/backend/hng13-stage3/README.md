# Study Buddy Agent (Telex Integration)

A conversational **AI agent** that helps users study interactively using the **Telex A2A protocol**.  
It supports context-aware Q&A, quizzes, and structured explanations.

Built with:
- **FastAPI** (for the A2A interface)
- **Transformers** (`google/flan-t5-small`) for reasoning
- **Pydantic v2** for data models
- **Docker + AWS ECS Fargate** for scalable deployment

---

## Features

- **Telex-compatible agent** following the A2A JSON-RPC spec  
- **AI-powered responses** with natural language reasoning  
- **Well-known Agent Card** for discovery (`/.well-known/agent.json`)  
- **Clean architecture** with modular files  
- **Dockerized** for cloud deployments  
- **AWS ECS Fargate-ready** setup with GitHub Actions CI/CD

---

## ⚙️ Local Development

1. Clone the repository
    ```bash
    git clone https://github.com/yourusername/study-buddy-agent.git
    cd study-buddy-agent
    ```
2. Create a virual environment
    ```bash
   python -m venv venv
   source venv/bin/activate
    ```
3. Install dependencies
   ```bash
    pip install -r requirements.txt
    ```
4. Run the app
    ```bash
       uvicorn main:app --reload --port 8000
    ```

## Example Interaction (via Telex)
### Input:
    ```text
        newton law
    ```
### Response:
```json
{
  "jsonrpc": "2.0",
  "id": "string",
  "result": {
    "contextId": "string",
    "status": "completed",
    "message": {
      "role": "agent",
      "parts": [
        {
          "kind": "text",
          "text": "Newton's third law states that for every action, there is an equal and opposite reaction."
        }
      ]
    }
  }
}

```

## Docker Setup
1. Build image
    ```bash
      docker build -t study-buddy-agent . 
    ```
2. Run container
    ```bash
      docker run -d -p 8000:8000 study-buddy-agent 
    ```
3. Test inside container
    ```bash
    curl http://localhost:8000/health
    ```
### using docker compose
`docker compose up --build`