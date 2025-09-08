#!/bin/bash
set -e
cd /home/ec2-user/tech-challenge-flask-app
python3.11 -m venv venv                # ← 3.11 virtualenv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
