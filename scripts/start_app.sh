#!/bin/bash
set -euo pipefail

APP_DIR=/home/ec2-user/tech-challenge-flask-app
LOG=$APP_DIR/app.out
PIDFILE=$APP_DIR/gunicorn.pid

cd "$APP_DIR"

# Use the venv from AfterInstall
source venv/bin/activate

# App env
export AWS_DEFAULT_REGION=us-east-2
export TC_DYNAMO_TABLE=Candidates

# Kill any stale process on this instance
if [ -f "$PIDFILE" ] && ps -p "$(cat "$PIDFILE")" >/dev/null 2>&1; then
  kill -9 "$(cat "$PIDFILE")" || true
  rm -f "$PIDFILE"
fi
pkill -f "gunicorn -b 0.0.0.0:8000" || true

# Start once and record PID
nohup gunicorn -b 0.0.0.0:8000 --pid "$PIDFILE" app:candidates_app > "$LOG" 2>&1 &

# Local health so CodeDeploy fails fast if this instance is bad
for i in {1..10}; do
  if curl -sf http://127.0.0.1:8000/gtg >/dev/null; then
    exit 0
  fi
  sleep 1
done
echo "local health failed" >&2
exit 1
