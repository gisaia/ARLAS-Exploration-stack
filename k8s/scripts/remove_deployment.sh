#!/bin/bash
set -o errexit -o pipefail

if helm list -n arlas | grep -q '^arlas-stack'; then
  echo "Removing arlas-stack ..."
  helm uninstall arlas-stack -n arlas
else
  echo "arlas-stack is not deployed"
fi
