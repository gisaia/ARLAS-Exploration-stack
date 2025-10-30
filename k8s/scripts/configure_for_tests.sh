#!/bin/bash
set -o errexit -o pipefail
IP=$(hostname -I | awk '{print $1}')
DOMAIN=${IP}.nip.io


echo "
global:
    dnsDomain: &arlasAppDnsDomain 'site.${DOMAIN}'
    elasticDnsDomain: &arlasAppElasticDnsDomain 'elastic.${DOMAIN}'
    keycloakDnsDomain: &arlasAppKeycloakDnsDomain 'keycloak.${DOMAIN}'
    keycloak:
        url: &arlasAppKeycloakUrl 'https://keycloak.${DOMAIN}/auth'
    authIssuer: &arlasAppAuthIssuer 'https://keycloak.${DOMAIN}/auth/realms/arlas'
    openIdProvider: &arlasAppOpenIdProvider 'https://keycloak.${DOMAIN}/auth/realms/arlas/.well-known/openid-configuration'" > custom_values.yaml
