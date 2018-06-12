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
  { elasticsearch_put_index_return_code=$(curl -o /dev/stderr -w "%{http_code}" -s $elasticsearch_options -X PUT "$elasticsearch/$elasticsearch_index/" -d@/initialization/elasticsearch_mapping.json -H 'Content-Type: application/json');  } 2>&1
  echo
  if (( $elasticsearch_put_index_return_code != 200 )); then
    exit 1
  fi
  echo "Indexing data in elasticsearch..."
  cat /initialization/data | "./logstash-$logstash_version/bin/logstash" -f "/initialization/logstash_configuration"
}

arlas (){
  echo "Force elasticsearch index in ARLAS server collection..."
  jq -r ".index_name=\"$elasticsearch_index\"" /initialization/server_collection.json > /tmp/server_collection.json
  mv /tmp/server_collection.json /initialization/server_collection.json

  echo "Creating collection in ARLAS server..."
  curl -s -X PUT --header 'Content-Type: application/json;charset=utf-8' --header 'Accept: application/json' -d@/initialization/server_collection.json "$server_initialization_URL/arlas/collections/$server_collection_name"
  echo
}

load_WUI_configuration () {
  echo "Loading WUI configuration..."
  jq -r ".arlas.server.url=\"$server_URL/arlas\" | .arlas.server.collection.name=\"$server_collection_name\"" "/initialization/WUI_configuration.json" > /wui-configuration/config.json
  cp "/initialization/WUI_map_configuration.json" /wui-configuration/config.map.json
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

###########
# Script
###########

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

break_line='--------------'

export elasticsearch=${elasticsearch:-http://elasticsearch:9200}
export elasticsearch_index=${elasticsearch_index:-arlas-data}
export server_collection_name=${server_collection_name:-data}
export server_initialization_URL="${server_initialization_URL:-http://arlas-server:9999}"
export server_URL="${server_URL:-http://localhost:9999}"

[[ -n "${elasticsearch_password}" ]] && elasticsearch_options=" -u $elasticsearch_user:$elasticsearch_password"

echo "Configuration:"
echo "$break_line"

variables=( \
  elasticsearch \
  elasticsearch_index \
  elasticsearch_user \
  server_collection_name \
  server_initialization_URL \
  server_initialization_URL \
  server_URL \
  )

longest_variable_name_length=$(longest_string_length ${variables[@]})
padding=$(printf ' %.0s' $(seq 1 $((longest_variable_name_length + 5)) ) )

for variable in ${variables[@]}; do

  if [[ -v "$variable" ]]; then
    printf "%s: %s %s\n" "$variable" "${padding:${#variable}}" "${!variable}"
    #echo "$variable: ${!variable}"
  fi

done

echo "$break_line"

index
arlas
load_WUI_configuration

echo "Done"
