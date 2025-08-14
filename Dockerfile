# Use Python 3.9 on Debian Bullseye (newer supported base)
FROM python:3.9-bullseye

# Install all system dependencies needed by PyAV and FFmpeg, plus Python build tools and distutils
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

# Fix NumPy version to avoid ABI mismatch errors with cv2 etc.
RUN python3.9 -m pip uninstall -y numpy || true
RUN python3.9 -m pip install numpy==1.21.6

# Install prebuilt PyAV wheel to avoid source build issues requiring MSVC compiler (Windows stuff)
RUN python3.9 -m pip install av==10.0.0

# Copy your project files into the container
COPY . .

# Install remaining Python requirements excluding 'av' from requirements.txt (make sure it's removed/commented)
RUN python3.9 -m pip install --no-cache-dir -U -r requirements.txt

# Start your bot
CMD ["python3.9", "main.py"]
