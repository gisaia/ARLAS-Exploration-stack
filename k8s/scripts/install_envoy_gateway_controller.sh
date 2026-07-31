#!/bin/bash
set -o errexit -o pipefail

VERSION="v1.8.3"
NAMESPACE="default"

kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/latest/download/standard-install.yaml
helm repo update


helm uninstall eg -n ${NAMESPACE} || true
helm uninstall eg-crds -n ${NAMESPACE} || true

helm template eg-crds oci://docker.io/envoyproxy/gateway-crds-helm \
  --version ${VERSION} \
  --set crds.envoyGateway.enabled=true \
  --set crds.gatewayAPI.enabled=false \
  | kubectl apply --server-side -f -

helm upgrade --install eg oci://docker.io/envoyproxy/gateway-helm \
  --version ${VERSION} \
  --set crds.enabled=false \
  --set crds.gatewayAPI.safeUpgradePolicy.enabled=false

kubectl wait --timeout=5m -n ${NAMESPACE} \
  deployment/envoy-gateway \
  --for=condition=Available

kubectl get crd securitypolicies.gateway.envoyproxy.io
kubectl get crd envoyproxies.gateway.envoyproxy.io