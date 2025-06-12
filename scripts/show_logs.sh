#!/bin/bash

show(){
    container=$1
    echo "LOGS FOR $container"
    docker logs $container --tail 100
}

show apisix
show keycloak
show arlas-server
show arlas-persistence-server
show agate
show aproc-proc
