#!/bin/bash
set -o errexit -o pipefail

[ -z "$1" ] && echo "Please provide the id of the sashboard (arlas_cli --config-file /tmp/arlas-cli.yaml persist zone config.json)" && exit 1;

arlas_cli --config-file /tmp/arlas-cli.yaml persist get $1 | jq . | sed 's/"main"/"$COLLECTION"/g' > conf/aias/dashboard2.json
