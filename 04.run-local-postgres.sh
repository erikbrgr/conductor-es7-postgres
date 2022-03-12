#!/bin/sh

cd docker/

docker-compose -f docker-compose.yaml -f docker-compose-postgres.yaml up