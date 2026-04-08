#!/bin/bash
set -o errexit -o pipefail

[ -z "$1" ] && echo "Please provide the configuration name (e.g. local.k8s.kc.data)" && exit 1;
[ -z "$2" ] && echo "Please provide the collection" && exit 1;

COLLECTION=$2
CONFIG_NAME=$1
CONFIG_FILE="/tmp/arlas-cli.yaml"

# make sure we have the configuration
if arlas_cli --config-file "$CONFIG_FILE" confs list | grep -q "\<$CONFIG_NAME\>"; then
    echo "Found configuration '$CONFIG_NAME'"
else
    echo "Error: Configuration '$CONFIG_NAME' not found."
    exit 1
fi

# make sure we have the collection
if arlas_cli --config-file "$CONFIG_FILE" collections list | grep $COLLECTION; then
    echo "Found collection '$COLLECTION'"
else
    echo "Collection '$COLLECTION' not found."
fi

# retrive the index name, if not found, it must be provided
if arlas_cli --config-file "$CONFIG_FILE" collections list | grep $COLLECTION; then
    echo "Found collection '$COLLECTION'"
    INDEX=`arlas_cli --config-file /tmp/arlas-cli.yaml collections list | grep main | awk -F '|' '{print $3}'`
else
    echo "Collection '$COLLECTION' not found."
    [ -z "$3" ] && echo "Please provide the index name" && exit 1;
    INDEX=$3
fi

echo "Using index $INDEX"
arlas_cli --config-file /tmp/arlas-cli.yaml indices delete $INDEX

token=`arlas_cli --config-file /tmp/arlas-cli.yaml iam token`

echo "Reindexing collection $COLLECTION"
curl -X POST -k 'https://site.arlas.k8s/airs/collections/'$COLLECTION'/_reindex' \
  -H 'accept: application/json, text/plain, */*' \
  -H 'authorization: Bearer '${token}
  
arlas_cli --config-file "$CONFIG_FILE"  collections count $COLLECTION
