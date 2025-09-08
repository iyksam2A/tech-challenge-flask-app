#!/bin/bash
set -e
cd /home/ec2-user/tech-challenge-flask-app

# Use system Python (AL2023 -> Python 3.9)
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
