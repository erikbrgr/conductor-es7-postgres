#!/bin/sh

# Display commands and exit on error
set -ex 

cd conductor/docker

docker build -t conductor:ui -f ui/Dockerfile ../