#!/bin/bash
set -o errexit -o pipefail

COMPOSE_FILES=" -f dc/ref-dc-volumes.yaml -f dc/ref-dc-arlas-server.yaml -f dc/ref-dc-elastic.yaml -f dc/ref-dc-arlas-persistence-server.yaml -f dc/ref-dc-arlas-permissions-server.yaml -f dc/ref-dc-arlas-builder.yaml -f dc/ref-dc-arlas-hub.yaml -f dc/ref-dc-arlas-wui.yaml -f dc/ref-dc-protomaps.yaml -f dc/ref-dc-net.yaml"
COMPOSE_SERVICES="elasticsearch arlas-server arlas-persistence-server arlas-permissions-server arlas-builder arlas-hub arlas-wui protomaps apisix"
ENV_FILES="conf/versions.env conf/elastic.env conf/arlas.env conf/persistence-file.env conf/permissions.env conf/apisix.env conf/restart_strategy.env conf/stack.env"

if [ -z "$1" ]
then
    echo "START SIMPLE ARLAS STACK"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-apisix.yaml"
    cat conf/apisix/apisix_part_arlas_services.yaml > conf/apisix/apisix.yaml
    echo "#END" >> conf/apisix/apisix.yaml
fi

if [ "$1" = "iam" ]
then
    echo "START STACK WITH IAM"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-iam-wui.yaml -f dc/ref-dc-apisix-ssl.yaml -f dc/ref-dc-iam-server.yaml -f dc/ref-dc-postgres.yaml"
    COMPOSE_SERVICES=${COMPOSE_SERVICES}" arlas-iam-server arlas-wui-iam db"
    ENV_FILES=${ENV_FILES}" conf/arlas_iam.env conf/postgres.env"
    cat conf/apisix/apisix_part_arlas_services.yaml > conf/apisix/apisix.yaml
    cat conf/apisix/apisix_part_iam_services.yaml >> conf/apisix/apisix.yaml
    cat conf/apisix/apisix_part_ssl.yaml >> conf/apisix/apisix.yaml
    echo "#END" >> conf/apisix/apisix.yaml
    ./scripts/generate_apisix_conf.sh conf/apisix/apisix.yaml
fi

if [ "$1" = "aias" ]
then
    echo "START STACK WITH AIAS AND IAM"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-iam-wui.yaml -f dc/ref-dc-apisix-ssl.yaml -f dc/ref-dc-iam-server.yaml -f dc/ref-dc-postgres.yaml"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-aias-airs.yaml -f dc/ref-dc-aias-aproc-proc.yaml -f dc/ref-dc-aias-aproc-service.yaml -f dc/ref-dc-aias-fam-wui.yaml -f dc/ref-dc-aias-fam.yaml -f dc/ref-dc-aias-minio.yaml -f dc/ref-dc-aias-rabbitmq.yaml -f dc/ref-dc-aias-redis.yaml -f dc/ref-dc-aias-volumes.yaml -f dc/ref-dc-aias-agate.yaml"
    COMPOSE_SERVICES=${COMPOSE_SERVICES}" arlas-iam-server arlas-wui-iam db"
    COMPOSE_SERVICES=${COMPOSE_SERVICES}" airs-server aproc-service aproc-proc redis rabbitmq fam-service arlas-fam-wui minio agate"
    ENV_FILES=${ENV_FILES}" conf/arlas_iam.env conf/postgres.env"
    ENV_FILES=${ENV_FILES}" conf/aias.env conf/minio.env"

    cat conf/apisix/apisix_part_arlas_services.yaml > conf/apisix/apisix.yaml
    cat conf/apisix/apisix_part_iam_services.yaml >> conf/apisix/apisix.yaml
    cat conf/apisix/apisix_part_aias_services.yaml >> conf/apisix/apisix.yaml
    cat conf/apisix/apisix_part_ssl.yaml >> conf/apisix/apisix.yaml
    echo "#END" >> conf/apisix/apisix.yaml
    ./scripts/generate_apisix_conf.sh conf/apisix/apisix.yaml

    echo "Initialising Minio configuration..."
    set +e
    docker compose  -p arlas-exploration-stack \
    --env-file conf/versions.env  \
    --env-file conf/stack.env \
    --env-file conf/aias.env \
    --env-file conf/minio.env \
    -f dc/ref-dc-net.yaml -f dc/ref-dc-aias-minio-init.yaml -f dc/ref-dc-aias-minio.yaml -f dc/ref-dc-aias-volumes.yaml -f dc/ref-dc-volumes.yaml \
    up -d --wait --wait-timeout 300 minio createbuckets
    echo "...done."
    set -e
fi

# We run elastic on 9200 without ssl
#    set +e
#    docker compose -p arlas-exploration-stack $ENV_FILES -f dc/ref-dc-elastic-init.yaml -f dc/ref-dc-elastic.yaml -f dc/ref-dc-net.yaml up -d --wait --wait-timeout 300
#    set -e

cat ${ENV_FILES} > docker-compose.env
docker compose -p arlas-exploration-stack --env-file docker-compose.env $COMPOSE_FILES up -d --remove-orphans --wait --wait-timeout 300 $COMPOSE_SERVICES
