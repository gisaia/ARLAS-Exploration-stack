#!/usr/bin/env bash
set -o errexit -o pipefail

rm -rf conf/server.crt and conf/server.key conf/arlas-ks.jks
echo "creating conf/server.crt and conf/server.key ..."

. conf/stack.env
. conf/custom.env

if [ -z "$1" ]
then
    echo "CONFIGURE CERTIFICATE WITH ARLAS HOST=${ARLAS_HOST} FROM conf/stack.env ENV FILE"
else
    ARLAS_HOST=$1
    echo "CONFIGURE CERTIFICATE WITH ARLAS HOST=${ARLAS_HOST} FROM PARAMETER"
fi

openssl genpkey -algorithm RSA -out conf/server.key -pkeyopt rsa_keygen_bits:2048

openssl req -new -x509 -key conf/server.key -out conf/server.crt \
  -subj "/CN="${ARLAS_HOST} -days 365

chmod ag+r conf/server.key
keytool -import -alias arlas-ks -file conf/server.crt -keystore conf/arlas-ks.jks -noprompt -storepass arlaspassword

openssl pkcs12 -export \
  -inkey conf/server.key \
  -in conf/server.crt \
  -out conf/truststore.p12 \
  -name arlas-ks \
  -passout "pass:arlaspassword"
chmod 755 conf/truststore.p12
