#!/bin/bash
set -o errexit -o pipefail

COMPOSE_FILES=" -f dc/ref-dc-volumes.yaml -f dc/ref-dc-arlas-server.yaml -f dc/ref-dc-elastic-ssl.yaml -f dc/ref-dc-arlas-persistence-server.yaml -f dc/ref-dc-arlas-permissions-server.yaml -f dc/ref-dc-arlas-builder.yaml -f dc/ref-dc-arlas-hub.yaml -f dc/ref-dc-arlas-wui.yaml -f dc/ref-dc-net.yaml"
COMPOSE_SERVICES="elasticsearch arlas-server arlas-persistence-server arlas-permissions-server arlas-builder arlas-hub arlas-wui apisix"
ENV_FILES="conf/versions.env conf/elastic.env conf/arlas.env conf/persistence-file.env conf/permissions.env conf/apisix.env conf/restart_strategy.env conf/stack.env"

rm -rf conf/apisix/apisix.yaml
touch conf/custom.env

if [ -z "$1" ]
then
    echo "CONFIGURE SIMPLE ARLAS STACK"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-apisix.yaml"
    cat conf/apisix/apisix_part_arlas_services.yaml > conf/apisix/apisix.template.yaml
    echo "#END" >> conf/apisix/apisix.template.yaml
    ./scripts/generate_apisix_conf.sh
fi

if [ ! -f conf/server.key ]
then
    ./scripts/create_certificate.sh
fi

if [ "$1" = "iam" ] || [ "$1" = "aias" ]
then
    echo "CONFIGURE STACK WITH IAM"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-iam-wui.yaml -f dc/ref-dc-apisix-ssl.yaml -f dc/ref-dc-iam-server.yaml -f dc/ref-dc-postgres.yaml"
    COMPOSE_SERVICES=${COMPOSE_SERVICES}" arlas-iam-server arlas-wui-iam db"
    ENV_FILES=${ENV_FILES}" conf/arlas_iam.env conf/postgres.env"
    cat conf/apisix/apisix_part_arlas_services.yaml > conf/apisix/apisix.template.yaml
    cat conf/apisix/apisix_part_iam_services.yaml >> conf/apisix/apisix.template.yaml
fi

if [ "$1" = "kc" ] || [ "$1" = "aiaskc" ]
then
    echo "CONFIGURE STACK WITH KEYCLOAK"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-apisix-ssl.yaml -f dc/ref-dc-keycloak.yaml "
    if [ "$2" = "nokc" ]
    then
        echo "WILL NOT START KEYCLOACK"
    else
        COMPOSE_SERVICES=${COMPOSE_SERVICES}" keycloak"
    fi
    ENV_FILES=${ENV_FILES}" conf/arlas_keycloak.env"
    cat conf/apisix/apisix_part_arlas_services.yaml > conf/apisix/apisix.template.yaml
fi

if [ "$1" = "aias" ] || [ "$1" = "aiaskc" ]
then
    echo "CONFIGURE STACK WITH AIAS"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-apisix-ssl.yaml"
    COMPOSE_FILES=${COMPOSE_FILES}" -f dc/ref-dc-aias-airs.yaml -f dc/ref-dc-aias-aproc-proc.yaml -f dc/ref-dc-aias-aproc-service.yaml -f dc/ref-dc-aias-fam-wui.yaml -f dc/ref-dc-aias-fam.yaml -f dc/ref-dc-aias-minio.yaml -f dc/ref-dc-aias-rabbitmq.yaml -f dc/ref-dc-aias-redis.yaml -f dc/ref-dc-aias-volumes.yaml -f dc/ref-dc-aias-agate.yaml -f dc/ref-dc-aias-titiler.yaml"
    COMPOSE_SERVICES=${COMPOSE_SERVICES}" airs-server aproc-service aproc-proc redis rabbitmq fam-service arlas-fam-wui minio agate titiler"
    ENV_FILES=${ENV_FILES}" conf/aias.env conf/minio.env"

    . conf/versions.env

    cat conf/apisix/apisix_part_arlas_services.yaml > conf/apisix/apisix.template.yaml
    cat conf/apisix/apisix_part_iam_services.yaml >> conf/apisix/apisix.template.yaml
    if [ "$1" = "aias" ]
    then
        cat conf/apisix/apisix_part_aias_services_iam.yml >> conf/apisix/apisix.template.yaml
    else
        cat conf/apisix/apisix_part_aias_services_kc.yaml >> conf/apisix/apisix.template.yaml
    fi

    echo "Initialising Minio configuration..."
    set +e

    . ./conf/aias.env
    
    export BUCKET_NAME=$AIRS_S3_BUCKET
    docker compose  -p arlas-exploration-stack \
        --env-file conf/versions.env  \
        --env-file conf/stack.env \
        --env-file conf/aias.env \
        --env-file conf/minio.env \
        --env-file conf/custom.env \
        -f dc/ref-dc-net.yaml -f dc/ref-dc-aias-minio-init.yaml -f dc/ref-dc-aias-minio.yaml -f dc/ref-dc-aias-volumes.yaml -f dc/ref-dc-volumes.yaml \
    up -d --wait --wait-timeout 300 minio createbuckets

    export BUCKET_NAME=$DOWNLOAD_S3_BUCKET
    docker compose  -p arlas-exploration-stack \
        --env-file conf/versions.env  \
        --env-file conf/stack.env \
        --env-file conf/aias.env \
        --env-file conf/minio.env \
        --env-file conf/custom.env \
        -f dc/ref-dc-net.yaml -f dc/ref-dc-aias-minio-init.yaml -f dc/ref-dc-aias-minio.yaml -f dc/ref-dc-aias-volumes.yaml -f dc/ref-dc-volumes.yaml \
    up -d --wait --wait-timeout 300 minio createbuckets
    echo "...done."
    set -e
fi


if [ "$1" = "iam" ] || [ "$1" = "kc" ] || [ "$1" = "aias" ] || [ "$1" = "aiaskc" ]
then
    echo "CONFIGURE STACK WITH SSL"
    cat conf/apisix/apisix_part_ssl.yaml >> conf/apisix/apisix.template.yaml
    echo "#END" >> conf/apisix/apisix.template.yaml
    ./scripts/generate_apisix_conf.sh
fi


echo "START STACK"
cat ${ENV_FILES} > docker-compose.env
cat conf/custom.env >> docker-compose.env

docker compose -p arlas-exploration-stack --env-file docker-compose.env -f dc/ref-dc-elastic-init.yaml -f dc/ref-dc-elastic-ssl.yaml -f dc/ref-dc-volumes.yaml  -f dc/ref-dc-net.yaml up -d --wait --wait-timeout 300

if [ "$1" = "kc" ] || [ "$1" = "aiaskc" ]
then
    echo "START KEYCLOAK"
    set +e # initial start can lead to temporally unhealthy keycloak
    docker compose -p arlas-exploration-stack --env-file docker-compose.env $COMPOSE_FILES up -d --wait --wait-timeout 300 keycloak
    set -e
fi

docker compose -p arlas-exploration-stack --env-file docker-compose.env $COMPOSE_FILES up -d --remove-orphans --wait --wait-timeout 300 $COMPOSE_SERVICES  || true
echo "STACK UP & RUNNING"
