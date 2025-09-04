#!/bin/bash
set -o errexit -o pipefail

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.2/config/manifests/metallb-native.yaml
kubectl wait --for=condition=available --timeout=60s --namespace metallb-system --all deployments
kubectl apply -f k8s/resources/metallb-ippool.yaml
