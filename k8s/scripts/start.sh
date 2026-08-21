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

GATEWAY_PARAMS="\
global.gateway.enabled=true,\
deployment.arlas.uis.gateway.enabled=true,\
deployment.arlas.services.gateway.enabled=true,\
deployment.aias.uis.gateway.enabled=true,\
deployment.aias.services.airs.gateway.enabled=true,\
deployment.aias.services.aproc.gateway.enabled=true,\
deployment.aias.services.fam.gateway.enabled=true,\
deployment.aias.services.minio.gateway.enabled=true,\
deployment.aias.services.titiler.gateway.enabled=true,\
deployment.elasticsearch.gateway.enabled=true,\
deployment.kibana.gateway.enabled=true,\
deployment.minio.gateway.enabled=true,\
deployment.keycloak.gateway.enabled=true"

INGRESS_PARAMS="\
deployment.arlas.uis.ingress.enabled=true,\
deployment.arlas.services.ingress.enabled=true,\
deployment.aias.services.airs.ingress.enabled=true,\
deployment.aias.services.aproc.ingress.enabled=true,\
deployment.aias.services.fam.ingress.enabled=true,\
deployment.aias.services.minio.ingress.enabled=true,\
deployment.aias.services.titiler.ingress.enabled=true,\
deployment.elasticsearch.ingress.enabled=true,\
deployment.kibana.ingress.enabled=true,\
deployment.ingress.gateway.enabled=true,\
elasticsearch.kibana.ingress.enabled=true,\
keycloak.ingress.enabled=true"


if [[ " $@ " =~ " gateway " ]]; then
  echo "Use GATEWAY, disable INGRESS"
  INGRESS_PARAMS=$(echo "$INGRESS_PARAMS" | sed 's/=true/=false/g')  
else
  echo "Use INGRESS, disable GATEWAY"
  GATEWAY_PARAMS=$(echo "$GATEWAY_PARAMS" | sed 's/=true/=false/g')
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
  if kubectl get secret arlas-tls -n arlas &> /dev/null; then
      echo "✅ Secret arlas-tls exists in namespace."
  else
      echo "❌ Secret arlas-tls does NOT exist. Creating it ..."
    # Create configmap for arlas domain certificate
    kubectl create configmap arlas-certificate-configmap  \
      --from-file=arlas-ks.jks=conf/arlas-ks.jks \
      --dry-run=client  \
      -o yaml > ./k8s/charts/arlas-stack/templates/arlas-certificate-configmap.yaml

    # Create secret for keycloak certificate
    kubectl create secret tls arlas-tls --cert=conf/server-ks.crt --key=conf/server-ks.key -n arlas
  fi
else
  echo "No certificate (conf/arlas-ks.jks) found."
fi

helm $OPERATION --create-namespace --namespace arlas arlas-stack k8s/charts/arlas-stack -f k8s/charts/arlas-stack/values.yaml --set $INGRESS_PARAMS --set $GATEWAY_PARAMS

if [[ "$(uname)" == "Darwin" ]]; then
  k8s/scripts/patch_coredns.sh
fi