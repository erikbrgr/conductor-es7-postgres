Contains the scripts to confgure Netflix Conductor to use Elasticsearch 6 and a local instance of Redis6.

This repo is a fork that was built to support ES7 and PostgreSQL. 
However, while trying to improve this repo in this fork, I found out that the community libraries that provide Postgres support are either broken or fail their build tests and effectively are lagging behind the main project. 
I therefore decided to **abandon** the support for anything comming out of the conductor-community repo as I don't consider it "production grade" artifact.
This repo does support switching (currently, between v3.9.2 to v3.10.0) condcutor versions and using either docker-compose Redis+ES6 or memory+w/o indexing. 
Additionally, I've patched the conductor Dockerfile so that it would use the Adoptium JDK/JRE 11 base images, unlike the original Dockerfile that uses deprecated open-jdk/jre images.

### Component versions

| Component | Version |
|--|--|
| Conductor | 3.9.2, 3.10.0 |
| Elasticsearch | 6.8.15 (Opensearch 1.2) 
| Redis | 6 |

### How to run locally

NOTE: Building of images on MacOS with M1 processors (Docker platform of `linux/aarm64`) results in broken images. 
It is therefore advised to build the server/ui images on a Linux machine or by specifying that your Docker platform is `linux/amd64` - this however results in extremly long build times. 
To run the included docker-compose yamls (that the 04 scripts run) on your M1, it is mandatory to set `export DOCKER_DEFAULT_PLATFORM=linux/amd64` if you've built the images on Linux (so actually there is no other way effectively other than to build on Linux). 
Unset this envvar if you wish to continue building and consuming Docker images that are not native to your M1 MacOS.

From the root directory:

1. Run `01.get-conductor.sh v3.10.0`. This will download the v3.10.0 version of Conductor from GitHub and apply patches.
2. Run `02.build-conductor-server.sh v3.10.0 redis`. This will copy the config files from the `docker/config` directory, take the start-redis.sh script and put it under /app/startup.sh, and build the Conductor Server image corresponding to the name `conductor-server-redis:v3.10.0`.
3. Run `03.build-conductor-ui.sh`. This will build the Conductor UI image.
4. Run either `04.run-local.sh` or `04.run-local-redis.sh`.
      
   `run-local` runs against an in-memory database, so data is lost when the server terminates. This configuration is useful for testing or demo only.

   `run-local-redis` runs Conductor against your local instance of Redis6. On the Redis6 instance

The files `docker-compose.yaml` and `docker-compose-redis.yaml` define the required environment variables to connect to Elasticsearch and Redis.

`Ctrl+c` will exit docker compose.

To ensure images are stopped and removed, execute: `docker-compose down`.

### How to run on Kubernetes

To run using bare kubernetes cli, use the `k8s/components` directory YAML files and apply them to your cluster.
To run using Helm, `cd` to the `k8s/helm` directory and run, change `values.yaml.public` to be `values.yaml` and define your settings, then run: `helm install conductor-server conductor-server --namespace conductor` 
