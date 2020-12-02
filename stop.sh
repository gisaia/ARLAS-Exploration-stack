#!/bin/bash
set -o errexit -o pipefail
export $(eval "echo \"$(cat .env)\"" | xargs)
eval "docker-compose down"
