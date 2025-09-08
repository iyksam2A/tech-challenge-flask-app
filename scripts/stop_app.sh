#!/bin/bash
pkill -f "gunicorn -b 0.0.0.0:8000" || true
pkill -f "flask run" || true
