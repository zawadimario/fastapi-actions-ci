# Base image with most required packages and libraries
FROM python:3.9-slim

# Update base OS
RUN apt update -y && apt upgrade -y && rm -rf /var/lib/apt/lists/*

# Create a working dorectory
WORKDIR /app

# Copy requirements and install globally as root
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -rf requirements.txt

# Copy source
COPY app/ .

# Create non-root user 'mluser' and give ownership of /app
RUN useradd -m -s /bin/bash mluser && chown -R mluser:mluser /app

# Switch to non-root user
USER mluser

# Start and serve the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]