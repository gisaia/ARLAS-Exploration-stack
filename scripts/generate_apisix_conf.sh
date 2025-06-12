#!/usr/bin/env bash
set -o errexit -o pipefail

if [ ! -f conf/server.crt ] || [ ! -f conf/server.key ]
then
    echo "no certificates"
else
    export SSL_CERT=`cat conf/server.crt | sed 's/^/      /'`
    export SSL_KEY=`cat conf/server.key | sed 's/^/      /'`
fi


. conf/stack.env
. conf/custom.env
echo "ARLAS HOST: ${ARLAS_HOST}"
export ARLAS_HOST=$ARLAS_HOST
envsubst '$SSL_CERT,$SSL_KEY,$ARLAS_HOST' < conf/apisix/apisix.template.yaml > conf/apisix/apisix.yaml
