#!/usr/bin/env bash
set -euo pipefail

HOSTS_FILE="/etc/hosts"

# Collect all unique ingress hosts across all namespaces
hosts=$(kubectl get ingress -A -o jsonpath='{range .items[*]}{range .spec.rules[*]}{.host}{"\n"}{end}{end}' | sort -u)

# Map every host to 127.0.0.1
while read -r host; do
  # Skip empty lines (ingress rules without a host)
  [[ -z "$host" ]] && continue

  echo "127.0.0.1 $host" | sudo tee -a "$HOSTS_FILE" > /dev/null
  echo "Added: 127.0.0.1 $host"
done <<< "$hosts"