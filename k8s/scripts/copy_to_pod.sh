#!/bin/bash
set -o errexit -o pipefail
[ -z "$1" ] && echo "Please provide the namespace" && exit 1;
[ -z "$2" ] && echo "Please provide the name of the deployment" && exit 1;
[ -z "$3" ] && echo "Please provide the source path" && exit 1;
[ -z "$4" ] && echo "Please provide the target path" && exit 1;

NAMESPACE=$1
DEPLOYMENT=$2
SOURCE_PATH=$3
TARGET_PATH=$4
echo "copy $SOURCE_PATH to $NAMESPACE:$DEPLOYMENT@$TARGET_PATH"

POD_NAME=`kubectl -n $NAMESPACE get pods -l app.kubernetes.io/component=${DEPLOYMENT} -o jsonpath='{.items[0].metadata.name}'`
kubectl cp -n $NAMESPACE ${SOURCE_PATH} ${POD_NAME}:${TARGET_PATH}
