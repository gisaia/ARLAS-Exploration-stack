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
sleep 10

test_status GET "http://localhost:80/hub/assets/hub-icon.png" 200
test_status GET "http://localhost:80/permissions/authorize/resources" 200
test_status GET "http://localhost:80/permissions/authorize/resources" 200
test_status GET "http://localhost:80/persist/persist/resources/config.json?size=20&page=1&order=desc" 200
test_status GET "http://localhost:80/server/collections/" 200
test_status GET "http://localhost:80/wui/favicon.ico" 200
test_status GET "http://localhost:80/builder/favicon.ico" 200
test_status GET "http://localhost:9999" 000
