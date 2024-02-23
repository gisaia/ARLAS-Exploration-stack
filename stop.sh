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

DOCKER_COMPOSE_FILES="-f $SCRIPT_DIRECTORY/docker-compose-arlas-builder.yaml -f $SCRIPT_DIRECTORY/docker-compose-arlas-hub.yaml -f $SCRIPT_DIRECTORY/docker-compose-arlas-permissions.yaml -f $SCRIPT_DIRECTORY/docker-compose-arlas-persistence.yaml -f $SCRIPT_DIRECTORY/docker-compose-arlas-server.yaml -f $SCRIPT_DIRECTORY/docker-compose-arlas-wui.yaml -f $SCRIPT_DIRECTORY/docker-compose-elasticsearch.yaml -f $SCRIPT_DIRECTORY/docker-compose-net.yaml -f $SCRIPT_DIRECTORY/docker-compose-nginx.yaml -f $SCRIPT_DIRECTORY/docker-compose-volumes.yaml"

#Run Docker-compose services
eval "docker-compose -p arlas_exploration_stack $DOCKER_COMPOSE_FILES down"

