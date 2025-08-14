FROM python:3.9-bullseye

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

RUN python3.9 -m pip install --upgrade pip setuptools wheel
RUN python3.9 -m pip uninstall -y numpy
RUN python3.9 -m pip install numpy==1.21.6

COPY . .

RUN python3.9 -m pip install --no-cache-dir -U -r requirements.txt

CMD ["python3.9", "main.py"]
