#!/bin/sh

cd /home/botserver/scripts/docker/DockeredBabble

# Name of the Docker image
IMAGE_NAME="dockered-babble"

# Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

docker stop babble
docker remove babble

# Run the Docker container
echo "Running the container..."
docker compose up -d
