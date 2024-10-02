#!/bin/bash
set -o errexit -o pipefail

set +e
arlas_cli --config-file /tmp/arlas-cli.yaml
arlas_cli --config-file /tmp/arlas-cli.yaml confs delete local
arlas_cli --config-file /tmp/arlas-cli.yaml confs delete local.iam.admin
arlas_cli --config-file /tmp/arlas-cli.yaml confs delete local.iam.user
set -e

. conf/stack.env

arlas_cli --config-file /tmp/arlas-cli.yaml confs create local.iam.admin \
    --server https://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence https://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete  \
    --auth-token-url https://${ARLAS_HOST}/arlas_iam_server/session \
    --auth-headers "Content-Type:application/json" \
    --auth-login tech@gisaia.com \
    --auth-password admin \
    --auth-arlas-iam 

arlas_cli --config-file /tmp/arlas-cli.yaml confs create local.iam.user \
    --server https://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence https://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete  \
    --auth-token-url https://${ARLAS_HOST}/arlas_iam_server/session \
    --auth-headers "Content-Type:application/json" \
    --auth-login user@org.com \
    --auth-password secret \
    --auth-org org.com \
    --auth-arlas-iam 

arlas_cli --config-file /tmp/arlas-cli.yaml confs create local \
    --server http://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence http://localhost/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete
