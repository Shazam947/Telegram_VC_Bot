# Python based docker image
FROM python:3.9-bullseye

# Install dependencies in one layer
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

# Upgrade pip
RUN python3.9 -m pip install --upgrade pip

# Copy all project files
COPY . .

# Install Python requirements
RUN python3.9 -m pip install --no-cache-dir -U -r requirements.txt

# Run VC Bot
CMD ["python3.9", "main.py"]
