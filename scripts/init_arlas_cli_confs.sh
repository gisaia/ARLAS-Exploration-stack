#!/bin/bash
set -o errexit -o pipefail

set +e
rm /tmp/arlas-cli.yaml
arlas_cli --config-file /tmp/arlas-cli.yaml --version
set -e

. conf/stack.env
. conf/custom.env

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


arlas_cli --config-file /tmp/arlas-cli.yaml \
    confs create local.kc.user \
    --server https://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence https://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete  \
    --auth-grant-type password \
    --auth-client-id arlas-front \
    --auth-token-url https://${ARLAS_HOST}:9443/auth/realms/arlas/protocol/openid-connect/token \
    --auth-headers "Content-Type:application/x-www-form-urlencoded" \
    --auth-login user_basic \
    --auth-password secret \
    --no-auth-arlas-iam


arlas_cli --config-file /tmp/arlas-cli.yaml \
    confs create local.kc.builder \
    --server https://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence https://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete  \
    --auth-grant-type password \
    --auth-client-id arlas-front \
    --auth-token-url https://${ARLAS_HOST}:9443/auth/realms/arlas/protocol/openid-connect/token \
    --auth-headers "Content-Type:application/x-www-form-urlencoded" \
    --auth-login user_builder \
    --auth-password secret \
    --no-auth-arlas-iam

arlas_cli --config-file /tmp/arlas-cli.yaml \
    confs create local.kc.data \
    --server https://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence https://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete  \
    --auth-grant-type password \
    --auth-client-id arlas-front \
    --auth-token-url https://${ARLAS_HOST}:9443/auth/realms/arlas/protocol/openid-connect/token \
    --auth-headers "Content-Type:application/x-www-form-urlencoded" \
    --auth-login user_all_roles \
    --auth-password secret \
    --auth-org "" \
    --no-auth-arlas-iam

arlas_cli --config-file /tmp/arlas-cli.yaml confs delete local

arlas_cli --config-file /tmp/arlas-cli.yaml confs create local \
    --server http://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence http://localhost/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete

