# Da Conductor

Contains the [Netflix Conductor](https://github.com/Netflix/conductor) instance for the Data Analytics DWH project.

### Components

| Component | Version |
|--|--|
| Conductor | 3.5.1 |
| Elasticsearch | 7.17.1 |


### Database

| | |
|--|--|
| Database | db06 |
| Schema |   daconductor |
| Username | daconductor_owner |

The `database` folder contains the create script (`dba-createapp-db.sh`) to create the tablespace, schema and users. This can be used to create a local instance of the `daconductor` schema. Running the script without setting the `DB_ENV` environment assumes you want to create the database locally.

> [This link](https://git02.mgt.lan/data-analytics/docs/-/blob/master/database.md) describes how to set up a local PostgreSQL database matching the configuration on the different environments.

### How to run locally

From the root directory:

1. Run `01.get-conductor.sh`. This will download the correct version of Conductor from GitHub and apply patches.
2. Run `02.build-conductor-server.sh`. This will copy the config files from the `docker/config` directory and build the Conductor Server image.
3. Run `03.build-conductor-ui.sh`. This will build the Conductor UI image.
4. Run either `04.run-local.sh` or `04.run-local-postgres.sh`.
      
   `run-local` runs against an in-memory database, so data is lost when the server terminates. This configuration is useful for testing or demo only.

   `run-local-postgres` runs Conductor against your local instance of PostgreSQL.

The files `docker-compose.yaml` and `docker-compose-postgres.yaml` define the required environment variables to connect to Elasticsearch and PostgreSQL.

`Ctrl+c` will exit docker compose.

To ensure images are stopped and removed, execute: `docker-compose down`.