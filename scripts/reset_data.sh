#!/bin/bash
set -o errexit -o pipefail

docker volume rm \
    arlas-data-es \
    arlas-es-certs \
    arlas-es-config \
    arlas-persist \
    arlas-postgres \
    arlas-data-seaweedfs \
    arlas-data-mc-conf \
    arlas-data-rabbitmq \
    arlas-data-redis
