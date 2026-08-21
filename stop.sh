#!/bin/bash
set -o errexit -o pipefail

# Stop Docker compose services
eval "docker compose -p arlas-exploration-stack down"
rm -rf conf/server-ks.crt conf/server-ks.csr conf/server-ks.key conf/arlas-ks.jks conf/truststore.p12
