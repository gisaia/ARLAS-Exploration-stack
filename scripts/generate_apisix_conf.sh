#!/usr/bin/env bash
set -o errexit -o pipefail

export SSL_CERT=`cat conf/server.crt | sed 's/^/      /'`
export SSL_KEY=`cat conf/server.key | sed 's/^/      /'`

. conf/stack.env
echo "ARLAS HOST: ${ARLAS_HOST}"
export ARLAS_HOST=$ARLAS_HOST
envsubst '$SSL_CERT,$SSL_KEY,$ARLAS_HOST' < conf/apisix/apisix.template.yaml > conf/apisix/apisix.yaml
