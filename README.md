A repository aiming at allowing to easily run ARLAS locally, for developing purposes.

**Table of content**

- [Usage](#usage)
  - [Prerequisites](#prerequisites)
  - [Initial setup](#initial-setup)
  - [Run](#run)
    - [With your own elasticsearch deployment](#with-your-own-elasticsearch-deployment)
  - [[OPTIONAL] Initialize ARLAS with AIS-danmark data (ships positions)](#optional-initialize-arlas-with-ais-danmark-data-ships-positions)
    - [With your own elasticsearch deployment](#with-your-own-elasticsearch-deployment-1)
- [Development](#development)
  - [Build data-initialization docker image](#build-data-initialization-docker-image)

# Usage

## Prerequisites

- [Docker CE](https://docs.docker.com/install/) (Community Edition)
- [Docker Compose](https://docs.docker.com/compose/install/) >= 1.13.0

## Initial setup

*Note: It is required to manually create a docker network, on which all ARLAS containers will run. The default Docker Compose network does not allow external containers (ex: data-initialization container) to use container-names resolution.*

Create a dedicated docker network:

```bash
docker network create arlas
```

You can remove it anytime with the following command:

```bash
docker network rm arlas
```

## Run

To start ARLAS:

```bash
docker-compose up -d
```

You should now be able to access it @ http://localhost

To shut down ARLAS:

```bash
docker-compose down
```

### With your own elasticsearch deployment

By default, ARLAS-stack runs an embedded elasticsearch container. You can choose not to deploy it, and instead connect ARLAS to your own elasticsearch deployment.

1<sup>st</sup>, you need to configure ARLAS to connect to your elasticsearch cluster. Change values of environment variables `ARLAS_ELASTIC_CLUSTER` & `ARLAS_ELASTIC_HOST` for service `arlas-server`, in file `docker-compose.yml`.

You can then run ARLAS without embedded elasticsearch with the following commands:

```
docker-compose -f docker-compose.yml up -d
```

To shut it down:

```
docker-compose -f docker-compose.yml down
```

## [OPTIONAL] Initialize ARLAS with AIS-danmark data (ships positions)

```bash
time docker run -e ELASTICSEARCH="http://elasticsearch:9200" \
    -e ARLAS_SERVER="http://arlas-server:9999" \
    --net arlas \
    --rm \
    --mount type=volume,src=arlasstack_wui-configuration,dst=/wui-configuration \
    arlas-ais-danmark-init
```

### With your own elasticsearch deployment

In the above command, just change the value of environment variable `ELASTICSEARCH` to point to a single server of your elasticsearch cluster, and the elasticsearch-related part of the initialization will be performed against your custom cluster.

# Development

## Build data-initialization docker image

```bash
cd initialization/ais-danmark
docker build -t arlas-ais-danmark-init .
cd -
```
