FROM python:3.13.5-bullseye

# Prevents Python from writing .pyc files and enables real-time logging
ENV PYTHONUNBUFFERED=1

# Create working directory (fixed spacing error in mkdir command)
RUN mkdir /insta_clone

# Set working directory
WORKDIR /insta_clone

# Install Poetry
RUN pip install --upgrade pip && pip install poetry

# Copy Poetry dependency files
COPY pyproject.toml poetry.lock* ./

# Install dependencies without creating a virtualenv
RUN poetry install

# Copy the rest of the project files
COPY . .

# Expose port 8000 for the Django dev server
EXPOSE 8000

# Run the Django development server
ENTRYPOINT ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]