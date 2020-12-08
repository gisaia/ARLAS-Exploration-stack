#!/bin/bash
set -o errexit -o pipefail
#Set env variables using env.sh
source ./env.sh;
#Set variables in .env as env variable id .env file exist
envFile=.env
if [ -f "$envFile" ];then
    export $(eval "echo \"$(cat .env)\"" | xargs)
fi
eval "docker-compose down"
