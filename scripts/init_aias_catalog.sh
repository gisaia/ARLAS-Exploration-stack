#!/bin/bash
set -o errexit -o pipefail
. conf/aias.env
ORG=org.com
[ -z "$1" ] && echo "Please provide the ARLAS configuration name" && exit 1;
[ -z "$2" ] && echo "Please provide the collection name" && exit 1;
[ -z "$3" ] && echo "Please provide the index name" && exit 2;
[ ! -z "$4" ] && ORG=$4 ;

CONF=$1
export COLLECTION=$2
INDEX=$3

GROUPS_PARAMS='--reader group/config.json/org.com --writer group/config.json/org.com'
USER_CONF="local.iam.user"

echo "Create collection '${COLLECTION}' on index '${INDEX}'"
arlas_cli --config-file /tmp/arlas-cli.yaml \
    collections --config ${CONF} create ${COLLECTION} \
    --index ${INDEX} --display-name ${COLLECTION} \
    --id-path id \
    --centroid-path centroid \
    --geometry-path geometry \
    --date-path properties.datetime \
    --no-public \
    --owner ${ORG} \
    --orgs ${ORG}

envsubst '$COLLECTION' < conf/aias/dashboard.json > sample/dashboard.generated.json
arlas_cli --config-file /tmp/arlas-cli.yaml persist --config ${USER_CONF} add sample/dashboard.generated.json config.json --name "${COLLECTION}" $GROUPS_PARAMS
