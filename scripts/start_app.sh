#!/bin/bash
set -e
cd /home/ec2-user/tech-challenge-flask-app
source venv/bin/activate
export AWS_DEFAULT_REGION=us-east-2
export TC_DYNAMO_TABLE=Candidates
nohup gunicorn -b 0.0.0.0:8000 app:candidates_app > app.out 2>&1 &
