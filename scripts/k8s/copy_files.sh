#!/bin/bash
set -o errexit -o pipefail

./scripts/k8s/copy_to_pod.sh arlas-wui conf/protomaps/. /usr/share/nginx/html/assets/basemap
