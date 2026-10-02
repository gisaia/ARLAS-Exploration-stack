#!/usr/bin/env sh
echo "launching the tests."

SITE_HOST=site.arlas.k8s
KC_HOST=keycloak.arlas.k8s
namespace=arlas
test_status (){
    verb=$1
    endpoint=$2
    expected=$3
    service=$4
    computed=$(curl -X "${verb}" -k -s -o /dev/null -w "%{http_code}" "${endpoint}")
    if [ "$computed" != "$expected" ]; then
        echo $endpoint NOT ok : $computed " < > " $expected
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
test_status GET "https://$SITE_HOST/wui/favicon.ico" 200 arlas-wui
test_status GET "https://$SITE_HOST/hub/assets/hub-icon.png" 200 arlas-hub
test_status GET "https://$SITE_HOST/builder/favicon.ico" 200 arlas-builder
test_status GET "https://$SITE_HOST/fam-wui/favicon.ico" 200 arlas-fam-wui
test_status GET "https://$SITE_HOST/arlas/collections/" 401 arlas-server
test_status GET "https://$SITE_HOST/aproc/processes/" 401 aproc-service
test_status GET "https://$SITE_HOST/aproc/jobs/" 401 aproc-service
test_status GET "https://$SITE_HOST/airs/collections/" 401 airs-server
test_status GET "https://$SITE_HOST/fam/files" 401 arlas-fam-
test_status GET "https://$SITE_HOST/persist/persist/resources/config.json?size=20&page=1&order=desc" 200 arlas-persistence-server
test_status GET "https://$SITE_HOST/permissions/authorize/resources?filter=persist%2Fresource%2F&pretty=false" 200 arlas-permissions-server
test_status GET "https://$KC_HOST/realms/arlas/.well-known/uma2-configuration" 200 keycloak-0
echo "All good."
