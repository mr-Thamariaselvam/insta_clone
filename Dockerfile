FROM python:3.13.5-bullseye

ENV PYTHONUNBUFFERED=1

RUN mkdir /insta_clone
WORKDIR /insta_clone

# Install system dependencies
RUN apt-get update && apt-get install -y curl

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
  apt-get install -y nodejs

# Install Poetry
RUN pip install --upgrade pip && pip install poetry

# Copy and install backend dependencies
COPY pyproject.toml poetry.lock* ./
RUN poetry install

# Copy frontend (Tailwind) dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy rest of the project files
COPY . .

# Set permissions
RUN chmod +x start-django.sh

EXPOSE 8000

ENTRYPOINT ["./start-django.sh"]
