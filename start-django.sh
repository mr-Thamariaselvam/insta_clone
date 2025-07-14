#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "▶️  Starting Tailwind CSS in watch mode..."
npx tailwindcss -i ./static/css/input.css -o ./static/css/output.css --watch &

echo "▶️  Applying database migrations..."
poetry run python manage.py migrate

echo "▶️  Starting Django development server..."
poetry run python manage.py runserver 0.0.0.0:8000
