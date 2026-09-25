#!/usr/bin/env bash
set -o errexit -o pipefail


check_exists(){
  FILE=$1
  if [ ! -f "$FILE" ] || [ ! -r "$FILE" ]; then
      echo "Error: File $FILE is missing or not readable."
  else
      echo "$FILE exists and readable."
  fi
}

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

docker run  -u "$(id -u):$(id -g)" -v $(pwd):/data alpine/openssl:3.5.8 genpkey -algorithm RSA -out /data/conf/server.key -pkeyopt rsa_keygen_bits:2048
check_exists conf/server.key

docker run  -u "$(id -u):$(id -g)" -v $(pwd):/data alpine/openssl:3.5.8 req -new -x509 -key /data/conf/server.key -out /data/conf/server.crt \
  -subj "/CN="${ARLAS_HOST} -days 365
check_exists conf/server.crt

chmod ag+r conf/server.key
docker run  -u "$(id -u):$(id -g)" -v $(pwd):/data eclipse-temurin:17-jdk keytool -import -alias arlas-ks -file /data/conf/server.crt -keystore /data/conf/arlas-ks.jks -noprompt -storepass arlaspassword
check_exists conf/arlas-ks.jks

docker run  -u "$(id -u):$(id -g)" -v $(pwd):/data alpine/openssl:3.5.8 pkcs12 -export \
  -inkey /data/conf/server.key \
  -in /data/conf/server.crt \
  -out /data/conf/truststore.p12 \
  -name arlas-ks \
  -passout "pass:arlaspassword"
check_exists conf/truststore.p12

chmod 755 conf/truststore.p12
