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

if [ "$1" = "aias" ] || [ "$1" = "aiaskc" ]
then
    show airs-server
    show aproc-service
    show aproc-proc
    show fam-service
    show agate
fi


if [ "$1" = "iam" ] || [ "$1" = "aias" ]
then
    show arlas-iam-server
fi
