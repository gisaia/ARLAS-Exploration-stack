#!/bin/bash
set -o errexit -o pipefail

# Stop Docker compose services
eval "docker compose -p arlas-exploration-stack down"
