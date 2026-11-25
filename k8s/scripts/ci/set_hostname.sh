#!/usr/bin/env bash
set -euo pipefail

HOSTS_FILE="/etc/hosts"
MODE="${1:-}"

case "$MODE" in
  ingress)
    hosts=$(kubectl get ingress -A -o jsonpath='{range .items[*]}{range .spec.rules[*]}{.host}{"\n"}{end}{end}' | sort -u)
    ;;
  gateway)
    hosts=$(kubectl get httproutes.gateway.networking.k8s.io -A -o jsonpath='{range .items[*]}{range .spec.hostnames[*]}{@}{"\n"}{end}{end}' | sort -u)
    ;;
  *)
    echo "Usage: $0 {ingress|gateway}" >&2
    exit 1
    ;;
esac

# Map every host to 127.0.0.1
while read -r host; do
  # Skip empty lines (rules without a host)
  [[ -z "$host" ]] && continue

  echo "127.0.0.1 $host" | sudo tee -a "$HOSTS_FILE" > /dev/null
  echo "Added: 127.0.0.1 $host"
done <<< "$hosts"