FROM python:3.9-bullseye

# Install OS-level dependencies
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

# Upgrade pip & build tools
RUN python3.9 -m pip install --upgrade pip setuptools wheel

# Fix numpy ABI mismatch
RUN python3.9 -m pip uninstall -y numpy || true
RUN python3.9 -m pip install numpy==1.21.6

# Copy project files
COPY . .

# Install Python dependencies
RUN python3.9 -m pip install --no-cache-dir -U -r requirements.txt

# Run the bot
CMD ["python3.9", "main.py"]
