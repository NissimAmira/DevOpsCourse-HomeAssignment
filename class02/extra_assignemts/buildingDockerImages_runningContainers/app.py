from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, Assignment 2: Running Containers"

if __name__ == "__main__":
    # Ensure it listens on all interfaces inside Docker
    app.run(host="0.0.0.0", port=5000)