#!/bin/bash
curl https://raw.githubusercontent.com/gisaia/aias/refs/tags/0.18.1/conf/mapping.json -o arlas_eo_mapping.json
curl https://raw.githubusercontent.com/gisaia/aias/refs/tags/0.18.1/conf/downloads_mapping.json -o arlas_eo_download_mapping.json
kubectl create configmap \
    arlas-eo-mappings-configmap \
    --from-file=arlas_eo_mapping.json=arlas_eo_mapping.json \
    --from-file=arlas_eo_download_mapping.json=arlas_eo_download_mapping.json \
    -o yaml --dry-run=client \
    > k8s/charts/aias-services/templates/arlas-eo-mappings-configmap.yaml
