#!/usr/bin/env bash

set -e -o pipefail

if [[ "$debug" == true ]]; then
  set -x
fi

################################################################################
# Variables
################################################################################

declare -A initialization_steps_mapping
initialization_steps_mapping['es-index']=create_elasticsearch_index
initialization_steps_mapping['index-data']=index_data
initialization_steps_mapping['server-collection']=create_server_collection
initialization_steps_mapping['ui-conf']=load_WUI_configuration
initialization_steps_mapping['ui-map-conf']=load_WUI_map_configuration


################################################################################
# Functions
################################################################################

create_elasticsearch_index () {
  wait_for_elasticsearch

  get_index_response_http_code=$(curl -s -o /dev/null -w "%{http_code}" $elasticsearch_options "$elasticsearch/$elasticsearch_index")
  if (( $get_index_response_http_code == 200 )); then
    log "Deleting pre-existing index from elasticsearch..."
    curl -s $elasticsearch_options -X DELETE "$elasticsearch/$elasticsearch_index"
    echo
  elif (( $get_index_response_http_code == 404 )); then
    log "Done."
    :
  else
    log_error "Undefined response HTTP code while verifying if index is already existing, exiting."
    exit 2
  fi
  log "Creating index in elasticsearch..."
  # see https://superuser.com/questions/590099/can-i-make-curl-fail-with-an-exitcode-different-than-0-if-the-http-status-code-i#comment1768494_590170
  { elasticsearch_put_index_return_code=$(curl -o /dev/stderr -w "%{http_code}" -s $elasticsearch_options -X PUT "$elasticsearch/$elasticsearch_index/" -d@/initialization/data_ingestion/elasticsearch_mapping.json -H 'Content-Type: application/json');  } 2>&1
  echo
  if (( $elasticsearch_put_index_return_code != 200 )); then
    exit 1
  fi
  log "Done."
}

create_server_collection (){
  log "Force elasticsearch index in ARLAS server collection..."
  jq -r ".index_name=\"$elasticsearch_index\"" /initialization/server/collection.json > /tmp/server_collection.json
  mv /tmp/server_collection.json /initialization/server/collection.json
  log "Done."

  log_without_blank_line "Waiting for ARLAS-server to be ready..."
  wait_for "(( \$(curl -s -o /dev/null -w \"%{http_code}\" $server_URL_for_initializer/admin/healthcheck) == 200 ))"
  log "Ready."

  log "Creating collection in ARLAS server..."
  curl -s -X PUT --header 'Content-Type: application/json;charset=utf-8' --header 'Accept: application/json' -d@/initialization/server/collection.json "$server_URL_for_initializer/arlas/collections/$server_collection_name"
  echo
  log "Done."
}

index_data () {
  log "Indexing data in elasticsearch..."
  if [[ -f /initialization/data_ingestion/data ]]; then
    cat /initialization/data_ingestion/data | "./logstash-$logstash_version/bin/logstash" -f "/initialization/data_ingestion/logstash_configuration"
    log "Done."
  else
    "./logstash-$logstash_version/bin/logstash" -f "/initialization/data_ingestion/logstash_configuration"
  fi
}

load_WUI_configuration () {
  log "Loading WUI configuration..."
  jq -r ".arlas.server.url=\"$server_URL_for_client/arlas\" | .arlas.server.collection.name=\"$server_collection_name\"" "/initialization/WUI/config.json" > /wui-configuration/config.json
  log "Done."
}

load_WUI_map_configuration () {
  log "Loading WUI map configuration..."
  cp "/initialization/WUI/config.map.json" /wui-configuration/config.map.json
  log "Done."
}

log () {

# Special case of the 1st log line: we do not want to have a blank line between the command prompt & the 1st log line.
  if ! [[ -v first_log_done ]]; then
    first_log_done=true
  else
    echo
  fi
log_without_blank_line "$1"
}

log_error () {
  >&2 echo "[ERROR] $1" 
}

log_without_blank_line () {
  echo "> $1"
}

longest_string_length () {
  longest=0
  for string in $@; do
    length=${#string}
    if (( $length > $longest )); then
      longest=$length
    fi
  done
  echo $longest
}

wait_for () {
command="${1}"
timeout="${2:-300}"

start="$(date +%s)"
end=$(( start + timeout ))

while (( $(date +%s) < $end )); do
  if eval "${command}"; then
    log_without_blank_line "Ready!"
    return 0
  fi
  echo .
  sleep 10
done

log_error "Timed out waiting for command:"
log_error "  ${command}"
return 1
}

wait_for_elasticsearch () {
  log "Waiting for elasticsearch to be ready..."
  # On single server configuration, the best status we can reach is yellow.
  # See https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster-health.html
  wait_for "(( \$(curl -s -o /dev/null -w \"%{http_code}\" $elasticsearch_options $elasticsearch/_cluster/health?wait_for_status=yellow) == 200 ))"
  log "Ready."
}


################################################################################
# Script
################################################################################

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

break_line='--------------'

export elasticsearch=${elasticsearch:-http://arlas-exploration-stack-elasticsearch:9200}
export elasticsearch_index=${elasticsearch_index:-arlas-data}
export server_collection_name=${server_collection_name:-data}
export server_URL_for_client="${server_URL_for_client:-http://localhost:9999}"
export server_URL_for_initializer="${server_URL_for_initializer:-http://arlas-exploration-stack-server:9999}"

[[ -n "${elasticsearch_password}" ]] && elasticsearch_options=" -u $elasticsearch_user:$elasticsearch_password"

log "Configuration:"
echo "$break_line"

variables=( \
  elasticsearch \
  elasticsearch_index \
  elasticsearch_user \
  initialization_sequence \
  server_collection_name \
  server_URL_for_client \
  server_URL_for_initializer \
  )

longest_variable_name_length=$(longest_string_length ${variables[@]})
padding=$(printf ' %.0s' $(seq 1 $((longest_variable_name_length + 5)) ) )

for variable in ${variables[@]}; do

  if [[ -v "$variable" ]]; then
    printf "%s: %s %s\n" "$variable" "${padding:${#variable}}" "${!variable}"
  fi

done

echo "$break_line"

# Build initialization-steps array
if [[ -v initialization_sequence ]]; then
  IFS=',' read -r -a initialization_sequence_array <<< "$initialization_sequence"
else
  initialization_sequence_array=(
      es-index
      server-collection
      ui-conf
      ui-map-conf
      index-data
    )
fi

# Map initialization steps to functions
functions_sequence=()
for initialization_step in "${initialization_sequence_array[@]}"; do
  if ! [[ -v "initialization_steps_mapping['$initialization_step']" ]]; then
    log_error "Initialization step \`$initialization_step\` undefined, aborting."
    exit 1
  else
    functions_sequence+=("${initialization_steps_mapping["$initialization_step"]}")
  fi
done

for function in "${functions_sequence[@]}"; do
  eval "$function"
done

log_without_blank_line "Initialization finished."
