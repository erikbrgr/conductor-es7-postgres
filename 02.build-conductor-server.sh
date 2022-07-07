#!/bin/sh

# Display commands and exit on error
set -ex 

# Copy config and startup files
cp -rv docker/config/ conductor/docker/server/
cp -rv docker/bin/ conductor/docker/server/

cd conductor/docker

# Build Conductor Server
docker build -t conductor:server -f server/Dockerfile ../