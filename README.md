A repository aiming at allowing to easily run ARLAS locally, for developing purposes.

**Table of content**

[Usage](#usage)
- [Prerequisites](#prerequisites)
- [Initial setup](#initial-setup)
- [Run](#run)
  - [With your own elasticsearch deployment](#with-your-own-elasticsearch-deployment)
- [Initialization](#initialization)
  - [Data-specific initialization](#data-specific-initialization)
    - [ais-danmark](#ais-danmark)
      - [With your own elasticsearch deployment](#with-your-own-elasticsearch-deployment-1)
[Development](#development)
- [Data initialization](#data-initialization)
  - [ais-danmark](#ais-danmark-1)

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
docker-compose pull; docker-compose up -d
```

*Note: by default, docker-compose does not pull latest version of docker images, when deploying, hence why the `docker-compose pull`.*

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
docker-compose pull; docker-compose -f docker-compose.yml up -d
```

To shut it down:

```
docker-compose -f docker-compose.yml down
```

## Initialization

We provide a docker image, `gisaia/arlas-init-base`, for initializing ARLAS. It supports the following environment variables:

| Environment Variable | | Description |
| - | - | - |
| `data_file` | | Path to the file containing the data, inside the container. |
| `elasticsearch` | | elsaticsearch server. |
| `elasticsearch_index` | | Name of the elasticsearch index where to ingest the data. |
| `elasticsearch_mapping` | | Path to the elasticsearch mapping json file for index creation. |
| `elasticsearch_password` | optional | Goes with `elasticsearch_user`. |
| `elasticsearch_user` | optional | Goes with `elasticsearch_password`. |
| `logstash_configuration` | | Path to the logstash configuration file for data ingestion into elasticsearch. |
| `server` | | ARLAS server. |
| `server_collection` | | |
| `server_collection_name` | | |
| `WUI_configuration` | | Path to the general configuration file for ARLAS-WUI, inside the container. |
| `WUI_map_configuration` | | Path to the map configuration file for ARLAS-WUI, inside the container. |

### Data-specific initialization

We provide some data-specific initialization with pre-built docker images inheriting from `gisaia/arlas-init-base`.

#### ais-danmark

It should take ~2mn:

```bash
time docker run -e elasticsearch="http://elasticsearch:9200" \
    -e server="http://arlas-server:9999" \
    --net arlas \
    --rm \
    --mount type=volume,src=arlasstack_wui-configuration,dst=/wui-configuration \
    gisaia/arlas-init-ais-danmark
```

##### With your own elasticsearch deployment

In the above command, just change the value of environment variable `ELASTICSEARCH` to point to a single server of your elasticsearch cluster, and the elasticsearch-related part of the initialization will be performed against your custom cluster.

# Development

## Data initialization

Sources for docker image `gisaia/arlas-init-base` are found in [initialization/base](initialization/base). Build instructions:

```bash
cd initialization/base; docker build -t gisaia/arlas-init-base .; cd -
```

### ais-danmark

Sources for docker image `gisaia/arlas-init-ais-danmark` are found in [initialization/ais-danmark](initialization/ais-danmark). Build instructions:

```bash
cd initialization/ais-danmark; docker build -t gisaia/arlas-init-ais-danmark .; cd -
```

Beware, this image inherits from `gisaia/arlas-init-base`, so if you make change to the latter, rebuild `gisaia/arlas-init-ais-danmark` for the changes to take effect.