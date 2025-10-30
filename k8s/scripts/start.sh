#!/bin/bash
set -o errexit -o pipefail

check_command(){
    COMMAND_NAME=$1
    if ! command -v $COMMAND_NAME >/dev/null 2>&1; then
        echo "Error: '$COMMAND_NAME' is not installed. Please install it first."
        exit 1
    fi
}

check_command "kubectl"
check_command "helm"
check_command "curl"
check_command "yq"

FILE="custom_values.yaml"

if [ -f "$FILE" ]; then
    echo "$FILE found: using it to override default values."
    yq eval-all 'select(fileIndex == 0) *+ select(fileIndex == 1)' k8s/charts/arlas-stack/values_template.yaml "$FILE" > k8s/charts/arlas-stack/values.yaml
else
    echo "No $FILE found, using default values."
    cp k8s/charts/arlas-stack/values_template.yaml k8s/charts/arlas-stack/values.yaml
fi

kubectl create namespace arlas --dry-run=client -o yaml | kubectl apply -f -

# Create configmap for airs
kubectl create configmap airs-files-configmap  \
  --from-file=airs.yaml=conf/aias/airs.yaml  \
  --dry-run=client  \
  -o yaml > k8s/charts/aias-services/templates/airs-files-configmap.yaml

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

  if [ -e conf/arlas-ks.jks ]
  then
    # Create configmap for keycloak certificate
    kubectl create configmap keycloak-certificate-configmap  \
      --from-file=arlas-ks.jks=conf/arlas-ks.jks \
      --dry-run=client  \
      -o yaml > ./k8s/charts/arlas-stack/templates/keycloak-certificate-configmap.yaml

    # Create secret for keycloak certificate
    kubectl create secret tls keycloak-tls --cert=conf/server.crt --key=conf/server.key -n arlas
  else
    echo "No certificate (conf/arlas-ks.jks) found."
  fi
fi

helm $OPERATION --create-namespace --namespace arlas arlas-stack k8s/charts/arlas-stack -f k8s/charts/arlas-stack/values-apisix.yaml -f k8s/charts/arlas-stack/values.yaml
