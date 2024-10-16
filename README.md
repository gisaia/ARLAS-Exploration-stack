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
- [protomaps](https://protomaps.com/)


## Start
To start the ARLAS stack in simple mode, run: 
```shell
./start.sh
```

Once started, you can open ARLAS in your browser: [http://localhost/](http://localhost/). If you changed `ARLAS_HOST` in `conf/stack.env`, then open instead http://${ARLAS_HOST} .
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

Note: by default, data are persisted in docker volumes prefixed with `arlas-test- ...`. To reset the volumes, run:

```shell
docker volume rm arlas-test-data-es arlas-test-persist arlas-test-postgres
```

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
- [protomaps](https://protomaps.com/)

To start, run: 
```shell
./start.sh iam
```
Once started, you can open ARLAS in your browser: [https://localhost/](https://localhost/). If you changed `ARLAS_HOST` in `conf/stack.env`, then open instead https://${ARLAS_HOST} .
You can add a sample data set and a configured dashboard by running:

```shell
pip3.10 install arlas-cli
./scripts/init_arlas_cli_confs.sh
./scripts/init_stack_with_data.sh local.iam.admin
```

A simple dashboard with AIS data is then available. You can login with:
- username: `user@org.com`
- password: `secret`
or as admin:
- username: `tech@gisaia.com`
- password: `admin`

# ARLAS AIAS deployment

The AIAS (ARLAS Item and Asset Services) deployment has:
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
- [agate](https://github.com/gisaia/aias)
- [fam](https://github.com/gisaia/aias)
- [fam-wui](https://github.com/gisaia/aias)
- [aproc-service](https://github.com/gisaia/aias)
- [aproc-proc](https://github.com/gisaia/aias)
- [elasticsearch](https://github.com/elastic/elasticsearch)
- [protomaps](https://protomaps.com/)
- [minio](https://min.io)
- [redis](https://redis.io)
- [rabbitmq](https://www.rabbitmq.com)

To start, run: 
```shell
./start.sh aias
```

You can access ARLAS just like the IAM deployement. You can also use the same script for initializing the stack with users and data.

To setup an ARLAS EO catalog:
1) place some geotiff files in ${APROC_INPUT_DIR} configured in [conf/aias.env](conf/aias.env). 
2) Go to the web page of ARLAS, then click the **Import** link (top right menu). This brings you to the import page. Add the geotiff file in the catalog by clicking on the + icon next to the tiff file.
3) once added, run :

`./scripts/init_aias_catalog.sh local.iam.user catalog airs_main` 

This will init the collection and the dashboard for the catalog.


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

[ARLAS Items and Assets Services (aias) configuration][]:
- same as ARLAS IAM and ...
- conf/aias.env: configuration of AIAS
- conf/minio.env: configuration of the minio object store

## Host and domain

By default, the stack is deployed on `http(s)://localhost/`. To deploy the ARLAS Stack on a different domain, simply change the `ARLAS_HOST` environement variable in [conf/stack.env](conf/stack.env):
```shell
ARLAS_HOST=localhost
````

If you are using `arlas_cli` you need to run `scripts/init_arlas_cli_confs.sh` to create again the `arlas_cli` configuration file.

## Variables

The current configurations are for tests only. These variables have to be changed for storing the data in reliable places:
- `ELASTIC_STORAGE` (`conf/elastic.env`)
- `ARLAS_PERSISTENCE_STORAGE` (`conf/persistence-file.env`)
- `POSTGRES_STORAGE` (`conf/postgres.env`)
- `POSTGRES_BACKUP_STORAGE` (`conf/postgres.env`)

And for AIAS:
- `APROC_DOWNLOAD_DIR` (`conf/aias.env`)
- `APROC_INPUT_DIR` (`conf/aias.env`)
- `APROC_EMAIL_PATH_PREFIX_ADD` (`conf/aias.env`)

## Developers

To release, run:
```shell
./scripts/release.sh X.Y
```
where `X.Y` is the version of the stack. `X` must be aligned with the majar version ARLAS (WUI and Server) while `Y` is the increment of the stack.

To update the version of the dependencies, such as ARLAS containers, edit `conf/versions.env`.

## Basemap

The basemap provided with the ARLAS Stack is the first zoom levels of protomaps. [Download](https://maps.protomaps.com/builds/) and replace [conf/protomaps/world.pmtiles](conf/protomaps/) to get all zoom levels.
