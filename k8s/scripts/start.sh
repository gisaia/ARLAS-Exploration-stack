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


# Get the current kubectl context
CURRENT_CONTEXT=$(kubectl config current-context)

# Check if the context contains "kind"
if [[ "$CURRENT_CONTEXT" == *"kind"* ]]; then
    echo "Using $CURRENT_CONTEXT ..."
else
    echo "Current context is: $CURRENT_CONTEXT"
    read -p "Do you want to continue? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Continuing with context: $CURRENT_CONTEXT"
        # Add your commands here to continue
    else
        echo "Aborting."
        exit 1
    fi
fi


kubectl create namespace arlas --dry-run=client -o yaml | kubectl apply -f -

helm dependency update k8s/charts/arlas-stack 
helm dependency build k8s/charts/arlas-stack

OPERATION="install"
if helm list --namespace arlas | grep -q '^arlas-stack'; then
  echo "arlas-stack is deployed ... upgrading deployment"
  OPERATION="upgrade"
else
  echo "arlas-stack is not deployed ... installing deployment"
fi


if [ -e conf/arlas-ks.jks ]
then
  if kubectl get secret keycloak-tls -n arlas &> /dev/null; then
      echo "✅ Secret keycloak-tls exists in namespace."
  else
      echo "❌ Secret keycloak-tls does NOT exist. Creating it ..."
    # Create configmap for keycloak certificate
    kubectl create configmap keycloak-certificate-configmap  \
      --from-file=arlas-ks.jks=conf/arlas-ks.jks \
      --dry-run=client  \
      -o yaml > ./k8s/charts/arlas-stack/templates/keycloak-certificate-configmap.yaml

    # Create secret for keycloak certificate
    kubectl create secret tls keycloak-tls --cert=conf/server.crt --key=conf/server.key -n arlas
  fi
else
  echo "No certificate (conf/arlas-ks.jks) found."
fi

helm $OPERATION --create-namespace --namespace arlas arlas-stack k8s/charts/arlas-stack -f k8s/charts/arlas-stack/values.yaml