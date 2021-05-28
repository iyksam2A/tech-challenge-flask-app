tech-challenge-flask-app - Hello, Candidate
===========================================

## About
Simple flask based api that adds data to a database and returns it

Includes a health check

## Preparing
A DynamoDB table is required for this application to function

Instructions can be found here: [Setting Up DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/SettingUp.DynamoWebService.html)

**Make sure you create an instance role using IAM to allow access for your ec2 instances to the DynamoDB table or the application will not run!**

Information on IAM for DynamoDB can be found here:
[DynamoDB - using identity based policies](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/using-identity-based-policies.html)


## Running
Reads environment variable to connect to dynamodb in AWS with a connection string; this must be set first appropriately for your host OS

using bash on Linux this would look like the following:
```
export TC_DYNAMO_TABLE=<dynamodb table>
```

windows using powershell
```
$env:TC_DYNAMO_TABLE=<dynamodb table>
```

To install requirements (requires pip):
```
pip install -r requirements.txt
```

To run on port 8000 (default port):
```
gunicorn app:candidates_app
```

## Testing

A python test script is provided and can be run as follows:
```
python test_candidates.py <ip/dns address>
```

## Containerizing
A dockerfile is provided to build an image for the application

## Routes

- [GET] /gtg
  - Simple healtcheck - returns HTTP 200 OK if everything is working
  - Empty return

- [GET] /gtg?details
  - Advanced healthcheck - returns HTTP 200 OK if everything is working and some service details
  - JSON return

- [POST] /candidate/<str:name>
  - Adds a new string (candidate name) to a list, returns HTTP 200 OK if working
  - JSON return

  - optional parameter ?party=
  - will assign to a political party
    - empty/unsupplied or ind: none/independent (default)
    - dem: democratic
    - rep: republican
  - will error if supplied with something other than the three parameters above

- [GET] /candidate/<str:name>
  - Gets candidate name from the list, returns HTTP 200 OK and data
  - JSON return

- [GET] /candidates
  - Gets list of all candidates from a list, returns HTTP 200 OK and data
  - JSON return