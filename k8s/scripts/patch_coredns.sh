#!/bin/bash
set -e

# Get the ingress controller external IP assigned by MetalLB
INGRESS_IP=$(kubectl get svc ingress-nginx-controller -n default \
  -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo "Patching CoreDNS with ingress IP: $INGRESS_IP"

# Fetch the current Corefile
COREFILE=$(kubectl get configmap coredns -n kube-system -o jsonpath='{.data.Corefile}')

# Idempotency check: skip if already patched
if echo "$COREFILE" | grep -q "keycloak.arlas.k8s"; then
  echo "CoreDNS already patched, skipping."
  exit 0
fi

# Inject the hosts block just before the kubernetes plugin
PATCHED=$(echo "$COREFILE" | sed "s|kubernetes cluster.local|hosts {\n            $INGRESS_IP keycloak.arlas.k8s\n            fallthrough\n        }\n        kubernetes cluster.local|")

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