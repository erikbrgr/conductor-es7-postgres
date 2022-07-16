#!/bin/sh

cd docker/

#docker-compose -f docker-compose.yaml -f docker-compose-redis.yaml up -d redis
#docker-compose -f docker-compose.yaml -f docker-compose-redis.yaml up -d elasticsearch
docker-compose -f docker-compose.yaml -f docker-compose-redis.yaml up 
