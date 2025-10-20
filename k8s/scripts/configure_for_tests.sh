#!/bin/bash
set -o errexit -o pipefail
IP=$(hostname -I | awk '{print $1}')
DOMAIN=${IP}.nip.io

yq eval \
    '.global.dnsDomain = "'site.${DOMAIN}'"
    | .global.elasticDnsDomain = "'elastic.${DOMAIN}'" 
    | .global.keycloakDnsDomain = "'keycloak.${DOMAIN}'" 
    | .global.keycloak.url = "'https://keycloak.${DOMAIN}/auth'" 
    | .global.authIssuer = "'https://keycloak.${DOMAIN}/auth/realms/arlas'" 
    | .global.openIdProvider = "'https://keycloak.${DOMAIN}/auth/realms/arlas/.well-known/openid-configuration'"' \
    -i k8s/charts/arlas-stack/values.yaml
