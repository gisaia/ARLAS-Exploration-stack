#!/bin/sh -e

# Generate documentation
pip3 install ruamel.yaml
mkdir -p docs/docs/dc_services

python3 scripts/generate_dc_doc.py \
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
    > docs/docs/dc_services/docker_compose_services_simple.md

python3 scripts/generate_dc_doc.py \
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
    > docs/docs/dc_services/docker_compose_services_iam.md

python3 scripts/generate_dc_doc.py \
    dc/ref-dc-elastic.yaml \
    dc/ref-dc-arlas-server.yaml \
    dc/ref-dc-arlas-persistence-server.yaml \
    dc/ref-dc-arlas-permissions-server.yaml \
    dc/ref-dc-keycloak.yaml \
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
    conf/arlas_keycloak.env \
    > docs/docs/dc_services/docker_compose_services_kc.md

python3 scripts/generate_dc_doc.py \
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
    > docs/docs/dc_services/docker_compose_services_aias.md


python3 scripts/generate_dc_doc.py \
    dc/ref-dc-elastic.yaml \
    dc/ref-dc-arlas-server.yaml \
    dc/ref-dc-arlas-persistence-server.yaml \
    dc/ref-dc-arlas-permissions-server.yaml \
    dc/ref-dc-arlas-builder.yaml \
    dc/ref-dc-arlas-hub.yaml \
    dc/ref-dc-arlas-wui.yaml \
    dc/ref-dc-protomaps.yaml \
    dc/ref-dc-apisix.yaml \
    dc/ref-dc-keycloak.yaml \
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
    conf/arlas_keycloak.env \
    conf/postgres.env \
    > docs/docs/dc_services/docker_compose_services_aiaskc.md

# Check if helm-docs is already installed
if command -v helm-docs >/dev/null 2>&1; then
    echo "helm-docs already installed: $(helm-docs --version)"
else
    echo "helm-docs not found, installing..."
    # Download the precompiled binary archive
    VERSION="v1.14.2"
    BINARY_URL="https://github.com/norwoodj/helm-docs/releases/download/${VERSION}/helm-docs_${VERSION#v}_Linux_x86_64.tar.gz"
    wget -q "$BINARY_URL" -O /tmp/helm-docs.tar.gz
    # Extract the binary
    tar -xzf /tmp/helm-docs.tar.gz -C /tmp
fi
    echo "helm-docs installed: $(helm-docs --version)"
    rm /tmp/helm-docs.tar.gz
    # Clean up
    sudo mv /tmp/helm-docs /usr/local/bin/
    # Move it into /usr/local/bin so it's available in PATH
# Generate helm documentation
helm-docs k8s/charts/
cp k8s/charts/aias-services/README.md docs/docs/helm/aias-services
cp k8s/charts/arlas-services/README.md docs/docs/helm/arlas-services
cp k8s/charts/arlas-stack/README.md docs/docs/helm/arlas-stack
cp k8s/charts/arlas-uis/README.md docs/docs/helm/arlas-uis

# Copy documentation to target
rm -rf target/generated-docs
mkdir -p target/generated-docs
cp -r docs/docs/* target/generated-docs

