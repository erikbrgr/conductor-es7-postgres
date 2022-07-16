#!/bin/sh

# startup.sh - startup script for the server docker image

echo "Automatically injected to running container"
echo "Starting Conductor server"

# Start the server
cd /app/libs
echo "Property file: $CONFIG_PROP"
echo $CONFIG_PROP
export config_file=

if [ -z "$CONFIG_PROP" ];
  then
    echo "CONFIG_PROP not set. Using an in-memory instance of conductor";
    export config_file=/app/config/config-local.properties
  else
    echo "Using $CONFIG_PROP";
    export config_file=/app/config/$CONFIG_PROP
fi

cp /props/injected.properties /app/config/$CONFIG_PROP
echo "Using java options config: $JAVA_OPTS"

java ${JAVA_OPTS} -jar -DCONDUCTOR_CONFIG_FILE=$config_file conductor-server-*-boot.jar 2>&1 | tee -a /app/logs/server.log
