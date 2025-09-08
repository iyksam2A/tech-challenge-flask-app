#!/bin/bash
set -e
cd /home/ec2-user/tech-challenge-flask-app

# Ensure files are owned by ec2-user (CodeDeploy copies as root)
chown -R ec2-user:ec2-user /home/ec2-user/tech-challenge-flask-app
chmod +x /home/ec2-user/tech-challenge-flask-app/scripts/*.sh || true

# Create venv and install deps as ec2-user
sudo -u ec2-user bash -lc '
  set -e
  cd /home/ec2-user/tech-challenge-flask-app
  python3 -m venv venv
  source venv/bin/activate
  pip install --upgrade pip
  pip install -r requirements.txt
'
