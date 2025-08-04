#!/bin/bash
set -o errexit -o pipefail

export ARLAS_HOST=`kubectl get services arlas-stack-apisix-data-plane -n arlas  -o=jsonpath={.status.loadBalancer.ingress[0].ip}`
export ES_HOST=`kubectl get services arlas-stack-elasticsearch -n arlas  -o=jsonpath={.status.loadBalancer.ingress[0].ip}`

arlas_cli --config-file /tmp/arlas-cli.yaml confs delete local.k8s.kc.data

arlas_cli --config-file /tmp/arlas-cli.yaml \
    confs create local.k8s.kc.data \
    --server http://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence http://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic https://${ES_HOST}:9200 \
    --elastic-login elastic \
    --elastic-password secret4elastic \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete \
    --auth-grant-type password \
    --auth-client-id arlas-front \
    --auth-token-url http://${ARLAS_HOST}/auth/realms/arlas/protocol/openid-connect/token \
    --auth-headers "Content-Type:application/x-www-form-urlencoded" \
    --auth-login user_all_roles \
    --auth-password secret \
    --auth-org "" \
    --no-auth-arlas-iam
