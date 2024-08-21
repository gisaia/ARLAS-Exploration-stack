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

envsubst '$SSL_CERT' < conf/apisix/apisix_with_aias.yaml > conf/apisix/apisix.generated.tmp.yaml
mv conf/apisix/apisix.generated.tmp.yaml conf/apisix/apisix.generated.yaml
envsubst '$SSL_KEY' < conf/apisix/apisix.generated.yaml > conf/apisix/apisix.generated.tmp.yaml
mv conf/apisix/apisix.generated.tmp.yaml conf/apisix/apisix.generated.yaml
envsubst '$ARLAS_HOST' < conf/apisix/apisix.generated.yaml > conf/apisix/apisix.generated.tmp.yaml
mv conf/apisix/apisix.generated.tmp.yaml conf/apisix/apisix.generated.yaml
