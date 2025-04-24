#!/bin/sh

# Name of the Docker image
IMAGE_NAME="dockered-babble"

# Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# Run the Docker container
echo "Running the container..."
docker run --network host --gpus=all --shm-size=1g -it $IMAGE_NAME