#!/bin/bash
set -o errexit -o pipefail

COMPOSE_FILES="-f dc/ref-dc-elastic-init.yaml -f dc/ref-dc-elastic.yaml -f dc/ref-dc-arlas-persistence-server.yaml -f dc/ref-dc-arlas-permissions-server.yaml -f dc/ref-dc-arlas-builder.yaml -f dc/ref-dc-arlas-hub.yaml -f dc/ref-dc-arlas-wui.yaml -f dc/ref-dc-protomaps.yaml -f dc/ref-dc-net.yaml"
COMPOSE_SERVICES="elasticsearch elasticsearch-setup arlas-server arlas-persistence-server arlas-permissions-server arlas-builder arlas-hub arlas-wui protomaps apisix"
ENV_FILES="--env-file conf/versions.env --env-file conf/elastic.env --env-file conf/arlas.env --env-file conf/persistence-file.env --env-file conf/permissions.env --env-file conf/apisix.env --env-file conf/restart_strategy.env --env-file conf/stack.env"

if [ -z "$1" ]
then
    echo "START STANDARD ARLAS STACK"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-arlas-server.yaml -f dc/ref-dc-apisix.yaml"
fi

if [ "$1" = "iam" ]
then
    echo "START STACK WITH IAM"
    ./generate_apisix_conf.sh
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-arlas-server-iam.yaml -f dc/ref-dc-apisix-ssl.yaml -f dc/ref-dc-aias-volumes.yaml -f dc/ref-dc-aias-airs.yaml -f dc/ref-dc-aias-aproc-service.yaml -f dc/ref-dc-aias-aproc-proc.yaml -f dc/ref-dc-aias-minio-init.yaml -f dc/ref-dc-aias-minio.yaml -f dc/ref-dc-aias-redis.yaml -f dc/ref-dc-aias-rabbitmq.yaml -f dc/ref-dc-aias-fam.yaml -f dc/ref-dc-aias-fam-wui.yaml"
    COMPOSE_SERVICES=${COMPOSE_SERVICES}" airs-server aproc-service aproc-proc redis rabbitmq fam-service arlas-fam-wui"
    ENV_FILES=${ENV_FILES}" --env-file conf/aias.env"
fi

if [ "$1" = "aias" ]
then
    echo "START STACK WITH AIAS AND IAM"
    ./generate_apisix_conf.sh
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-arlas-server-iam.yaml -f dc/ref-dc-apisix-ssl.yaml -f dc/ref-dc-aias-volumes.yaml -f dc/ref-dc-aias-airs.yaml -f dc/ref-dc-aias-aproc-service.yaml -f dc/ref-dc-aias-aproc-proc.yaml -f dc/ref-dc-aias-minio-init.yaml -f dc/ref-dc-aias-minio.yaml -f dc/ref-dc-aias-redis.yaml -f dc/ref-dc-aias-rabbitmq.yaml -f dc/ref-dc-aias-fam.yaml -f dc/ref-dc-aias-fam-wui.yaml"
    COMPOSE_SERVICES=${COMPOSE_SERVICES}" airs-server aproc-service aproc-proc redis rabbitmq fam-service arlas-fam-wui"
    ENV_FILES=${ENV_FILES}" --env-file conf/aias.env"
fi

# We run elastic on 9200 without ssl
#    set +e
#    docker compose -p arlas-exploration-stack $ENV_FILES -f dc/ref-dc-elastic-init.yaml -f dc/ref-dc-elastic.yaml -f dc/ref-dc-net.yaml up -d --wait --wait-timeout 300
#    set -e

docker compose -p arlas-exploration-stack $ENV_FILES $COMPOSE_FILES up -d --remove-orphans --wait --wait-timeout 300 $COMPOSE_SERVICES
