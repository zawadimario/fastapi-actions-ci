# Base image with most required packages and libraries
FROM python:3.9-slim

# Update base OS
RUN apt update -y && apt upgrade -y

# Create a working directory that will also serve as root of the application
WORKDIR /app

# Copy requirements file
COPY requirements.txt requirements.txt

# Install requirements and dependencies
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Transfer the rest of source code
COPY app/ .

# Start and serve the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
