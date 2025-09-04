#!/bin/bash
set -o errexit -o pipefail

[ -z "$1" ] && echo "Please provide the arlas host:port" && exit 1;
[ -z "$2" ] && echo "Please provide the elastic host:port" && exit 1;
[ -z "$3" ] && echo "Please provide the keycloak host:port" && exit 1;

ARLAS_HOST=$1
ES_HOST=$2
KEYCLOAK_HOST=$3

arlas_cli --config-file /tmp/arlas-cli.yaml confs delete local.k8s.kc.data

arlas_cli --config-file /tmp/arlas-cli.yaml \
    confs create local.k8s.kc.data \
    --server https://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence https://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic https://${ES_HOST} \
    --elastic-login elastic \
    --elastic-password secret4elastic \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete \
    --auth-grant-type password \
    --auth-client-id arlas-front \
    --auth-token-url https://${KEYCLOAK_HOST}/auth/realms/arlas/protocol/openid-connect/token \
    --auth-headers "Content-Type:application/x-www-form-urlencoded" \
    --auth-login user_all_roles \
    --auth-password secret \
    --auth-org "" \
    --no-auth-arlas-iam

arlas_cli --config-file /tmp/arlas-cli.yaml confs set local.k8s.kc.data