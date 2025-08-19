from flask import Flask
import redis

app = Flask(__name__)

# Connect to Redis using the service name as hostname
r = redis.Redis(host='redis', port=6379, decode_responses=True)

@app.route('/')
def hello():
    # Increment a Redis key to show connection works
    count = r.incr('hits')
    return f"Hello! This page has been visited {count} times."

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)