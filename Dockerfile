# Python 3.9 + Debian Bullseye base image
FROM python:3.9-bullseye

# Install system dependencies (FFmpeg + development headers + distutils)
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        ffmpeg \
        opus-tools \
        pkg-config \
        libavformat-dev \
        libavcodec-dev \
        libavdevice-dev \
        libavutil-dev \
        libavfilter-dev \
        libswscale-dev \
        libswresample-dev \
        python3.9-distutils \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, wheel
RUN python3.9 -m pip install --upgrade pip setuptools wheel

# Fix NumPy ABI mismatch by installing compatible version
RUN python3.9 -m pip uninstall -y numpy && \
    python3.9 -m pip install numpy==1.21.6

# Copy project files into container
COPY . .

# Install Python dependencies
RUN python3.9 -m pip install --no-cache-dir -U -r requirements.txt

# Command to start the bot
CMD ["python3.9", "main.py"]
