#!/bin/bash
[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1

# Generate the md documentation
./mkDocs.sh

# Tag the version
git add docs/docs/dc_services/docker_compose_services_*.md
git commit -m "Update docker compose services documentation"
git tag -a ${VERSION} -m "ARLAS Exploration stack ${VERSION}"
git push origin ${VERSION}
