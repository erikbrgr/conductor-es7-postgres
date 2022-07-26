#!/bin/sh

CONDUCTOR_VERSION=$1

# Display commands and exit on error
set -ex 

cd conductor-$CONDUCTOR_VERSION/docker

docker build -t conductor:ui -f ui/Dockerfile ../