#!/bin/bash
[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1

# NGINX
./scripts/build_docker.sh arlas-stack-nginx $VERSION "linux/amd64"
./scripts/publish_docker.sh arlas-stack-nginx $VERSION "linux/amd64"

git tag -a ${VERSION} -m "COF-NG ${VERSION}"
git push origin ${VERSION}
