This project aims at allowing to deploy & use ARLAS Exploration stack locally, in an easy way. It consists in 2 parts:

**Deploying ARLAS Exploration stack**

The deployment consists of several [docker](https://docker.com) containers tied together using [Docker Compose](https://docs.docker.com/compose)

**Initializing ARLAS Exploration stack with data**

ARLAS Exploration stack has no interest if there is no data (it won't even work). This 2<sup>nd</sup> part of the project allows to easily initialize the stack with data, so that you can really use it.

---

# Table of content

[Prerequisites](#prerequisites)

[Usage](#usage)
- [Configuration](#configuration)
  - [Docker Compose `.env` file](#docker-compose-env-file)
  - [Docker Compose `env_file` mechanism](#docker-compose-env_file-mechanism)
- [With an external elasticsearch deployment](#with-an-external-elasticsearch-deployment)

[Initialize ARLAS Exploration stack with data](#initialize-arlas-exploration-stack-with-data)
- [Environment variables](#environment-variables)
- [Example: ais-danmark](#example-ais-danmark)

[Development](#development)
- [arlas-exploration-stack-manager](#arlas-exploration-stack-manager)
- [arlas-exploration-stack-initializer](#arlas-exploration-stack-initializer)

[Authors](#authors)

[License](#license)

[TODO](#todo)

---

# Prerequisites

- [Docker CE](https://docs.docker.com/install/) (Community Edition)

# Usage

```bash
# up
./ARLAS-Exploration-stack.bash up
# Will expose the UI @ localhost


# down
./ARLAS-Exploration-stack.bash down
```

## Configuration

### Docker Compose `.env` file

We use [the Docker Compose's `.env` file mechanism](https://docs.docker.com/compose/env-file/) to configure the stack's docker compose. You can find available environment variables in [arlas-exploration-stack-manager/.env](arlas-exploration-stack-manager/.env), with their default values. You can override them by creating & filling a `.env` file at the root of the project.

```bash
touch .env
```

### Docker Compose `env_file` mechanism

We use [the Docker Compose's `env_file` mechanism](https://docs.docker.com/compose/compose-file/#env_file) to populate environment variables inside containers. Each container has its own distinct `env_file` s. Default values are found under [arlas-exploration-stack-manager/environment](arlas-exploration-stack-manager/environment). You can set new values, or override the defaults, by creating & filling files `arlas-server`, `arlas-wui` & `elasticsearch` under [environment](environment).

```bash
touch environment/arlas-server environment/arlas-wui environment/elasticsearch
```

## With an external elasticsearch deployment

By default, ARLAS exploration stack runs an embedded elasticsearch container. You can choose not to deploy the latter, and instead connect the stack to your own elasticsearch deployment.

1<sup>st</sup>, you need to configure the stack to connect to your elasticsearch cluster. In [environment/arlas-server](environment/arlas-server), change values for the following environment variables: 

- `ARLAS_ELASTIC_CLUSTER`
- `ARLAS_ELASTIC_HOST`
- `ARLAS_ELASTIC_PORT`

You can then use option `--no-elasticsearch` to launch it without the embedded elasticsearch:

```bash
# up
./ARLAS-Exploration-stack.bash --no-elasticsearch up

# down
./ARLAS-Exploration-stack.bash --no-elasticsearch down
```

# Initialize ARLAS Exploration stack with data

Once you have ARLAS Exploration stack running, you can use the initializer to register data into it. The initializer comes under the form of a docker image: `gisaia/arlas-exploration-stack-initializer`.

To be used, it requires to be provided with a certain set of files presented in the table below.

You will have to create a dedicated directory for initializing the ARLAS Exploration stack, write the configuration files in it, and [bind-mount](https://docs.docker.com/storage/bind-mounts/) that directory onto the initializer container.

The initializer detects the files by their path & name, so be sure to respect the directory structure & the nomenclature of the configuration files.

Also, we have implemented an initialization of ARLAS with [AIS](https://en.wikipedia.org/wiki/Automatic_identification_system) data (ships) around Denmark, and the corresponding files are given as examples in the table.

| File name | Description | Example: ais-danmark |
|-|-|-|
| `data_ingestion/data` | File containing your data (csv, ...). | [data_samples/ais-danmark/data_ingestion/data](data_samples/ais-danmark/data_ingestion/data) |
| `data_ingestion/elasticsearch_mapping.json` | Mapping for the elasticsearch index. In this file, it is required to define a property of type `geo_point` where you should store latitude & longitude. | [data_samples/ais-danmark/data_ingestion/elasticsearch_mapping.json](data_samples/ais-danmark/data_ingestion/elasticsearch_mapping.json) |
| `data_ingestion/logstash_configuration` | Logstash configuration file for indexing the data set into elasticsearch. | [data_samples/ais-danmark/data_ingestion/logstash_configuration](data_samples/ais-danmark/data_ingestion/logstash_configuration) |
| `server/collection.json` | Collection to create in the ARLAS server. This file should respect requirements stated in [the documentation](http://arlas.io/arlas-tech/current/arlas-collection-model/). | see [here](data_samples/ais-danmark/start.bash#L8-L18) |
| `WUI/config.json` | WUI configuration file specifically crafted for your set of data. Documentation [here](http://arlas.io/arlas-tech/current/arlas-wui-configuration/). | [data_samples/ais-danmark/WUI/config.json](data_samples/ais-danmark/WUI/config.json) |
| `WUI/config.map.json` | Additional WUI configuration, relative to the styles of data-layer you want to show on the map. Documentation [here](http://arlas.io/arlas-tech/current/arlas-wui-configuration/). | [data_samples/ais-danmark/WUI/config.map.json](data_samples/ais-danmark/WUI/config.map.json) |

## Environment variables

The ARLAS Exploration stack initializer supports various environment variables.

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
  --mount dst="/initialization",src="$PWD/data_samples/ais-danmark",type=bind \
  --mount type=volume,src=default_wui-configuration,dst=/wui-configuration \
  --net arlas \
  --rm \
  -t \
  gisaia/arlas-exploration-stack-initializer
```

# Development

## arlas-exploration-stack-manager

Sources for docker image `gisaia/arlas-exploration-stack-manager` are found in [arlas-exploration-stack-manager](arlas-exploration-stack-manager). Build instructions:

```bash
cd arlas-exploration-stack-manager; docker build -t gisaia/arlas-exploration-stack-manager .; cd -
```

## arlas-exploration-stack-initializer

Sources for docker image `gisaia/arlas-exploration-stack-initializer` are found in [arlas-exploration-stack-initializer](arlas-exploration-stack-initializer). Build instructions:

```bash
cd arlas-exploration-stack-initializer; docker build -t gisaia/arlas-exploration-stack-initializer .; cd -
```

# Authors

- Gisaïa - *Initial work* - [Gisaïa](http://gisaia.fr/)

See also the list of [contributors](https://github.com/gisaia/ARLAS-Exploration-stack/graphs/contributors) who participated in this project.

# License

This project is licensed under the Apache License, Version 2.0 - see the [LICENSE.txt](LICENSE.txt) file for details.

# TODO

- split README:
  - README.md: github specific documentation
  - ARLAS-stack.md: general documentation, will be integrated to ARLAS documentation
- add CI to publish `arlas-exploration-stack-initializer`
  - waiting for repository to be made public
- disclaimer for AIS data
