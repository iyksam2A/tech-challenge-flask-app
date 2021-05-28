from flask import Flask, Response, request
import boto3

candidates_app = Flask(__name__)

@candidates_app.route('/', methods=['GET'])
def default():
    return {"status": "invalid request"}, 400

@candidates_app.route('/gtg', methods=['GET'])
def gtg():
    details = request.args.get("details")

    if ("details" in request.args):
        return {"connected": "true"}, 200
    else:
        return Response(status = 200)

@candidates_app.route('/candidate/<name>', methods=['GET'])
def get_candidate(name):
    return {"candidate": name}, 200

@candidates_app.route('/candidate/<name>', methods=['POST'])
def post_candidate(name):
    return {"candidate": name}, 200

@candidates_app.route('/candidates', methods=['GET'])
def get_candidates():
    return Response(status = 200)
