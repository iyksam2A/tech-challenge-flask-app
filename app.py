import json, os
from flask import Flask, request
import boto3
from boto3.dynamodb.conditions import Key
import utils

token = utils.get_token()
instance_id = "unavailable"
if token:
    instance_id = utils.get_instance_id(token)

dynamo_table_name = os.environ.get('TC_DYNAMO_TABLE','Candidates')
dyndb_client = boto3.resource('dynamodb', region_name='us-east-2')
dyndb_table = dyndb_client.Table(dynamo_table_name)

candidates_app = Flask(__name__)

@candidates_app.route('/', methods=['GET'])
def default():
    return {"status": "invalid request"}, 400

@candidates_app.route('/gtg', methods=['GET'])
def gtg():
    if ("details" in request.args):
        return {"connected": "true", "instance-id": instance_id}, 200
    return {"connected": "true"}, 200


@candidates_app.route('/candidate/<name>', methods=['GET'])
def get_candidate(name):
    try:
        response = dyndb_table.query(
            KeyConditionExpression=Key('CandidateName').eq(name)
        )

        if len(response['Items']) == 0:
            return {"error": "no candidates found"}, 404

        print(response['Items'])
        return json.dumps(response['Items']), 200

    except:
        return {"error": "Not Found"}, 404

@candidates_app.route('/candidate/<name>', methods=['POST'])
def post_candidate(name):
    # NEW: support ?party=dem|rep|ind (default independent). Otherwise 400.
    party_param = request.args.get("party", "")
    party_raw = party_param.lower() if isinstance(party_param, str) else ""

    if party_raw in ("", "ind"):
        party = "independent"
    elif party_raw == "dem":
        party = "democratic"
    elif party_raw == "rep":
        party = "republican"
    else:
        return {"error": "invalid party (allowed: dem, rep, ind)"}, 400

    try:
        dyndb_table.put_item(Item={"CandidateName": name, "Party": party})
    except Exception:
        return {"error": "Unable to update"}, 500

    return {"CandidateName": name, "Party": party}, 200

@candidates_app.route('/candidates', methods=['GET'])
def get_candidates():
      try:
        items = dyndb_table.scan()['Items']

        if len(items) == 0:
            return {"error": "no items were found"}, 404
        return json.dumps(items), 200

      except:
        return {"error": "Not Found"}, 404
