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

test_status GET "http://localhost/hub/assets/hub-icon.png" 200
test_status GET "http://localhost/permissions/authorize/resources" 200
test_status GET "http://localhost/permissions/authorize/resources" 200
test_status GET "http://localhost/persist/persist/resources/config.json?size=20&page=1&order=desc" 200
test_status GET "http://localhost/arlas/collections/" 200
test_status GET "http://localhost/wui/favicon.ico" 200
test_status GET "http://localhost/builder/favicon.ico" 200
test_status GET "http://localhost:9999" 000
