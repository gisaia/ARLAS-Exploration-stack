#!/bin/bash
set -o errexit -o pipefail
IP=$(hostname -I | awk '{print $1}')
DOMAIN=${IP}.nip.io


echo "
global:
    dnsDomain: 'site.${DOMAIN}'
    elasticDnsDomain: 'elastic.${DOMAIN}'
    keycloakDnsDomain: 'keycloak.${DOMAIN}'
    keycloak.url: 'https://keycloak.${DOMAIN}/auth'
    authIssuer: 'https://keycloak.${DOMAIN}/auth/realms/arlas'
    openIdProvider: 'https://keycloak.${DOMAIN}/auth/realms/arlas/.well-known/openid-configuration'" > custom_values.yaml
