#!/bin/bash
set -euo pipefail

# Stop any old app processes (ignore if none)
pkill -f "gunicorn -b 0.0.0.0:8000" || true
pkill -f "flask run" || true

# Ensure app dir exists and belongs to ec2-user
mkdir -p /home/ec2-user/tech-challenge-flask-app
chown -R ec2-user:ec2-user /home/ec2-user/tech-challenge-flask-app

# Remove stale virtualenv to avoid version pin conflicts
rm -rf /home/ec2-user/tech-challenge-flask-app/venv
