#!/bin/bash
set -o errexit -o pipefail

if helm list -n default | grep -q '^aias'; then
  echo "Removing aias ..."
  helm uninstall aias
else
  echo "aias is not deployed"
fi
