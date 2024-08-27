#!/bin/bash
[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1

python3.10 scripts/generate_dc_doc.py dc/* conf/*.env > docker_compose_services.md
git add docker_compose_services.md
git commit -m "update docker_compose_services.md"
git tag -a ${VERSION} -m "ARLAS Exploration stack ${VERSION}"
git push origin ${VERSION}
