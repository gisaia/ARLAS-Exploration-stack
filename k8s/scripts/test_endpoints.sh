#!/usr/bin/env sh

usage() {
    echo "Usage: $0 <ingress|gateway>"
    exit 1
}

# The routing mode is required: ingress or gateway
if [ $# -ne 1 ]; then
    usage
fi

MODE=$1

# Expected status codes for persist and permissions depend on the mode
case "$MODE" in
    ingress)
        PERSIST_EXPECTED=200
        PERMISSIONS_EXPECTED=200
        ;;
    gateway)
        PERSIST_EXPECTED=401
        PERMISSIONS_EXPECTED=401
        ;;
    *)
        echo "Invalid parameter: '$MODE'"
        usage
        ;;
esac

echo "launching the tests (mode: $MODE)."

SITE_HOST=site.arlas.k8s
KC_HOST=keycloak.arlas.k8s
namespace=arlas

# Call an endpoint and compare the HTTP status code with the expected one.
# On mismatch, print the pod description and logs of the related service, then exit.
# Args: <verb> <endpoint> <expected status> <pod name prefix>
test_status (){
    verb=$1
    endpoint=$2
    expected=$3
    service=$4
    computed=$(curl -X "${verb}" -k -s -o /dev/null -w "%{http_code}" "${endpoint}")
    if [ "$computed" != "$expected" ]; then
        echo $endpoint NOT ok : $computed " < > " $expected
        # Find the first pod whose name starts with the service prefix
        pod=$(kubectl get pods -n "$namespace" \
            -o custom-columns=NAME:.metadata.name --no-headers |
            awk -v prefix="$service" 'index($0, prefix) == 1 { print; exit }')
        printf '\n=== Describe : %s ===\n' "$pod"
        kubectl describe pod "$pod" -n "$namespace"
        printf '\n=== Logs : %s ===\n' "$pod"
        kubectl logs "$pod" -n "$namespace" --all-containers=true --tail=200
        exit 1
    else
        echo $endpoint "ok: " $verb " is " $computed
    fi
}

# Endpoints with the same expected status in both modes
test_status GET "https://$SITE_HOST/wui/favicon.ico" 200 arlas-wui
test_status GET "https://$SITE_HOST/hub/assets/hub-icon.png" 200 arlas-hub
test_status GET "https://$SITE_HOST/builder/favicon.ico" 200 arlas-builder
test_status GET "https://$SITE_HOST/fam-wui/favicon.ico" 200 arlas-fam-wui
test_status GET "https://$SITE_HOST/arlas/collections/" 401 arlas-server
test_status GET "https://$SITE_HOST/aproc/processes/" 401 aproc-service
test_status GET "https://$SITE_HOST/aproc/jobs/" 401 aproc-service
test_status GET "https://$SITE_HOST/airs/collections/" 401 airs-server
test_status GET "https://$SITE_HOST/fam/files" 401 arlas-fam-

# Endpoints whose expected status depends on the mode (ingress: 200, gateway: 401)
test_status GET "https://$SITE_HOST/persist/persist/resources/config.json?size=20&page=1&order=desc" "$PERSIST_EXPECTED" arlas-persistence-server
test_status GET "https://$SITE_HOST/permissions/authorize/resources?filter=persist%2Fresource%2F&pretty=false" "$PERMISSIONS_EXPECTED" arlas-permissions-server

# Keycloak
test_status GET "https://$KC_HOST/realms/arlas/.well-known/uma2-configuration" 200 keycloak-0

echo "All good."