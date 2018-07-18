#!/bin/bash

set -e -o pipefail

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
project_root_directory="$(dirname "$script_directory")"

# Dependencies:
# - bash >= 4
# - docker
# - yq
#   - jq


################################################################################
# Variables
################################################################################

server_container_port="$(yq -r '.services.server.ports[0]' arlas-exploration-stack-manager/docker-compose.yml | cut -d : -f 2)"
# in seconds
timeout=180
user_interface_container_port="$(yq -r '.services.WUI.ports[0]' arlas-exploration-stack-manager/docker-compose.yml | cut -d : -f 2)"


################################################################################
# Functions
################################################################################

delete_initializer () {
  if docker inspect arlas-exploration-stack-initializer &>>/dev/null; then
    docker rm -f arlas-exploration-stack-initializer
  fi
}

get_server_host_port () {
  docker inspect arlas-exploration-stack-server -f "{{ (index (index .HostConfig.PortBindings \"${server_container_port}/tcp\") 0).HostPort }}"
}

get_user_interface_host_port () {
  docker inspect arlas-exploration-stack-wui -f "{{ (index (index .HostConfig.PortBindings \"${user_interface_container_port}/tcp\") 0).HostPort }}"
}

log_header () {
message="$1"

cat >&1 << EOF
################################################################################
# $message
################################################################################
EOF
}

test_get_server_collection () {
  server_host_port="$(get_server_host_port)"

  echo "> Get server collection..."

  # see https://superuser.com/questions/590099/can-i-make-curl-fail-with-an-exitcode-different-than-0-if-the-http-status-code-i#comment1768494_590170
  { get_collection_HTTP_return_code="$(curl -o /dev/stderr -s -w "%{http_code}" "localhost:$server_host_port/arlas/collections/ais-danmark")"; } 2>&1
  echo 

  (( get_collection_HTTP_return_code == 200 ))
}

test_get_user_interface_configuration () {
  user_interface_host_port="$(get_user_interface_host_port)"

  echo "> Get user interface configuration..."

  get_configuration_HTTP_return_code="$(curl -o /dev/null -s -w "%{http_code}" "localhost:$user_interface_host_port/config.json")"
  
  (( get_configuration_HTTP_return_code == 200 ))
}

wait_for () {
  command="${1}"
  timeout="${2}"

  start="$(date +%s)"
  end=$(( start + timeout ))

  while (( $(date +%s) < $end )); do
    if eval "${command}"; then
      return 0
    fi
    sleep 10
  done

  >&2 echo "[ERROR] Timed out waiting for command:"
  >&2 echo "  ${command}"
  return 1
}


################################################################################
# Script
################################################################################

log_header Build
"$script_directory"/build.bash


echo
log_header Up
cd "$project_root_directory"
./ARLAS-Exploration-stack.bash up


echo
log_header Initialize
docker run \
  -d \
  -e elasticsearch_index=ais-danmark \
  -e server_collection_name=ais-danmark \
  -i \
  --mount dst="/initialization",src="$PWD/data_samples/ais-danmark",type=bind \
  --mount type=volume,src=default_wui-configuration,dst=/wui-configuration \
  --name arlas-exploration-stack-initializer \
  --net arlas \
  --rm \
  gisaia/arlas-exploration-stack-initializer


echo
log_header Test
wait_for 'test_get_server_collection && test_get_user_interface_configuration' "$timeout"


echo
log_header 'Test successful!'
echo


delete_initializer
./ARLAS-Exploration-stack.bash down
