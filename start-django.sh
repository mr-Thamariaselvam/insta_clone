#!/bin/bash

# Exit on any error
set -e

# Run migrations
poetry run python manage.py migrate

# Start server
poetry run python manage.py runserver 0.0.0.0:8000
