#!/bin/bash
set -o errexit -o pipefail

if helm list -n default | grep -q '^aias'; then
  echo "first, removing existing aias ..."
  helm uninstall aias
fi


helm dependency update k8s/charts/aias 
helm dependency build k8s/charts/aias
helm install aias k8s/charts/aias -f k8s/charts/aias/values.yaml -f k8s/charts/aias/values-apisix.yaml