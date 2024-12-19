# Use a lightweight Python image
FROM python:3.10.4-slim-buster

# Set environment variables to prevent Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Update and install necessary packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    git curl wget ffmpeg bash neofetch software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -U pip wheel && \
    pip3 install --no-cache-dir -r /tmp/requirements.txt && \
    rm -f /tmp/requirements.txt

# Set the working directory
WORKDIR /app

# Copy the application code into the container
COPY . .

# Specify the command to run your app
CMD ["python3", "-m", "Restriction"]
