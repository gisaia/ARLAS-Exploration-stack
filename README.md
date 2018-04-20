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
  - [Use ARLAS with your own data](#use-arlas-with-your-own-data)
    - [Requirements](#requirements)
      - [Files](#files)
      - [Environment Variables](#environment-variables)

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
docker-compose down; docker volume rm arlasstack_wui-configuration; docker-compose pull; docker-compose up -d
```

*Note: by default, docker-compose does not pull latest version of docker images, when deploying, hence why the `docker-compose pull`.*

You should now be able to access it @ http://localhost

To shut down ARLAS:

```bash
docker-compose down; docker volume rm arlasstack_wui-configuration
```

### With your own elasticsearch deployment

By default, ARLAS-stack runs an embedded elasticsearch container. You can choose not to deploy it, and instead connect ARLAS to your own elasticsearch deployment.

1<sup>st</sup>, you need to configure ARLAS to connect to your elasticsearch cluster. Change values of environment variables `ARLAS_ELASTIC_CLUSTER` & `ARLAS_ELASTIC_HOST` for service `arlas-server`, in file `docker-compose.yml`.

You can then run ARLAS without embedded elasticsearch with the following commands:

```
docker-compose -f docker-compose.yml down; docker-compose pull; docker-compose -f docker-compose.yml up -d
```

To shut it down:

```
docker-compose -f docker-compose.yml down; docker volume rm arlasstack_wui-configuration
```

## Initialization

We provide a docker image, `gisaia/arlas-init-base`, for initializing ARLAS. See [Use ARLAS with your own data](#use-arlas-with-your-own-data) to for how to use it.

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

### Use ARLAS with your own data

Once you have ARLAS running, you can use docker image `gisaia/arlas-init-base` to set it up with your own set of data.

#### Requirements

##### Files

Those are the files you have to provide. You will have to mount them inside the `gisaia/arlas-init-base` container at execution time (using docker run option [-v](https://docs.docker.com/engine/reference/run/#volume-shared-filesystems)).

| File | Description | Example: ais-danmark |
|-|-|-|
| data_file | File containing your data (csv, ...). | [initialization/ais-danmark/content/data/aisdk_20180102_head100000.csv](initialization/ais-danmark/content/data/aisdk_20180102_head100000.csv) |
| elasticsearch_mapping | Mapping for the elasticsearch index. | [initialization/ais-danmark/content/mapping.json](initialization/ais-danmark/content/mapping.json) |
| logstash_configuration | Logstash configuration file for indexing the data set into elasticsearch. | [initialization/ais-danmark/content/csv2es.logstash.conf](initialization/ais-danmark/content/csv2es.logstash.conf) |
| server_collection | ARLAS server collection to create. | see [here](initialization/ais-danmark/content/start.bash#L8-18) |
| WUI_configuration | WUI configuration file specifically crafted for your set of data. | [initialization/ais-danmark/content/wui/config.json](initialization/ais-danmark/content/wui/config.json) |
| WUI_map_configuration | Also WUI configuration, relative to the styles of data-layer you want to show on the map. | [initialization/ais-danmark/content/wui/config.map.json](initialization/ais-danmark/content/wui/config.map.json) |

##### Environment variables

| Environment variable | Description | Example: ais-danmark |
|-|-|-|
| data_file | Path where you mounted **data_file** inside the `gisaia/arlas-init-base` container. | `/aisdk_20180102_head100000.csv` (see [here](initialization/ais-danmark/Dockerfile#L3)) |
| elasticsearch | elasticsearch server (`http://<hostname/IP>:<HTTP port>`) | |
| elasticsearch_index | Name of the elasticsearch index where your data will be indexed. | [ais-danmark](initialization/ais-danmark/content/start.bash#L4) |
| elasticsearch_mapping | Path where you mounted **elasticsearch_mapping** inside the `gisaia/arlas-init-base` container. | `/mapping.json` (see [here](initialization/ais-danmark/Dockerfile#L3)) |
| logstash_configuration | Logstash configuration file for indexing the data set into elasticsearch. | `/csv2es.logstash.conf` (see [here](initialization/ais-danmark/Dockerfile#L3)) |
| server | Arlas server (`http://<hostname/IP>:<port>`). | |
| server_collection | Path where you mounted **server_collection** inside the `gisaia/arlas-init-base` container. | [/server-collection.json](initialization/ais-danmark/content/start.bash#L8-18) |
| server_collection_name | Name of the ARLAS server collection to create. | [ais-danmark](initialization/ais-danmark/content/start.bash#L20) |
| WUI_configuration | Path where you mounted **WUI_configuration** inside the `gisaia/arlas-init-base` container. | `/config.json` (see [here](initialization/ais-danmark/Dockerfile#L3)) |
| WUI_map_configuration | Path where you mounted **WUI_map_configuration** inside the `gisaia/arlas-init-base` container. | `/config.map.json` (see [here](initialization/ais-danmark/Dockerfile#L3)) |

`gisaia/arlas-init-base` also supports optional variables `elasticsearch_user` & `elasticsearch_user`, for authentication purposes.

#### Example

Example with the ais-data provided in this repository:

```bash
# Set environment variables
export data_file=/aisdk_20180102_head100000.csv \
       elasticsearch=http://elasticsearch:9200 \
       elasticsearch_index=ais-danmark \
       elasticsearch_mapping=/mapping.json \
       logstash_configuration=/csv2es.logstash.conf \
       server=http://arlas-server:9999 \
       server_collection=/server-collection.json \
       server_collection_name=ais-danmark \
       WUI_configuration=/config.json \
       WUI_map_configuration=/config.map.json


# Write `server_collection`
cat > initialization/ais-danmark/content/server_collection.json <<EOF
{  
  "index_name": "$elasticsearch_index",
  "type_name": "doc",
  "id_path": "vessel.mmsi",
  "geometry_path": "course.segment.geometry.geometry",
  "centroid_path": "position.location",
  "timestamp_path": "position.timestamp"
}
EOF

# Initialize ARLAS with the data set
# Note: running container in the ARLAS network (`--net arlas`)
# Note: mouting wui-configuration volume to upload custom config files
docker run -e data_file -e elasticsearch -e elasticsearch_index -e elasticsearch_mapping -e logstash_configuration -e server -e server_collection -e server_collection_name -e WUI_configuration -e WUI_map_configuration --net arlas --rm -t \
  --mount dst="$data_file",src="$PWD/initialization/ais-danmark/content/data/aisdk_20180102_head100000.csv",type=bind \
  --mount dst="$elasticsearch_mapping",src="$PWD/initialization/ais-danmark/content/mapping.json",type=bind \
  --mount dst="$logstash_configuration",src="$PWD/initialization/ais-danmark/content/csv2es.logstash.conf",type=bind \
  --mount dst="$server_collection",src="$PWD/initialization/ais-danmark/content/server_collection.json",type=bind \
  --mount dst="$WUI_configuration",src="$PWD/initialization/ais-danmark/content/wui/config.json",type=bind \
  --mount dst="$WUI_map_configuration",src="$PWD/initialization/ais-danmark/content/wui/config.map.json",type=bind \
  --mount type=volume,src=arlasstack_wui-configuration,dst=/wui-configuration \
  gisaia/arlas-init-base
```

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

