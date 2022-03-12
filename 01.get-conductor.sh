#!/bin/sh

CONDUCTOR_VERSION=v3.5.1

# Display commands and exit on error
set -ex 

# Remove the conductor folder so we start fresh
rm -rf conductor/

# Get Conductor
git clone -c advice.detachedHead=false -c core.autocrlf=false --depth 1 -b ${CONDUCTOR_VERSION} https://github.com/Netflix/conductor.git ./conductor

cd conductor/

# Delete .lock files
rm -f **/dependencies.lock

# Apply patches
# Update to es7
git apply ../${CONDUCTOR_VERSION}-update-to-es7.patch
# Set ownerEmailMandatory to false
git apply ../${CONDUCTOR_VERSION}-ownerEmailmandatory-to-false.patch
# Remove .schemas() call to prevent the currentSchema property in the Postgres connection string being overridden
git apply ../${CONDUCTOR_VERSION}-fix-currentSchema-override.patch
# Update colors so we can distinguish between IN_PROGRESS and SCHEDULED tasks
git apply ../${CONDUCTOR_VERSION}-update-colors.patch
# "Clean" changes made by patches so, if we make new changes, we can easily create another patch
git commit -a -m "Applied patches"
