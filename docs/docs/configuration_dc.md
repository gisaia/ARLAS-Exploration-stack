# Configuration

## Configuration files

A significant number of parameters can be configured. Parameters are configured in the environment files located in the `conf/` directory.

To change the values, __do not edit the .env files__, simply set the values you want in `conf/custom.env`. For instance, the first thing you want to add in `conf/custom.env` is:

```shell
ARLAS_HOST=mydomain.com
```


### Common files

- `conf/arlas.env`: General parameters of ARLAS Server
- `conf/elastic.env`: Configuration of elasticsearch
- `conf/permissions.env`: Configuration of the service delivering permission descriptions
- `conf/persistence-file.env` and `conf/persistence-postgres.env`: Configuration of the persistence services
- `conf/restart_strategy.env`: Configuration of the restart strategy for every service
- `conf/stack.env`: General parameters of the stack
- `conf/versions.env`: Version of every single service (docker image)


### Simple deployment

All [common files](#common-files) and:

- `conf/apisix.env`: Configuration of APISIX gateway

See [Simple ARLAS Stack configuration](dc_services/docker_compose_services_simple.md)

### IAM deployment

All [common files](#common-files) and:

- `conf/arlas_iam.env`: Configuration of the IAM

See [ARLAS with IAM configuration](dc_services/docker_compose_services_iam.md)

### Keycloak deployment

All [common files](#common-files) and:

- `conf/arlas_keycloak.env`: Configuration of Keycloak for ARLAS

See [ARLAS with Keycloak configuration](dc_services/docker_compose_services_kc.md)

### AIAS deployment

Same as [IAM deployment](#iam-deployment) and:

- `conf/aias.env`: Configuration of AIAS
- `conf/minio.env`: Configuration of the minio object store

See [ARLAS Items and Assets Services (AIAS) configuration](dc_services/docker_compose_services_aias.md)

### AIAS with Keycloak deployment

Same as [Keycloak deployment](#keycloak-deployment) and:

- `conf/aias.env`: Configuration of AIAS
- `conf/minio.env`: Configuration of the minio object store

See [ARLAS Items and Assets Services (AIAS) configuration with Keycloak](dc_services/docker_compose_services_aiaskc.md)

## Host and domain

By default, the stack is deployed on `http(s)://localhost/`. To deploy the ARLAS Stack on a different domain, simply change the `ARLAS_HOST` environment variable in `conf/stack.env`:

```shell
ARLAS_HOST=mydomain.com
```

If you are using `arlas_cli` and you updated the `$ARLAS_HOST` variable, then you need to run `scripts/init_arlas_cli_confs.sh` to create again the `arlas_cli` configuration file.

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


## Basemap

The basemap provided with the ARLAS Stack is the first zoom levels of protomaps. You can build your own:

```shell
pmtiles extract https://build.protomaps.com/20231225.pmtiles world.pmtiles --minzoom=0 --maxzoom $MAX_ZOOM
```

and mount it in arlas-wui container in `/usr/share/nginx/html/assets/basemap/data/world.pmtiles`.