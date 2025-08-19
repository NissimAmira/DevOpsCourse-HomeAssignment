# First stage - build basic requirements (python + flask)
FROM python:3.9-slim AS builder

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Second stage: create a lightweight image to run the app
FROM python:3.9-slim

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

COPY app.py .

CMD ["python", "app.py"]