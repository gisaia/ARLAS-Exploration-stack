#!/bin/bash -e

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
break_line='--------------'

required_variables=( \
  data_file \
  elasticsearch \
  elasticsearch_index \
  elasticsearch_mapping \
  logstash_configuration \
  server_collection \
  server_collection_name \
  WUI_configuration \
  WUI_map_configuration \
  )

echo "Configuration:"
echo "$break_line"
for variable in ${required_variables[@]} logstash_version; do
  if [[ -z ${!variable+x} ]]; then
    >&2 echo "[ERROR] Missing required environment variable \"$variable\", exiting..."
    exit 1
  else
    echo "$variable: ${!variable}"
  fi
done
[[ -n "${elasticsearch_password}" ]] && elasticsearch_options=" -u $elasticsearch_user:$elasticsearch_password"

server=${server:-http://localhost:9999}
echo "server: $server"

echo "$break_line"

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
  { elasticsearch_put_index_return_code=$(curl -o /dev/stderr -w "%{http_code}" -s $elasticsearch_options -X PUT "$elasticsearch/$elasticsearch_index/" -d @"$elasticsearch_mapping" -H 'Content-Type: application/json');  } 2>&1
  echo
  if (( $elasticsearch_put_index_return_code != 200 )); then
    exit 1
  fi
  echo "Indexing data in elasticsearch..."
  cat "$data_file" | "./logstash-$logstash_version/bin/logstash" -f "$logstash_configuration"
}

arlas (){
  echo "Creating collection in ARLAS server..."
  curl -s -X PUT --header 'Content-Type: application/json;charset=utf-8' --header 'Accept: application/json' -d@"$server_collection" "$server/arlas/collections/$server_collection_name"
  echo
}

load_WUI_configuration () {
  echo "Loading wui configuration..."
  cp "$WUI_configuration" /wui-configuration/config.json
  cp "$WUI_map_configuration" /wui-configuration/config.map.json
}

index
arlas
load_WUI_configuration

echo "Done"
