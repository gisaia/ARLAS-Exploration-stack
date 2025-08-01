#!/bin/bash
set -o errexit -o pipefail

./k8s/scripts/copy_to_pod.sh arlas arlas-wui conf/protomaps/. /usr/share/nginx/html/assets/basemap
