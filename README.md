# Usage

## Prerequisites

- [Docker CE](https://docs.docker.com/install/) (Community Edition)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Initial setup

### `vm.max_map_count` (elasticsearch)

ARLAS relies on elasticsearch, thus the minimal development setup runs an elasticsearch docker container.

elasticsearch requires a minimal value of 262144 for kernel setting `vm.max_map_count`.

Check the value of this setting in your environment with the following command:

```bash
sysctl vm.max_map_count
```

If it is lower than the minimum value, follow this section of the official elasticsearch documentation to increase it:

https://www.elastic.co/guide/en/elasticsearch/reference/5.6/vm-max-map-count.html

## Run

*Note: It is required to manually create a docker network, on which all ARLAS containers will run. The default Docker Compose network does not allow external containers (ex: data-initialization container) to use container-names resolution.*

To start ARLAS:

```bash
docker network create arlas
docker-compose up -d
```

You should now be able to access it @ http://localhost

To shut down ARLAS:

```bash
docker-compose down
docker network rm arlas
```

## [OPTIONAL] Initialize ARLAS with AIS-danmark data (ships positions)

```
time docker run -e ELASTICSEARCH="http://elasticsearch:9200" \
    -e ARLAS_SERVER="http://arlas-server:9999" \
    --net arlas \
    --rm \
    --mount type=volume,src=arlasstack_wui-configuration,dst=/wui-configuration \
    arlas-ais-danmark-init
```

# Development

## Build data-initialization docker image

```bash
cd initialization/ais-danmark
docker build -t arlas-ais-danmark-init .
cd -
```
