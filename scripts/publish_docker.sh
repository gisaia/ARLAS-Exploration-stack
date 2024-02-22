#!/bin/bash
[ -z "$1" ] && echo "Please provide the name of the compononet" && exit 1;
[ -z "$2" ] && echo "Please provide the version" && exit 1;

publish_docker (){
    IMAGE=$1
    VERSION=$2
    echo "Publishing the image $IMAGE"
    docker login
    docker push gisaia/${IMAGE}:${VERSION}
}

publish_docker $1 $2

if [[ -z "$3" ]]; then
    echo "Do not publish latest"
else
    if [ "${3}" == "latest" ]; then
        echo "Also publish latest"
        publish_docker $1 latest
    else
        echo "Parameter '$3' not recognized"
    fi
fi
