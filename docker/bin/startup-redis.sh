#!/bin/sh

# startup-redis.sh - startup script for the server docker image with redis config

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

echo "ELASTICSEARCH_URL: $ELASTICSEARCH_URL"
echo "REDIS_ADDRPORT:    $REDIS_ADDRPORT"
echo "REDIS_MODE:        $REDIS_MODE"
echo "REDIS_ZONE1:       $REDIS_ZONE1"
echo "REDIS_USE_SSL:     $REDIS_USE_SSL"

sed -i "s;##ELASTICSEARCH_URL##;$ELASTICSEARCH_URL;" $config_file
sed -i "s;##REDIS_ADDRPORT##;$REDIS_ADDRPORT;" $config_file
sed -i "s;##DB_PASSWORD##;$DB_PASSWORD;" $config_file
sed -i "s;##REDIS_MODE##;$REDIS_MODE;" $config_file
sed -i "s;##REDIS_ZONE1##:$REDIS_ZONE1;" $config_file
sed -i "s;##REDIS_USE_SSL##:$REDIS_USE_SSL;" $config_file

echo "Using java options config: $JAVA_OPTS"

java ${JAVA_OPTS} -jar -DCONDUCTOR_CONFIG_FILE=$config_file conductor-server-*-boot.jar 2>&1 | tee -a /app/logs/server.log
