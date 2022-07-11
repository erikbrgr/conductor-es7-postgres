#!/bin/sh

CONDUCTOR_VERSION=v3.9.2

# Display commands and exit on error
set -ex 

# Remove the conductor folder so we start fresh
rm -rf conductor/

# Get Conductor
git clone -c advice.detachedHead=false -c core.autocrlf=false --depth 1 -b ${CONDUCTOR_VERSION} https://github.com/Netflix/conductor.git ./conductor

cd conductor/

# Delete dependencies.lock files
rm -f **/dependencies.lock
rm -f ./dependencies.lock

# Delete es6-persistence
rm -r es6-persistence

# Apply patches
# Update to es7
git apply ../${CONDUCTOR_VERSION}-update-to-es7.patch
#### Set ownerEmailMandatory to false
git apply ../${CONDUCTOR_VERSION}-ownerEmailmandatory-to-false.patch
#### "Clean" changes made by patches so, if we make new changes, we can easily create another patch
git commit -a -m "Applied patches"
