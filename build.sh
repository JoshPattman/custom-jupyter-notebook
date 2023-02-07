#!/bin/bash

if [[ -z "${USE_GPU}" ]]; then
  USE_GPU=false
fi

if [ $USE_GPU = false ]; then
    echo "Not using GPU support. To use GPU re run with env variable 'USE_GPU=true'"
else
    echo "Using GPU support"
fi

echo "Creating docker files"
# Create directory for docker building
rm -f -d -r ./temp
mkdir ./temp

# Copy the dockerfile and entrypoint
cp ./docker-src/entrypoint.sh ./temp/entrypoint.sh
cp ./docker-src/Dockerfile ./temp/Dockerfile

# Remove gpu from dockerfile if we dont want it
if [ $USE_GPU = false ]; then
    sed -i 's/-gpu//g' ./temp/Dockerfile
fi

echo "Building docker"
# Build docker
docker build -t custom-jupyter-notebook ./temp

# Clean temp building directory
rm -f -d -r ./temp


echo "Building bin files"
# Create bin directory if not exist
mkdir -p ./bin

# Copy the bash files
cp ./bin-src/jupyter-nb ./bin/jupyter-nb
cp ./bin-src/jupyter-nb-sh ./bin/jupyter-nb-sh
# Copy config files if not already exist
cp -n ./bin-src/mounts.txt ./bin/mounts.txt
cp -n ./bin-src/password.txt ./bin/password.txt

# Remove gpu flag if not using gpu
if [ $USE_GPU = false ]; then
    sed -i 's/--gpus all//g' ./bin/jupyter-nb
fi

# Make executable
chmod +x ./bin/jupyter-nb
chmod +x ./bin/jupyter-nb-sh

echo "Now add the ./bin directory to path or symlink it or something"