#!/bin/bash

curl https://raw.githubusercontent.com/gisaia/ARLAS-EO/v1.1.0/mapping.json -o arlas_eo_mapping.json
curl https://raw.githubusercontent.com/gisaia/ARLAS-EO/v1.1.0/downloads_mapping.json -o arlas_eo_download_mapping.json
kubectl create configmap \
    arlas-eo-mappings-configmap \
    --from-file=arlas_eo_mapping.json=arlas_eo_mapping.json \
    --from-file=arlas_eo_download_mapping.json=arlas_eo_download_mapping.json \
    -o yaml --dry-run=client \
    > k8s/charts/aias-services/templates/arlas-eo-mappings-configmap.yaml
