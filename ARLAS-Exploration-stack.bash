#!/bin/bash -e

script_directory="$(cd "$(dirname "${BASHSOURCE[0]}")"; pwd -P)"

# Create user configuration files if they do not exist, otherwise the docker run command will fail
mkdir -p environment
for file in .env \
  environment/arlas-exploration-stack-server \
  environment/arlas-exploration-stack-wui \
  environment/arlas-exploration-stack-elasticsearch; do
  if ! [[ -f "$file" ]]; then
    touch "$file"
  fi
done

docker run \
  -i \
  --mount dst=/var/run/docker.sock,src=/var/run/docker.sock,type=bind \
  --mount dst=/.env_user,src="$script_directory"/.env,type=bind \
  --mount dst=/environment/user,src="$script_directory"/environment,type=bind \
  --name arlas-exploration-stack-manager \
  --rm \
  -t \
  gisaia/arlas-exploration-stack-manager $@
