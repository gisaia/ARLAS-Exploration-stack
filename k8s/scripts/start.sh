#!/bin/bash
set -o errexit -o pipefail

# Create configmap for agate
kubectl create configmap agate-files-configmap  \
  --from-file=agate.yaml=conf/aias/agate.yaml  \
  --from-file=roles.yaml=conf/aias/roles.yaml  \
  --dry-run=client  \
  -o yaml > k8s/charts/aias-services/templates/agate-files-configmap.yaml

# Create configmap for aproc
kubectl create configmap aproc-files-configmap  \
  --from-file=drivers.yaml=conf/aias/drivers.yaml  \
  --from-file=aproc.yaml=conf/aias/aproc.yaml  \
  --from-file=download_drivers.yaml=conf/aias/download_drivers.yaml  \
  --from-file=enrich_drivers.yaml=conf/aias/enrich_drivers.yaml  \
  --from-file=dc3build_drivers.yaml=conf/aias/dc3build_drivers.yaml  \
  --dry-run=client  \
  -o yaml > k8s/charts/aias-services/templates/aproc-files-configmap.yaml

# Create configmap for fam
kubectl create configmap fam-files-configmap  \
  --from-file=drivers.yaml=conf/aias/drivers.yaml  \
  --from-file=aproc.yaml=conf/aias/aproc.yaml  \
  --from-file=fam.yaml=conf/aias/fam.yaml  \
  --dry-run=client  \
  -o yaml > ./k8s/charts/aias-services/templates/fam-files-configmap.yaml

# Create configmap for keycloak realm
kubectl create configmap keycloak-realm-configmap  \
  --from-file=keycloak.realm.json=conf/keycloak/keycloak.realm.json  \
  --dry-run=client  \
  -o yaml > ./k8s/charts/arlas-stack/templates/keycloak-realm-configmap.yaml

helm dependency update k8s/charts/arlas-stack 
helm dependency build k8s/charts/arlas-stack

OPERATION="install"
if helm list --namespace arlas | grep -q '^arlas-stack'; then
  echo "arlas-stack is deployed ... upgrading deployment"
  OPERATION="upgrade"
else
  echo "arlas-stack is not deployed ... installing deployment"
fi

helm $OPERATION --create-namespace --namespace arlas arlas-stack k8s/charts/arlas-stack -f k8s/charts/arlas-stack/values.yaml -f k8s/charts/arlas-stack/values-apisix.yaml
