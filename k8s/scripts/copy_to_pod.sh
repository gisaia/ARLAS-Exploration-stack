#!/bin/bash
set -o errexit -o pipefail
[ -z "$1" ] && echo "Please provide the name of the deployment" && exit 1;
[ -z "$1" ] && echo "Please provide the source path" && exit 1;
[ -z "$1" ] && echo "Please provide the target path" && exit 1;

NAMESPACE=aias
DEPLOYMENT=$1
SOURCE_PATH=$2
TARGET_PATH=$3
POD_NAME=`kubectl get pods -l app.kubernetes.io/component=${DEPLOYMENT} -o jsonpath='{.items[0].metadata.name}'`

echo "Copy ${SOURCE_PATH} to ${TARGET_PATH} on pod ${POD_NAME} of deployment ${DEPLOYMENT}"
kubectl cp ${SOURCE_PATH} ${POD_NAME}:${TARGET_PATH}
