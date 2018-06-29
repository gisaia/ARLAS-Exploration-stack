This project aims at allowing to deploy & use ARLAS locally, in an easy way. It consists in 2 parts:

**Deploying ARLAS**

The deployment consists of several [docker](https://docker.com) containers tied together using [Docker Compose](https://docs.docker.com/compose)

**Initializing ARLAS with data**

ARLAS has no interest if there is no data (it won't even work). This 2<sup>nd</sup> part of the project allows to easily initialize ARLAS with data, so that you can really use it.

---

# Table of content

[Prerequisites](#prerequisites)

[Usage](#usage)
- [Configuration](#configuration)
  - [Docker Compose `.env` file](#docker-compose-env-file)
  - [Docker Compose `env_file` mechanism](#docker-compose-env_file-mechanism)
- [With an external elasticsearch deployment](#with-an-external-elasticsearch-deployment)

[Initialize ARLAS with data](#initialize-arlas-with-data)
- [Environment variables](#environment-variables)
- [Example: ais-danmark](#example-ais-danmark)
- [Data-specific initialization](#data-specific-initialization)
  - [ais-danmark](#ais-danmark)

[Development](#development)
- [arlas-stack-manager](#arlas-stack-manager)
- [arlas-initializer](#arlas-initializer)
- [arlas-initializer-ais-danmark](#arlas-initializer-ais-danmark)
- [TODO](#todo)

---

# Prerequisites

- [Docker CE](https://docs.docker.com/install/) (Community Edition)

# Usage

```bash
# up
./ARLAS-stack.bash up
# Will expose the UI @ localhost


# down
./ARLAS-stack.bash down
```

## Configuration

### Docker Compose `.env` file

We use [the Docker Compose's `.env` file mechanism](https://docs.docker.com/compose/env-file/) to configure the stack's docker compose. You can find available environment variables in [src/.env](src/.env), with their default values. You can override them by creating & filling a `.env` file at the root of the project.

```bash
touch .env
```

### Docker Compose `env_file` mechanism

We use [the Docker Compose's `env_file` mechanism](https://docs.docker.com/compose/compose-file/#env_file) to populate environment variables inside containers. Each container has its own distinct `env_file` s. Default values are found under [src/environment](src/environment). You can set new values, or override the defaults, by creating & filling files `arlas-server`, `arlas-wui` & `elasticsearch` under [environment](environment).

```bash
touch environment/arlas-server environment/arlas-wui environment/elasticsearch
```

## With an external elasticsearch deployment

By default, ARLAS-stack runs an embedded elasticsearch container. You can choose not to deploy the latter, and instead connect ARLAS to your own elasticsearch deployment.

1<sup>st</sup>, you need to configure ARLAS to connect to your elasticsearch cluster. In [environment/arlas-server](environment/arlas-server), change values for the following environment variables: 

- `ARLAS_ELASTIC_CLUSTER`
- `ARLAS_ELASTIC_HOST`
- `ARLAS_ELASTIC_PORT`

You can then use option `--no-elasticsearch` to launch the ARLAS stack without the embedded elasticsearch:

```bash
# up
./ARLAS-stack.bash --no-elasticsearch up

# down
./ARLAS-stack.bash --no-elasticsearch down
```

# Initialize ARLAS with data

Once you have ARLAS running, you can use our initializer to register data into it. The initializer comes under the form of a docker image: `gisaia/arlas-initializer`.

To be used, it requires to be provided with a certain set of files presented in the table below.

You will have to write them & put them in a single directory, and to [bind-mount](https://docs.docker.com/storage/bind-mounts/) that directory onto the initializer container.

The initializer detects the files by their name, so be sure to respect the nomenclature.

Also, we have implemented an initialization of ARLAS with [AIS](https://en.wikipedia.org/wiki/Automatic_identification_system) data (ships) around Denmark, and the corresponding files are given as examples in the table.

| File name | Description | Example: ais-danmark |
|-|-|-|
| `data` | File containing your data (csv, ...). | [initialization/arlas-initializer-ais-danmark/content/data](initialization/arlas-initializer-ais-danmark/content/data) |
| `elasticsearch_mapping.json` | Mapping for the elasticsearch index. In this file, it is required to define a property of type `geo_point` where you should store latitude & longitude. | [initialization/arlas-initializer-ais-danmark/content/elasticsearch_mapping.json](initialization/arlas-initializer-ais-danmark/content/elasticsearch_mapping.json) |
| `logstash_configuration` | Logstash configuration file for indexing the data set into elasticsearch. | [initialization/arlas-initializer-ais-danmark/content/logstash_configuration](initialization/arlas-initializer-ais-danmark/content/logstash_configuration) |
| `server_collection.json` | ARLAS server collection to create. This file should respect requirements stated in [the documentation](http://arlas.io/arlas-tech/current/arlas-collection-model/). | see [here](initialization/arlas-initializer-ais-danmark/content/start.bash#L8-L18) |
| `WUI_configuration.json` | WUI configuration file specifically crafted for your set of data. Documentation [here](http://arlas.io/arlas-tech/current/arlas-wui-configuration/). | [initialization/arlas-initializer-ais-danmark/content/WUI_configuration.json](initialization/arlas-initializer-ais-danmark/content/WUI_configuration.json) |
| `WUI_map_configuration.json` | Additional WUI configuration, relative to the styles of data-layer you want to show on the map. Documentation [here](http://arlas.io/arlas-tech/current/arlas-wui-configuration/). | [initialization/arlas-initializer-ais-danmark/content/WUI_map_configuration.json](initialization/arlas-initializer-ais-danmark/content/WUI_map_configuration.json) |

## Environment variables

The ARLAS initializer supports various environment variables.

| Name | Default value | Description |
|-|-|-|
| elasticsearch | `http://elasticsearch:9200` | URL to the HTTP port of the elasticsearch server (`http://<hostname or IP>:<HTTP port>`). To be used only if you are working with [an external elasticsearch deployment](#with-an-external-elasticsearch-deployment). |
| elasticsearch_index | `arlas-data` | Name of the elasticsearch index where your data will be indexed. |
| elasticsearch_user | | Username for connection to elasticsearch. To be used only if you are working with [an external elasticsearch deployment](#with-an-external-elasticsearch-deployment), and the latter is secured. |
| elasticsearch_password | | Password for connection to elasticsearch. To be used only if you are working with [an external elasticsearch deployment](#with-an-external-elasticsearch-deployment), and the latter is secured. |
| server_collection_name | `data` | Name of the ARLAS server collection to create. |
| server_URL_for_initializer | `http://arlas-server:9999` | Arlas server URL for the initialization container (`http://<hostname or IP>:<port>`). |
| server_URL_for_client | `http://localhost:9999` | Arlas server URL for the client (`http://<hostname or IP>:<port>`). |

## Example: ais-danmark

Example with the AIS data around Denmark provided in this repository (*Estimated time: 2mn*):

```bash
docker run \
  -e elasticsearch_index=ais-danmark \
  -e server_collection_name=ais-danmark \
  -i \
  --mount dst="/initialization",src="$PWD/initialization/arlas-initializer-ais-danmark/content",type=bind \
  --mount type=volume,src=default_wui-configuration,dst=/wui-configuration \
  --net arlas \
  --rm \
  -t \
  gisaia/arlas-initializer
```

## Data-specific initialization

We provide pre-built initializer for a few specific data set. They come under the form of docker images, inheriting from `gisaia/arlas-initializer`.

### ais-danmark

*Estimated time: 2mn*

```bash
time docker run \
    --mount type=volume,src=default_wui-configuration,dst=/wui-configuration \
    --net arlas --rm -t \
    gisaia/arlas-initializer-ais-danmark
```

# Development

## arlas-stack-manager

Sources for docker image `gisaia/arlas-stack-manager` are found in [src](src). Build instructions:

```bash
cd src; docker build -t gisaia/arlas-stack-manager .; cd -
```

## arlas-initializer

Sources for docker image `gisaia/arlas-initalizer` are found in [initialization/arlas-initializer](initialization/arlas-initializer). Build instructions:

```bash
cd initialization/arlas-initializer; docker build -t gisaia/arlas-initializer .; cd -
```

## arlas-initializer-ais-danmark

Sources for docker image `gisaia/arlas-initializer-ais-danmark` are found in [initialization/arlas-initializer-ais-danmark](initialization/arlas-initializer-ais-danmark). Build instructions:

1. Re-build dependency [gisaia/arlas-initializer](#arlas-initializer)

2. Build image

```bash
cd initialization/arlas-initializer-ais-danmark; docker build -t gisaia/arlas-initializer-ais-danmark .; cd -
```

## TODO

- split README:
  - README.md: github specific documentation
  - ARLAS-stack.md: general documentation, will be integrated to ARLAS documentation
- add CI to publish `arlas-initializer`
  - waiting for repository to be made public
- remove arlas-initializer-ais-danmark
- license
- disclaimer for AIS data