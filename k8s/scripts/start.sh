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


kubectl create namespace arlas --dry-run=client -o yaml | kubectl apply -f -

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

helm $OPERATION --create-namespace --namespace arlas arlas-stack k8s/charts/arlas-stack -f k8s/charts/arlas-stack/values.yaml > /tmp/helm_arlas_stack.yaml
