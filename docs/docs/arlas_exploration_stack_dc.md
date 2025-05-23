
# ARLAS Exploration Stack with Docker compose

## Run ARLAS stack

To run ARLAS stack, clone the [ARLAS Exploration Stack](https://github.com/gisaia/ARLAS-Exploration-stack) project and follow the guidelines.

```shell
git clone git@github.com:gisaia/ARLAS-Exploration-stack.git
cd ARLAS-Exploration-stack
```

### Simple deployment

**Start**

To start the ARLAS stack in simple mode, run: 
```shell
./start.sh
```

!!! success
    Once started, you can open ARLAS in your browser: [http://localhost/](http://localhost/). 

!!! note
    If you changed `ARLAS_HOST` in `conf/stack.env`, then open instead http://${ARLAS_HOST} .

**Test**

You can add a sample data set and a configured dashboard by running:

```shell
pip3.10 install arlas-cli
./scripts/init_arlas_cli_confs.sh
./scripts/init_stack_with_data.sh local
```

!!! success
    A simple dashboard with AIS data is then available.


### IAM deployment

**Start**

To start, run: 
```shell
./start.sh iam
```

!!! success
    Once started, you can open ARLAS in your browser: [https://localhost/](https://localhost/). 

!!! note
    If you changed `ARLAS_HOST` in `conf/stack.env`, then open instead https://${ARLAS_HOST} .

**Test**

You can add a sample data set and a configured dashboard by running:

```shell
pip3.10 install arlas-cli
./scripts/init_arlas_cli_confs.sh
./scripts/init_stack_with_data.sh local.iam.admin
```

!!! success
    A simple dashboard with AIS data is then available. 

You can login with:

- username: `user@org.com`
- password: `secret`

or as admin:

- username: `tech@gisaia.com`
- password: `admin`

!!! warning
    when using IAM, users can create collections only on indices prefixed with their organisation's name followed by `@`. 

    For instance, a user in the organisation `gisaia.com`, who creates an index containing car gps data can name the index `gisaia.com@car_gps_locations`.

### AIAS deployment

**Start**

To start, run: 
```shell
./start.sh aias
```

You can access ARLAS just like the [IAM deployment](#iam-deployment). You can also use the same script for initializing the stack with users and data.

#### EO Catalog

To setup an ARLAS EO catalog:

1. Place some geotiff files in `${APROC_INPUT_DIR}` configured in `conf/aias.env`. 

2. Go to the web page of ARLAS, then click the **Import** link (top right menu). This brings you to the import page. Add the geotiff file in the catalog by clicking on the + icon next to the tiff file. This will create and automatically feed an index named `org.com@airs_catalog`.
3. Once added, run :

```shell
./scripts/init_aias_catalog.sh local.iam.user catalog org.com
```

This will init the collection and the dashboard for the catalog.

!!! warning "Naming Convention"
    The index name has the form `org`@airs_`name`

    For instance, the collection "geodes" for the organisation "org.com" has its index in "org.com@airs_geodes"

#### Data from GEODES

You can register data from GEODES:

```shell
docker run --rm --network arlas-net gisaia/stac-geodes:latest add https://geodes-portal.cnes.fr/api/stac/items http://airs-server:8000/airs geodes S2L1C --start-date "2023-04-05T08:58:40.737+00:00" --max 1000
```

This will register in the `org.com@airs_geodes` index the first 1000 `S2L1C` data that were acquired after 2023-04-05T08:58. 

Then, you can create the catalog:

```shell
./scripts/init_aias_catalog.sh local.iam.user geodes org.com
```

## Stop ARLAS stack

Stop the stack with `./stop.sh`. 

!!! note
    By default, data are persisted in docker volumes prefixed with `arlas-test- ...` 

    To reset the volumes, run:

    ```shell
    docker volume rm arlas-test-data-es arlas-test-persist arlas-test-postgres
    ```