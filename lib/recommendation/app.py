from flask import Flask, jsonify, request
import recommendation as rcm
import base64

app = Flask(__name__)


@app.route('/recommendation', methods=['POST'])
def index():
    uid = request.args.get('uid')
    data = request.get_json()
    result = rcm.getRecommendations(data, uid)
    print(result)
    return jsonify({'uid': uid, 'recommendation': result})


@app.route('/test', methods=['GET'])
def test():
    return jsonify({'greeting': 'Hi'})


@app.route('/post_test', methods=['POST'])
def post_test():
    return jsonify({'greeting': 'Hi'})


@app.route('/get_recommendation', methods=['POST'])
def get_recommendation():
    data = request.form
    print(type(data))
    return jsonify


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=6000, debug=True)
