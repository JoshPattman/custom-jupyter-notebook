#!/bin/bash

usegpu=false

# Create directory for docker building
rm -f -d -r ./temp
mkdir ./temp

# Copy the dockerfile and entrypoint
cp ./docker-src/entrypoint.sh ./temp/entrypoint.sh
cp ./docker-src/Dockerfile ./temp/Dockerfile

# Remove gpu from dockerfile if we dont want it
if [ $usegpu = false ]; then
    sed -i 's/-gpu//g' ./temp/Dockerfile
fi

# Build docker
docker build -t custom-jupyter-notebook ./temp

# Clean temp building directory
rm -f -d -r ./temp



# Clean current bin directory
rm -f -d -r ./bin
mkdir ./bin

# Copy the bash files
cp ./bin-src/jupyter-nb ./bin/jupyter-nb
cp ./bin-src/jupyter-nb-sh ./bin/jupyter-nb-sh
cp ./bin-src/mounts.txt ./bin/mounts.txt

# Remove gpu flag if not using gpu
if [ $usegpu = false ]; then
    sed -i 's/--gpus all//g' ./bin/jupyter-nb
fi

# Make executable
chmod +x ./bin/jupyter-nb
chmod +x ./bin/jupyter-nb-sh