# Use NVIDIA’s CUDA 12.8 runtime on Ubuntu 22.04
FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04

# Prevent prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# Install common build tools (add or remove packages as you like)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      git \
      python3 \
      python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Ensure CUDA binaries & libraries are on the PATH
ENV PATH=/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}

WORKDIR /app
RUN git clone https://github.com/Project-Babble/ProjectBabble.git
WORKDIR /app/ProjectBabble/BabbleApp
RUN git revert --no-commit 50d03ce # Use old model

RUN apt-get update && \
    apt-get install -y python3-tk \
    xvfb \
    libglib2.0-0 \
    libportaudio2

RUN apt-get update && \
    apt-get install -y vim
    
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -r requirements.txt
COPY app.py .
VOLUME ["/root/.cache/pip"]

## CUDA SUPPORT
RUN pip uninstall -y onnxruntime onnxruntime-gpu
RUN pip install onnxruntime-gpu


COPY babble_settings.json .
COPY . /app

# CMD ["xvfb-run", "-a", "-s", "-screen 0 1280x1024x24", "python3", "/app/ProjectBabble/BabbleApp/babbleapp.py"]
CMD ["python3", "babbleapp.py"]
# CMD ["bash"]