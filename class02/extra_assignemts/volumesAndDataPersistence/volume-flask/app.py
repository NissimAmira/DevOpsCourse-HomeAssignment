from flask import Flask
import datetime

app = Flask(__name__)

@app.route("/")
def hello():
    with open("/data/app.log", "a") as f:
        f.write(f"{datetime.datetime.now()}: Received a request\n")
    return "Hello! Log written."

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)