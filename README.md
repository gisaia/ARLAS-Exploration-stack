# ARLAS Exploration Stack

This projects contains reference docker compose files for all the ARLAS microservices and third party services for running the ARLAS Stack. It also contains the script for starting the stack in different modes:
- simple : ARLAS without authentication, on HTTP
- with ARLAS Identity and Access Management (ARLAS IAM), on HTTPS
- with ARLAS IAM and ARLAS AIAS (ARLAS Item and Asset Services) for managing EO products for instance. [WORK IN PROGRESS]

# ARLAS Simple deployment

The simple deployment has:
- [apisix](https://apisix.apache.org/)
- [arlas-wui](https://github.com/gisaia/ARLAS-wui)
- [arlas-hub](https://github.com/gisaia/ARLAS-wui-hub)
- [arlas-builder](https://github.com/gisaia/ARLAS-wui-builder)
- [arlas-persistence-server](https://github.com/gisaia/ARLAS-persistence)
- [arlas-permissions-server](https://github.com/gisaia/ARLAS-permissions)
- [arlas-server](https://github.com/gisaia/ARLAS-server)
- [elasticsearch](https://github.com/elastic/elasticsearch)


## Start
To start the ARLAS stack in simple mode, run: 
```shell
./start.sh
```

Once started, you can open ARLAS in your browser: [http://localhost/](http://localhost/).
You can add a sample data set and a configured dashboard by running:

## Test

```shell
pip3.10 install arlas-cli
./scripts/init_arlas_cli_confs.sh
./scripts/init_stack_with_data.sh local
```

A simple dashboard with AIS data is then available.

## Stop

Stop the stack with `./stop.sh`. 

Note: by default, data are persisted in `${PWD}/tmp/`. User `scripts/reset_data.sh` to clean the `${PWD}/tmp/` subdirectories, once the stack stoped.

# ARLAS IAM deployment

The IAM deployment has:
- [apisix](https://apisix.apache.org/)
- [arlas-wui-iam](https://github.com/gisaia/ARLAS-wui-iam)
- [arlas-iam-server](https://github.com/gisaia/ARLAS-IAM)
- [postgres](https://www.postgresql.org/)
- [arlas-wui](https://github.com/gisaia/ARLAS-wui)
- [arlas-hub](https://github.com/gisaia/ARLAS-wui-hub)
- [arlas-builder](https://github.com/gisaia/ARLAS-wui-builder)
- [arlas-persistence-server](https://github.com/gisaia/ARLAS-persistence)
- [arlas-permissions-server](https://github.com/gisaia/ARLAS-permissions)
- [arlas-server](https://github.com/gisaia/ARLAS-server)
- [elasticsearch](https://github.com/elastic/elasticsearch)

To start, run: 
```shell
./start.sh iam
```
Once started, you can open ARLAS in your browser: [https://localhost/](https://localhost/).
You can add a sample data set and a configured dashboard by running:

```shell
pip3.10 install arlas-cli
./scripts/init_arlas_cli_confs.sh
./scripts/init_stack_with_data.sh local.iam.admin
```

A simple dashboard with AIS data is then available.

# Configuration

A significant number of parameters can be configured. Parameters are configured in the environement files located in the [conf/](conf/) directory.

[Simple ARLAS Stack configuration](docker_compose_services_simple.md):
- conf/apisix.env: configuration of APISIX gateway
- conf/arlas.env: general parameters of ARLAS Server
- conf/elastic.env: configuration of elasticsearch
- conf/permissions.env: configurartion of the service delivering permission descriptions
- conf/persistence-file.env and conf/persistence-postgres.env: configuration of the persistence services
- conf/restart_strategy.env: configuration of the restart strategy for every service
- conf/stack.env: general parameters of the stack
- conf/versions.env: version of every single service (docker image)

[ARLAS with IAM configuration](docker_compose_services_iam.md):
- conf/arlas_iam.env: configuration of the IAM
- conf/arlas.env: general parameters of ARLAS Server
- conf/elastic.env: configuration of elasticsearch
- conf/permissions.env: configurartion of the service delivering permission descriptions- 
- conf/persistence-file.env and conf/persistence-postgres.env: configuration of the persistence services
- conf/restart_strategy.env: configuration of the restart strategy for every service
- conf/stack.env: general parameters of the stack
- conf/versions.env: version of every single service (docker image)

ARLAS Items and Assets Services (aias) Stack:
- conf/aias.env: configuration of AIAS
- conf/aproc.env: configuration of the processing (download / ingest)
- conf/arlas.env: general parameters of ARLAS Server
- conf/elastic.env: configuration of elasticsearch
- conf/minio.env: configuration of the minio object store
- conf/permissions.env: configurartion of the service delivering permission descriptions
- conf/persistence-file.env and conf/persistence-postgres.env: configuration of the persistence services
- conf/restart_strategy.env: configuration of the restart strategy for every service
- conf/stack.env: general parameters of the stack
- conf/versions.env: version of every single service (docker image)

