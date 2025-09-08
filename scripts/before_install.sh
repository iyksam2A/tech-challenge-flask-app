#!/bin/bash
set -e

# Stop any old processes
pkill -f "gunicorn -b 0.0.0.0:8000" || true
pkill -f "flask run" || true

# Prepare app dir
mkdir -p /home/ec2-user/tech-challenge-flask-app

# Remove old venv (may be owned by root from previous runs)
rm -rf /home/ec2-user/tech-challenge-flask-app/venv
