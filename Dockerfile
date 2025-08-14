# Base image (Python 3.9 + Debian Bullseye)
FROM python:3.9-bullseye

# Install system dependencies (FFmpeg + development headers)
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
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip/setuptools/wheel
RUN python3.9 -m pip install --upgrade pip setuptools wheel

# Uninstall incompatible numpy & install a compatible one
RUN python3.9 -m pip uninstall -y numpy && \
    python3.9 -m pip install numpy==1.21.6

# Copy all project files into container
COPY . .

# Install Python requirements (no cache for fresh build)
RUN python3.9 -m pip install --no-cache-dir -U -r requirements.txt

# Start the bot
CMD ["python3.9", "main.py"]
