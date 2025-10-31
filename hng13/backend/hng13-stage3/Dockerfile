FROM python:3.11-slim

# Install system deps for transformers / torch; reduce image size by cleaning apt
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential git curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt /app/

# Install python deps
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . /app

# Create a non-root user
RUN useradd --create-home appuser
USER appuser
ENV HOME=/home/appuser

# Expose port used by Uvicorn
ENV PORT=8000
EXPOSE 8000

# Use uvicorn to serve FastAPI; bind to 0.0.0.0
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "1"]
