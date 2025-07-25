#!/bin/bash
set -o errexit -o pipefail

if helm list -n default | grep -q '^aias'; then
  echo "first, removing existing aias ..."
  helm uninstall aias
fi

kubectl create configmap agate-files-configmap  \
  --from-file=agate.yaml=conf/aias/agate.yaml  \
  --from-file=roles.yaml=conf/aias/roles.yaml  \
  --dry-run=client  \
  -o yaml > k8s/charts/arlas-agate/templates/agate-files-configmap.yaml

kubectl create configmap fam-files-configmap  \
  --from-file=drivers.yaml=conf/aias/drivers.yaml  \
  --from-file=aproc.yaml=conf/aias/aproc.yaml  \
  --from-file=fam.yaml=conf/aias/fam.yaml  \
  --dry-run=client  \
  -o yaml > k8s/charts/arlas-fam/templates/fam-files-configmap.yaml

helm dependency update k8s/charts/aias 
helm dependency build k8s/charts/aias
helm install aias k8s/charts/aias -f k8s/charts/aias/values.yaml -f k8s/charts/aias/values-apisix.yaml
