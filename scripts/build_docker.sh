#!/bin/bash
[ -z "$1" ] && echo "Please provide the name of the component" && exit 1;
[ -z "$2" ] && echo "Please provide the version" && exit 1;
 

if test -f ".env"; then
    source .env
fi
if [ -z "$PLATFORM" ]; then
    PLATFORM="linux/amd64"
fi

if [[ -z "$3" ]]; then
    echo "use default platform"
else
    PLATFORM=$3
fi

echo "build for ${PLATFORM} platform"

build__docker (){
    IMAGE=$1
    VERSION=$2
    echo "Building the image $IMAGE:${VERSION} (${BUILD_ARG})"
    docker build ${BUILD_ARG} --platform ${PLATFORM} -f ${IMAGE}/Dockerfile -t gisaia/${IMAGE}:${VERSION} -t gisaia/${IMAGE}:latest  -t ${IMAGE}:${VERSION} -t ${IMAGE}:latest .
}

build__docker $1 $2 $BUILD_ARG
