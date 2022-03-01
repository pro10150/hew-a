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


if __name__ == "__main__":
    app.run(debug=True)
