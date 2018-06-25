#!/bin/bash

script_directory="$(cd "$(dirname "$0")"; pwd -P)"

docker run \
  -i \
  --mount dst=/var/run/docker.sock,src=/var/run/docker.sock,type=bind \
  --mount dst=/.env_user,src="$script_directory"/.env,type=bind \
  --mount dst=/environment/user,src="$script_directory"/environment,type=bind \
  --name arlas-stack-manager \
  --rm \
  -t \
  gisaia/arlas-stack-manager $@
