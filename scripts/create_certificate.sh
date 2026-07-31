#!/usr/bin/env bash
set -o errexit -o pipefail

DOMAIN="arlas.k8s"
WILDCARD="*.${DOMAIN}"
STOREPASS="arlaspassword"

mkdir -p conf

rm -f conf/server-ks.crt conf/server-ks.key conf/arlas-ks.jks conf/truststore-ks.p12
echo "creating conf/server-ks.crt and conf/server-ks.key ..."

openssl genpkey -algorithm RSA -out conf/server-ks.key -pkeyopt rsa_keygen_bits:2048

openssl req -new -x509 \
  -key conf/server-ks.key \
  -out conf/server-ks.crt \
  -days 365 \
  -subj "/CN=${WILDCARD}" \
  -addext "subjectAltName=DNS:${DOMAIN},DNS:${WILDCARD}"

chmod 640 conf/server-ks.key
chmod 644 conf/server-ks.crt

keytool -importcert \
  -alias arlas-ks \
  -file conf/server-ks.crt \
  -keystore conf/arlas-ks.jks \
  -storepass "${STOREPASS}" \
  -noprompt

openssl pkcs12 -export \
  -inkey conf/server-ks.key \
  -in conf/server-ks.crt \
  -out conf/truststore-ks.p12 \
  -name arlas-ks \
  -passout "pass:${STOREPASS}"

chmod 644 conf/truststore-ks.p12