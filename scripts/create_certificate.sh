#!/usr/bin/env bash
set -o errexit -o pipefail

rm -rf conf/server.crt and conf/server.key conf/arlas-ks.jks
echo "creating conf/server.crt and conf/server.key ..."

. ./conf/stack.env

openssl genrsa -out conf/server.key 2048
openssl req -new -key conf/server.key -out conf/server.csr \
  -subj "/CN="${ARLAS_HOST}

openssl x509 -req -in conf/server.csr -signkey conf/server.key \
  -out conf/server.crt -days 365

keytool -import -alias arlas-ks -file conf/server.crt -keystore conf/arlas-ks.jks -noprompt -storepass arlaspassword
