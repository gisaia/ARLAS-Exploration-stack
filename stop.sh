#!/bin/bash
set -o errexit -o pipefail

# Stop Docker compose services
eval "docker compose -p arlas-exploration-stack down"
rm -rf conf/server.crt conf/server.csr conf/server.key conf/arlas-ks.jks conf/truststore.p12
