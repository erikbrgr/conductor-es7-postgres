#!/bin/sh

# Display commands and exit on error
set -ex 

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "1 argument, specifying conductor tag in the format of vX.Y.Z is required, $# provided"

CONDUCTOR_VERSION=$1

# Remove the conductor folder so we start fresh
rm -rf ./conductor-$CONDUCTOR_VERSION

# Get Conductor
git clone -c advice.detachedHead=false -c core.autocrlf=false --depth 1 -b ${CONDUCTOR_VERSION} https://github.com/Netflix/conductor.git ./conductor-$CONDUCTOR_VERSION

cd ./conductor-$CONDUCTOR_VERSION

# Apply patches
# Update to es7
git apply ../${CONDUCTOR_VERSION}/persistence_index.patch
#### Set ownerEmailMandatory to false
git apply ../${CONDUCTOR_VERSION}/ownerEmailmandatory-to-false.patch
#### "Clean" changes made by patches so, if we make new changes, we can easily create another patch
git commit -a -m "Applied patches"

cp -rf ../docker .
