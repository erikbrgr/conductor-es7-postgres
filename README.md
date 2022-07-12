Contains the scripts to confgure Netflix Conductor to use Elasticsearch 7 and a local instance of PostgreSQL. 

Details on the implementation can be found in the article [Running Netflix Conductor 3 in Docker using Elasticsearch 7 and PostgreSQL](https://betterprogramming.pub/running-netflix-conductor-3-in-docker-using-elasticsearch-7-and-postgresql-b415988dd74a) on Medium.

### Component versions

| Component | Version |
|--|--|
| Conductor | 3.9.2 |
| Elasticsearch | 7.10.2 (Opensearch 1.2) 
| PostgreSQL | 11 |

### How to run locally

From the root directory:

1. Run `01.get-conductor.sh`. This will download the correct version of Conductor from GitHub and apply patches.
2. Run `02.build-conductor-server.sh`. This will copy the config files from the `docker/config` directory and build the Conductor Server image.
3. Run `03.build-conductor-ui.sh`. This will build the Conductor UI image.
4. Run either `04.run-local.sh` or `04.run-local-postgres.sh`.
      
   `run-local` runs against an in-memory database, so data is lost when the server terminates. This configuration is useful for testing or demo only.

   `run-local-postgres` runs Conductor against your local instance of PostgreSQL. On the PostgreSQL instance, you will need to initialize a user, password and create database for conductor to use

The files `docker-compose.yaml` and `docker-compose-postgres.yaml` define the required environment variables to connect to Elasticsearch and PostgreSQL.

`Ctrl+c` will exit docker compose.

To ensure images are stopped and removed, execute: `docker-compose down`.

### How to run on Kubernetes

To run using bare kubernetes cli, use the `k8s/components` directory YAML files and apply them to your cluster.
To run using Helm, `cd` to the `k8s/helm` directory and run, change `values.yaml.public` to be `values.yaml` and define your settings, then run: `helm install conductor-server conductor-server --namespace conductor` 

### TODOs

* For those wishing to use deployed Postgres server, there is a possibility create server init sql scripts that would initialize the conductor used user/passwd and create the conductor database

