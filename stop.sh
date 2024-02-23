#!/bin/bash
set -o errexit -o pipefail
SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd)"

#Set env variables using env.sh
source $SCRIPT_DIRECTORY/env.sh;
#Set variables in .env as env variable id .env file exist
envFile=$SCRIPT_DIRECTORY/.env
if [ -f "$envFile" ];then
    export $(eval "echo \"$(cat .env)\"" | xargs)
fi

eval "docker-compose -p arlas_exploration_stack -f $SCRIPT_DIRECTORY/docker-compose-arlas-stack.yaml down"
