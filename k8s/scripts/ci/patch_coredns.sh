#!/bin/bash
set -e

RELEASE="arlas-stack"
NAMESPACE="arlas"
NAMESPACE_DEFAULT="default"
if helm get values "$RELEASE" -n "$NAMESPACE" --all -o json | jq -e '.global.gateway.enabled == true' > /dev/null; then
  GATEWAY_NAME="$(helm get values "$RELEASE" -n "$NAMESPACE" --all -o json | jq -r '.global.gateway.name')"
  SERVICE_NAME="$(kubectl get svc -n "$NAMESPACE_DEFAULT" -l "gateway.envoyproxy.io/owning-gateway-name=$GATEWAY_NAME" -o jsonpath='{.items[0].metadata.name}')"
  kubectl wait --for=jsonpath='{.spec.clusterIP}' --timeout=60s "service/$SERVICE_NAME" -n "$NAMESPACE_DEFAULT"
  IP="$(kubectl get svc "$SERVICE_NAME" -n "$NAMESPACE_DEFAULT" -o jsonpath='{.spec.clusterIP}')"
else
  IP=$(kubectl get svc ingress-nginx-controller -n default -o jsonpath='{.spec.clusterIP}')
fi
echo "Patching CoreDNS with IP: $IP"

# Fetch the current Corefile
COREFILE=$(kubectl get configmap coredns -n kube-system -o jsonpath='{.data.Corefile}')

# Idempotency check: skip if already patched
if echo "$COREFILE" | grep -q "keycloak.arlas.k8s"; then
  echo "CoreDNS already patched, skipping."
  exit 0
fi

# Inject the hosts block just before the kubernetes plugin
PATCHED=$(echo "$COREFILE" | sed "s|kubernetes cluster.local|hosts {\n            $IP keycloak.arlas.k8s\n            fallthrough\n        }\n        kubernetes cluster.local|")

# Write the patched Corefile to a temp file and apply it
TMPFILE=$(mktemp)
cat > "$TMPFILE" <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns
  namespace: kube-system
data:
  Corefile: |
$(echo "$PATCHED" | sed 's/^/    /')
EOF

kubectl apply -f "$TMPFILE"
rm "$TMPFILE"

# Restart CoreDNS to pick up the new config
kubectl rollout restart deployment/coredns -n kube-system
kubectl rollout status deployment/coredns -n kube-system

echo "CoreDNS patched successfully."