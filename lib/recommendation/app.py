from flask import Flask, jsonify, request
import recommendation as rcm
import base64

app = Flask(__name__)


@app.route('/recommendation', methods=['GET'])
def index():
    uid = request.args.get('uid')
    databaseLocation = request.args.get('databaseLocation')
    databaseLocation = base64.b64decode(
        databaseLocation).decode("utf-8", "ignore")
    print(databaseLocation)
    result = rcm.getRecommendations(databaseLocation, uid)
    # print(result)
    return jsonify({'uid': uid, 'recommendation': result})


@app.route('/test', methods=['GET'])
def test():
    return jsonify({'greeting': 'Hi'})


if __name__ == "__main__":
    app.run(host='192.168.1.108', port=5000, debug=True)
