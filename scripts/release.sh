#!/bin/bash
[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1

python3.10 scripts/generate_dc_doc.py \
    dc/ref-dc-elastic.yaml \
    dc/ref-dc-arlas-server.yaml \
    dc/ref-dc-arlas-persistence-server.yaml \
    dc/ref-dc-arlas-permissions-server.yaml \
    dc/ref-dc-arlas-builder.yaml \
    dc/ref-dc-arlas-hub.yaml \
    dc/ref-dc-arlas-wui.yaml \
    dc/ref-dc-protomaps.yaml \
    dc/ref-dc-apisix.yaml \
    conf/versions.env \
    conf/elastic.env \
    conf/arlas.env \
    conf/persistence-file.env \
    conf/permissions.env \
    conf/apisix.env \
    conf/restart_strategy.env \
    conf/stack.env \
    > docker_compose_services_simple.md

python3.10 scripts/generate_dc_doc.py \
    dc/ref-dc-elastic.yaml \
    dc/ref-dc-arlas-server.yaml \
    dc/ref-dc-arlas-persistence-server.yaml \
    dc/ref-dc-arlas-permissions-server.yaml \
    dc/ref-dc-iam-server.yaml \
    dc/ref-dc-iam-wui.yaml \
    dc/ref-dc-arlas-builder.yaml \
    dc/ref-dc-arlas-hub.yaml \
    dc/ref-dc-arlas-wui.yaml \
    dc/ref-dc-protomaps.yaml \
    dc/ref-dc-apisix.yaml \
    dc/ref-dc-postgres.yaml \
    conf/versions.env \
    conf/elastic.env \
    conf/arlas.env \
    conf/persistence-file.env \
    conf/permissions.env \
    conf/apisix.env \
    conf/restart_strategy.env \
    conf/stack.env \
    conf/arlas_iam.env \
    conf/postgres.env \
    > docker_compose_services_iam.md

python3.10 scripts/generate_dc_doc.py \
    dc/ref-dc-elastic.yaml \
    dc/ref-dc-arlas-server.yaml \
    dc/ref-dc-arlas-persistence-server.yaml \
    dc/ref-dc-arlas-permissions-server.yaml \
    dc/ref-dc-iam-server.yaml \
    dc/ref-dc-iam-wui.yaml \
    dc/ref-dc-arlas-builder.yaml \
    dc/ref-dc-arlas-hub.yaml \
    dc/ref-dc-arlas-wui.yaml \
    dc/ref-dc-protomaps.yaml \
    dc/ref-dc-apisix.yaml \
    dc/ref-dc-postgres.yaml \
    dc/ref-dc-aias-airs.yaml \
    dc/ref-dc-aias-aproc-proc.yaml \
    dc/ref-dc-aias-aproc-service.yaml \
    dc/ref-dc-aias-fam-wui.yaml \
    dc/ref-dc-aias-fam.yaml \
    dc/ref-dc-aias-minio.yaml \
    dc/ref-dc-aias-rabbitmq.yaml \
    dc/ref-dc-aias-redis.yaml \
    dc/ref-dc-aias-volumes.yaml \
    dc/ref-dc-aias-agate.yaml \
    conf/aias.env \
    conf/minio.env \
    conf/versions.env \
    conf/elastic.env \
    conf/arlas.env \
    conf/persistence-file.env \
    conf/permissions.env \
    conf/apisix.env \
    conf/restart_strategy.env \
    conf/stack.env \
    conf/arlas_iam.env \
    conf/postgres.env \
    > docker_compose_services_aias.md

git add docker_compose_services_*.md
git commit -m "update docker compose services documentation"
git tag -a ${VERSION} -m "ARLAS Exploration stack ${VERSION}"
git push origin ${VERSION}
