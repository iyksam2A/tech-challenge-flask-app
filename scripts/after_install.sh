#!/bin/bash
set -euo pipefail
cd /home/ec2-user/tech-challenge-flask-app

# Ensure ownership and executable bits
chown -R ec2-user:ec2-user /home/ec2-user/tech-challenge-flask-app
chmod +x /home/ec2-user/tech-challenge-flask-app/scripts/*.sh || true

# Create venv and install deps as ec2-user
# (Works whether python3 is 3.11 or 3.9; LaunchTemplate installed 3.11 anyway.)
sudo -u ec2-user bash -lc '
  set -euo pipefail
  cd /home/ec2-user/tech-challenge-flask-app
  python3 -m venv venv
  source venv/bin/activate
  pip install --upgrade pip
  pip install -r requirements.txt
'
