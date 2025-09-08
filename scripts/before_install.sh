#!/bin/bash
set -e
pkill -f "gunicorn -b 0.0.0.0:8000" || true
pkill -f "flask run" || true
mkdir -p /home/ec2-user/tech-challenge-flask-app
rm -rf /home/ec2-user/tech-challenge-flask-app/venv
