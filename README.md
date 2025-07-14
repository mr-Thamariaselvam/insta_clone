# 📸 insta_clone

A full-featured Django-based Instagram clone with Tailwind CSS (no Node.js required), PostgreSQL, Poetry, and Docker setup for development ease and portability.

---

## 🌟 Features

- Django 5+ app structure
- Tailwind CSS without installing node_modules
- Dockerized development environment
- PostgreSQL as the database
- Poetry for dependency and virtual environment management
- Environment variables handled via `.env.docker`
- Docker Compose for multi-container orchestration

---

## 🎨 Tailwind CSS Setup (Node.js)

1. **Initialize Tailwind config (no node_modules)**

   ```bash
   npm install tailwindcss @tailwindcss/cli
   npx tailwindcss-cli@latest init
   ```

2. **Create CSS input file**  
   Create a folder structure: `static/css/input.css`  
   Add the following:

   ```css
   @import "tailwindcss";
   @tailwind base;
   @tailwind components;
   @tailwind utilities;
   ```

3. **Build Tailwind CSS continuously**

   ```bash
   npx @tailwindcss/cli -i ./static/css/input.css -o ./static/css/output.css --watch
   ```

   > `--watch` allows real-time rebuilds on file changes.

---

## 🐳 Docker Setup

### 1. Build Docker Image

```bash
docker build -t insta_clone .
```

### 2. Run Container (foreground)

```bash
docker run -p 8005:8000 --name insta_clone insta_clone
```

### 3. Run with Volume Mount (dev mode)

```bash
docker run -p 8005:8000 --name insta_clone -v "${PWD}:/insta_clone" insta_clone
```

### 4. Run Detached (background)

```bash
docker run -dp 8005:8000 --name insta_clone -v "${PWD}:/insta_clone" insta_clone
```

---

## ⚙️ Poetry Setup

1. **Install poetry (if not already):**  
   [Install instructions](https://python-poetry.org/docs/#installation)

2. **Add dependencies in `pyproject.toml`**

   ```toml
   [tool.poetry.dependencies]
   python = "^3.11"
   Django = "^5.0"
   psycopg2-binary = "^2.9"
   python-decouple = "^3.8"
   dj-database-url = "^2.1"
   ```

3. **Install environment**

   ```bash
   poetry install
   ```

4. **Activate the virtual environment**

   ```bash
   poetry shell
   ```

---

## 🔐 .env.docker Configuration

```env
DEBUG=1
SECRET_KEY=your-secret-key
DJANGO_ALLOWED_HOSTS=localhost 127.0.0.1 [::1]

POSTGRES_DB=instadb
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_HOST=db
POSTGRES_PORT=5432

DATABASE_URL=postgresql://postgres:postgres@db:5432/instadb
```

> `.env.docker` is used to isolate Docker-specific environment settings.

---

## 🐘 PostgreSQL & Web (Docker Compose)

### 📄 `docker-compose.yml`

```yaml
name: insta_clone-local

services:
  db:
    image: postgres
    env_file:
      - ./.env.docker
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -d $${POSTGRES_DB} -U $${POSTGRES_USER}"]
      interval: 2s
      timeout: 10s
      retries: 5
      start_period: 30s

  web:
    build:
      context: .
      dockerfile: Dockerfile
    init: true
    volumes:
      - .:/insta_clone
    ports:
      - "8000:8000"
    env_file:
      - ./.env.docker
    restart: unless-stopped
    depends_on:
      db:
        condition: service_healthy

volumes:
  postgres_data:
```

---

## 🚀 Docker Entrypoint: `start-django.sh`

```bash
#!/bin/bash
set -e

# Run database migrations
poetry run python manage.py migrate

# Start the Django development server
poetry run python manage.py runserver 0.0.0.0:8000
```

Make it executable:

```bash
chmod +x start-django.sh
```

Ensure Dockerfile contains:

```dockerfile
COPY start-django.sh /start-django.sh
RUN chmod +x /start-django.sh
ENTRYPOINT ["/start-django.sh"]
```

---

## 🛠️ Basic Commands Cheat Sheet

| Action           | Command                                                                             |
| ---------------- | ----------------------------------------------------------------------------------- |
| Build Image      | `docker build -t insta_clone .`                                                     |
| Run Container    | `docker run -p 8005:8000 --name insta_clone insta_clone`                            |
| Run with Volume  | `docker run -p 8005:8000 -v "${PWD}:/insta_clone"`                                  |
| Stop + Remove    | `docker rm -f insta_clone`                                                          |
| Remove Image     | `docker rmi insta_clone`                                                            |
| List Containers  | `docker ps -a`                                                                      |
| Run Compose      | `docker-compose up --build`                                                         |
| Stop Compose     | `docker-compose down`                                                               |
| Tailwind Rebuild | `npx @tailwindcss/cli -i ./static/css/input.css -o ./static/css/output.css --watch` |

---

## 🌐 Access the App

Once the container is running:

👉 Visit: [http://localhost:8005](http://localhost:8005)

---

## ✅ You're Ready!

Your `insta_clone` environment now includes:

- Tailwind CSS (CLI)
- Dockerized Django + PostgreSQL
- Poetry-based dependency setup
- Hot reload development with volume mount
- Easy `.env` config for all services

---

## 📦 TODO (Optional Enhancements)

- Add Gunicorn + Nginx for production setup
- Add unit testing and GitHub Actions CI
- Deploy to Railway, Render, or Fly.io
