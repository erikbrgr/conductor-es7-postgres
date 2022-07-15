#!/bin/sh

# Display commands and exit on error
set -ex 

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "1 argument, specifying conductor tag in the format of vX.Y.Z is required, $# provided"

CONDUCTOR_VERSION=$1


# Copy config and startup files
cd conductor-$CONDUCTOR_VERSION/docker
# Build Conductor Server
docker build -t conductor:server -f server/Dockerfile ../
