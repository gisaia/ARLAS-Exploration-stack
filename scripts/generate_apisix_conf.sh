#!/usr/bin/env bash
set -o errexit -o pipefail

if [ ! -f conf/server.crt ] || [ ! -f conf/server.key ]
then
    echo "creating conf/server.crt and conf/server.key ..."
    openssl req -x509 -days 7300 -out conf/server.crt -keyout conf/server.key -newkey rsa:2048 -nodes -sha256 \
        -subj "/CN=localhost" -extensions EXT -config <(cat conf/apisix/domains.ext)
fi

export SSL_CERT=`cat conf/server.crt | sed 's/^/      /'`
export SSL_KEY=`cat conf/server.key | sed 's/^/      /'`

. conf/stack.env
echo "ARLAS HOST: ${ARLAS_HOST}"
export ARLAS_HOST=$ARLAS_HOST
envsubst '$SSL_CERT,$SSL_KEY,$ARLAS_HOST' < conf/apisix/apisix.yaml > conf/apisix/apisix.generated.yaml
