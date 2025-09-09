#!/bin/bash
set -euo pipefail

APP_DIR=/home/ec2-user/tech-challenge-flask-app
PIDFILE=$APP_DIR/gunicorn.pid

[ -f "$PIDFILE" ] && kill -9 "$(cat "$PIDFILE")" || true
rm -f "$PIDFILE" || true

pkill -f "gunicorn -b 0.0.0.0:8000" || true
pkill -f "flask run" || true
