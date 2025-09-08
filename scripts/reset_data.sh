#!/bin/bash
set -o errexit -o pipefail

docker volume rm arlas-data-es arlas-persist arlas-postgres arlas-data-minio
