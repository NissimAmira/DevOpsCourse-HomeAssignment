from flask import Flask, jsonify, request
import time
import random

app = Flask(__name__)

@app.route('/random')
def random_number():
    """Return a random integer between 1 and 1000 as JSON."""
    number = random.randint(1, 1000)
    return jsonify(number=number)

@app.route('/load')
def load():
    """
    Generate a CPU burn for HPA testing.
    Pass ?duration=SECONDS to control how long to load (default 5s).
    """
    duration = float(request.args.get("duration", 5))
    end = time.time() + duration
    # busy-wait loop
    while time.time() < end:
        pass
    return jsonify({"status": f"CPU load for {duration}s completed"})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
