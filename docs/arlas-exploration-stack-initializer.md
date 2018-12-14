The ARLAS Exploration Stack Initializer allows to register data in the ARLAS Exploration Stack in an easy way. It can be used to initiialize the instance of the Stack controlled by the [ARLAS Exploration Stack Manager](arlas-exploration-stack-manager.md).

It comes under the form of a [docker](https://docker.com) container.

Sources: https://github.com/gisaia/ARLAS-Exploration-stack/tree/v7.0.0/arlas-exploration-stack-initializer

# Prerequisites

- [Docker CE](https://docs.docker.com/install/) (Community Edition) >= 18.02.0

# Download

```bash
ARLAS_EXPLORATION_STACK_VERSION=7.0.0

curl -L https://github.com/gisaia/ARLAS-Exploration-stack/archive/v$ARLAS_EXPLORATION_STACK_VERSION.tar.gz \
  | tar -f - --strip-components 1 -x -z ARLAS-Exploration-stack-$ARLAS_EXPLORATION_STACK_VERSION/ARLAS-Exploration-stack.bash
```

# Usage

Once you have the ARLAS Exploration Stack running, you can use the initializer to register data onto it. The initializer container is an instance of image [gisaia/arlas-exploration-stack-initializer](https://hub.docker.com/r/gisaia/arlas-exploration-stack-initializer).

To be used, it requires to be provided with a certain set of files presented in the table below. We have implemented an initialization of ARLAS with [AIS](https://en.wikipedia.org/wiki/Automatic_identification_system) data (ships) around Denmark, and the corresponding files are given as examples in the table.

| File name | Optional | Description | Example: ais-danmark |
|-|-|-|-|
| `data_ingestion/data` | Optional | File containing your data (csv, ...). Optional, since your data may not be under the form of a file (ex: kafka topic, ...) | [data_samples/ais-danmark/data_ingestion/data](https://github.com/gisaia/ARLAS-Exploration-stack/blob/v7.0.0/data_samples/ais-danmark/data_ingestion/data) |
| `data_ingestion/elasticsearch_mapping.json` | | Mapping for the elasticsearch index. In this file, it is required to define a property of type `geo_point` where you should store latitude & longitude. | [data_samples/ais-danmark/data_ingestion/elasticsearch_mapping.json](https://github.com/gisaia/ARLAS-Exploration-stack/blob/v7.0.0/data_samples/ais-danmark/data_ingestion/elasticsearch_mapping.json) |
| `data_ingestion/logstash_configuration` | | Logstash configuration file for indexing the dataset into elasticsearch. | [data_samples/ais-danmark/data_ingestion/logstash_configuration](https://github.com/gisaia/ARLAS-Exploration-stack/blob/v7.0.0/data_samples/ais-danmark/data_ingestion/logstash_configuration) |
| `server/collection.json` | | Collection to create in the ARLAS server. This file should respect requirements stated in [the documentation](arlas-collection-model.md). | [data_samples/ais-danmark/server/collection.json](https://github.com/gisaia/ARLAS-Exploration-stack/blob/v7.0.0/data_samples/ais-danmark/server/collection.json) |
| `WUI/config.json` | | WUI configuration file specifically crafted for your set of data. Documentation [here](arlas-wui-configuration.md). | [data_samples/ais-danmark/WUI/config.json](https://github.com/gisaia/ARLAS-Exploration-stack/blob/v7.0.0/data_samples/ais-danmark/WUI/config.json) |
| `WUI/config.map.json` | | Additional WUI configuration, relative to the styles of data-layer you want to show on the map. Documentation [here](arlas-wui-configuration.md). | [data_samples/ais-danmark/WUI/config.map.json](https://github.com/gisaia/ARLAS-Exploration-stack/blob/v7.0.0/data_samples/ais-danmark/WUI/config.map.json) |

Instructions:
  - create a directory
  - inside this initialization directory, create the configuration files & write them. The initializer detects the files by their path & name, so be sure to respect the directory structure & the nomenclature of the files.
  - run the initializer with the initialization directory [bind-mounted](https://docs.docker.com/storage/bind-mounts/) onto it.

This diagram explains what actions the initializer performs upon being triggered:

![Initialization](initialization.svg)

1. Creation of elasticsearch index
2. Creation of the collection in the ARLAS server
3. Injection of WUI configuration
4. Injection of WUI map configuration
5. Indexation of data in elasticsearch using logstash. Data can come from anything that can be plugged into logstash (file, kafka topic, ...)

## Configuration

The ARLAS Exploration stack initializer can be configured through environment variables.

| Name | Default value | Description |
|-|-|-|
| elasticsearch | `http://arlas-exploration-stack-elasticsearch:9200` | URL to the HTTP port of the elasticsearch server (`http://<hostname or IP>:<HTTP port>`). To be used only if you are not working with the elasticsearch server deployed by the manager. |
| elasticsearch_index | `arlas-data` | Name of the elasticsearch index where your data will be indexed. |
| elasticsearch_user | | Username for connection to elasticsearch. To be used only if you are not working with the elasticsearch server deployed by the manager. |
| elasticsearch_password | | Password for connection to elasticsearch. To be used only if you are not working with the elasticsearch server deployed by the manager. |
| server_collection_name | `data` | Name of the ARLAS server collection to create. |
| server_URL_for_initializer | `http://arlas-exploration-stack-server:9999` | Arlas server URL for the initialization container (`http://<hostname or IP>:<port>`). |
| server_URL_for_client | `http://localhost:9999` | Arlas server URL for the client (`http://<hostname or IP>:<port>`). |

Keep in mind that since the Initializer is a Docker container, you have to use [`docker run` option `-e`](https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file) to pass environment variables.

## Example: ais-danmark

Gisaïa provides an example of initialization with [AIS](https://en.wikipedia.org/wiki/Automatic_identification_system) data around Denmark.

**Warning**: This configuration sample connects the WUI to a hosted Gisaïa service, for providing the map background. The URL of this service is likely to change, hence old versions of this configuration sample may not work anymore in the future.

See [here](quickstart.md#initialize-it-with-ais-data).
