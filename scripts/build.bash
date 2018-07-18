#!/bin/bash

set -e -o pipefail

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
project_root_directory="$(dirname "$script_directory")"

################################################################################

cd "$project_root_directory/arlas-exploration-stack-manager"
docker build -t gisaia/arlas-exploration-stack-manager .

cd "$project_root_directory/arlas-exploration-stack-initializer"
docker build -t gisaia/arlas-exploration-stack-initializer .
