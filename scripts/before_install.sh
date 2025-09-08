#!/bin/bash
set -e

# Stop any old processes
pkill -f "gunicorn -b 0.0.0.0:8000" || true
pkill -f "flask run" || true

# Prepare app dir
mkdir -p /home/ec2-user/tech-challenge-flask-app

# Clean old venv to avoid version conflicts
rm -rf /home/ec2-user/tech-challenge-flask-app/venv

# Ensure scripts are executable (helps CodeDeploy)
chmod +x /home/ec2-user/tech-challenge-flask-app/scripts/*.sh 2>/dev/null || true
