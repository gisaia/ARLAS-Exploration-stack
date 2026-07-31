#!/usr/bin/env bash
set -o errexit -o pipefail

if [ ! -f conf/server-ks.crt ] || [ ! -f conf/server-ks.key ]
then
    echo "no certificates"
else
    export SSL_CERT=`cat conf/server-ks.crt | sed 's/^/      /'`
    export SSL_KEY=`cat conf/server-ks.key | sed 's/^/      /'`
fi


. conf/stack.env
. conf/custom.env
echo "ARLAS HOST: ${ARLAS_HOST}"
export ARLAS_HOST=$ARLAS_HOST
envsubst '$SSL_CERT,$SSL_KEY,$ARLAS_HOST' < conf/apisix/apisix.template.yaml > conf/apisix/apisix.yaml
