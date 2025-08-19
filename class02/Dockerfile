FROM python:3.12-slim

RUN apt-get update && apt-get install -y

WORKDIR /app

COPY getUser.py .

CMD ["python", "getUser.py"]
