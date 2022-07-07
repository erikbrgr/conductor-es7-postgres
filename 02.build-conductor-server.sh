#!/bin/sh

# Display commands and exit on error
set -ex 

# Copy config and startup files
#rm -rf conductor/docker/server/config
#rm -rf conductor/docker/server/bin

cp -rv docker/config/ conductor/docker/server/config/
cp -rv docker/bin/ conductor/docker/server/bin/
cd conductor
./gradlew generateLock updateLock saveLock

cd docker

# Build Conductor Server
docker build -t conductor:server -f server/Dockerfile ../
