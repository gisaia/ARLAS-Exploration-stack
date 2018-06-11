#!/bin/bash -e

###########
# Functions
###########

index (){
  get_index_response_http_code=$(curl -s -o /dev/null -w "%{http_code}" $elasticsearch_options "$elasticsearch/$elasticsearch_index")
  if (( $get_index_response_http_code == 200 )); then
    echo "Deleting pre-existing index from elasticsearch..."
    curl -s $elasticsearch_options -X DELETE "$elasticsearch/$elasticsearch_index"
    echo
  elif (( $get_index_response_http_code == 404 )); then
    :
  else
    >&2 echo "Undefined response HTTP code while verifying if index is already existing, exiting."
    exit 2
  fi
  echo "Creating index in elasticsearch..."
  # see https://superuser.com/questions/590099/can-i-make-curl-fail-with-an-exitcode-different-than-0-if-the-http-status-code-i#comment1768494_590170
  { elasticsearch_put_index_return_code=$(curl -o /dev/stderr -w "%{http_code}" -s $elasticsearch_options -X PUT "$elasticsearch/$elasticsearch_index/" -d @/initialization/elasticsearch_mapping.json -H 'Content-Type: application/json');  } 2>&1
  echo
  if (( $elasticsearch_put_index_return_code != 200 )); then
    exit 1
  fi
  echo "Indexing data in elasticsearch..."
  cat /initialization/data | "./logstash-$logstash_version/bin/logstash" -f "/initialization/logstash_configuration"
}

arlas (){
  echo "Force elasticsearch index in ARLAS server collection..."
  jq -r ".index_name=\"$elasticsearch_index\"" > /tmp/server_collection.json
  mv /tmp/server_collection.json /initialization/server_collection.json

  echo "Creating collection in ARLAS server..."
  curl -s -X PUT --header 'Content-Type: application/json;charset=utf-8' --header 'Accept: application/json' -d@"$server_collection" "$server_initialization_URL/arlas/collections/$server_collection_name"
  echo
}

load_WUI_configuration () {
  echo "Loading WUI configuration..."
  jq -r ".arlas.server.url=\"$server_URL/arlas\"" "$WUI_configuration" > /wui-configuration/config.json
  cp "$WUI_map_configuration" /wui-configuration/config.map.json
}


###########
# Script
###########

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

break_line='--------------'

elasticsearch=${elasticsearch:-http://elasticsearch:9200}
elasticsearch_index=${elasticsearch_index:-arlas-data}
server_collection_name=${server_collection_name:-data}
server_initialization_URL="${server_initialization_URL:-http://arlas-server:9999}"
server_URL="${server_URL:-http://localhost:9999}"

[[ -n "${elasticsearch_password}" ]] && elasticsearch_options=" -u $elasticsearch_user:$elasticsearch_password"

echo "Configuration:"
echo "$break_line"

for variable in \
  elasticsearch \
  elasticsearch_index \
  elasticsearch_user \
  server_collection_name \
  server_initialization_URL \
  server_URL; do

  if [[ -v "$variable" ]]; then
    echo "$variable: ${!variable}"
  fi

done

echo "$break_line"

index
arlas
load_WUI_configuration

echo "Done"
