# Python 3.9 + Debian Bullseye base image
FROM python:3.9-bullseye

# Install system dependencies, including FFmpeg, development headers, and distutils
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

# Upgrade pip, setuptools, wheel to latest versions
RUN python3.9 -m pip install --upgrade pip setuptools wheel

# Uninstall existing numpy and install a compatible version to fix ABI mismatch
RUN python3.9 -m pip uninstall -y numpy && \
    python3.9 -m pip install numpy==1.21.6

# Copy project files
COPY . .

# Install Python dependencies from requirements.txt without cache
RUN python3.9 -m pip install --no-cache-dir -U -r requirements.txt

# Command to start your bot
CMD ["python3.9", "main.py"]
