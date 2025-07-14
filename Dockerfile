FROM python:3.13.5-bullseye

# Prevents Python from writing .pyc files and enables real-time logging
ENV PYTHONUNBUFFERED=1

# Create working directory
RUN mkdir /insta_clone

# Set working directory
WORKDIR /insta_clone

# Install Poetry
RUN pip install --upgrade pip && pip install poetry

# Copy Poetry dependency files
COPY pyproject.toml poetry.lock* ./

# Install dependencies 
RUN poetry install

# Copy the rest of your Django project code (excluding start-django.sh)
COPY . .

# Copy the startup script (separately, after code copy, to avoid being overwritten)
COPY start-django.sh /start-django.sh

# Make the script executable
RUN chmod +x start-django.sh


# Expose Django dev server port
EXPOSE 8000

# Run the script
ENTRYPOINT ["/start-django.sh"]
