#!/usr/bin/env sh

test_status (){
    verb=$1
    endpoint=$2
    expected=$3
    computed=`curl -X ${verb} -k -s -o /dev/null  -I  -w "%{http_code}" "${endpoint}"`

    if [ "$computed" != "$expected" ]; then
        echo $endpoint NOT ok : $computed " < > " $expected
        exit 1
    else
        echo $endpoint "ok: " $verb " is " $computed
    fi
}

if [ -z "$1" ]
then
    test_status GET "http://localhost/hub/assets/hub-icon.png" 200
    test_status GET "http://localhost/wui/favicon.ico" 200
    test_status GET "http://localhost/builder/favicon.ico" 200
    test_status GET "http://localhost/arlas/collections/" 200
    test_status GET "http://localhost/persist/persist/resources/config.json?size=20&page=1&order=desc" 200
    test_status GET "http://localhost/arlas_permissions_server/authorize/resources?filter=persist%2Fresource%2F&pretty=false" 200
    echo "All good."
fi

if [ "$1" = "iam" ] || [ "$1" = "aias" ]
then
    test_status GET "https://localhost/hub/assets/hub-icon.png" 200
    test_status GET "https://localhost/wui/favicon.ico" 200
    test_status GET "https://localhost/builder/favicon.ico" 200
    test_status GET "https://localhost/arlas/healthcheck" 200
    test_status GET "https://localhost/persist/persist/resources/config.json?size=20&page=1&order=desc" 200
    test_status GET "https://localhost/arlas_permissions_server/authorize/resources?filter=persist%2Fresource%2F&pretty=false" 200
    echo "All good for iam."
fi


if [ "$1" = "aias" ]
then
    test_status GET "https://sylvains-macbook-air.lan/aproc/healthcheck" 200
    test_status GET "https://sylvains-macbook-air.lan/agate/healthcheck" 200
    test_status GET "https://sylvains-macbook-air.lan/airs/healthcheck" 200
    echo "All good for aias."
fi
