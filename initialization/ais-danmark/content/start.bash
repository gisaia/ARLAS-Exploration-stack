#!/bin/bash -e

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INDEXNAME=ais-danmark

[[ -z "${ELASTICSEARCH}" ]] && echo "Missing required environment variable: ELASTICSEARCH." && exit 1
[[ -z "${ARLAS_SERVER}" ]] && echo "Missing required environment variable: ARLAS_SERVER." && exit 1
[[ -n "${ELASTICSEARCH_PASSWORD}" ]] && ELASTICSEARCH_OPTIONS=" -u $ELASTICSEARCH_USER:$ELASTICSEARCH_PASSWORD "

echo "ELASTICSEARCH: $ELASTICSEARCH"

index (){
  get_index_response_http_code=$(curl -s -o /dev/null -w "%{http_code}" $ELASTICSEARCH_OPTIONS "$ELASTICSEARCH/$INDEXNAME")
  if (( $get_index_response_http_code == 200 )); then
    echo "Deleting pre-existing index from elasticsearch..."
    curl -s $ELASTICSEARCH_OPTIONS -X DELETE "$ELASTICSEARCH/$INDEXNAME"
    echo
  elif (( $get_index_response_http_code == 404 )); then
    :
  else
    >&2 echo "Undefined response HTTP code while verifying if index is already existing, exiting."
    exit 2
  fi
  echo "Creating index in elasticsearch..."
  curl -s $ELASTICSEARCH_OPTIONS -X PUT "$ELASTICSEARCH/$INDEXNAME/" -d @mapping.json -H 'Content-Type: application/json'
  echo
  echo "Indexing data in elasticsearch..."
  cat aisdk_20180102_head100000.csv | "./logstash-$logstash_version/bin/logstash" -f csv2es.logstash.conf
}

arlas (){
  echo "Creating collection in ARLAS server..."
  curl -s -X PUT --header 'Content-Type: application/json;charset=utf-8' --header 'Accept: application/json' -d '{"index_name": "'$INDEXNAME'", "type_name": "logs", "id_path": "vessel.mmsi", "geometry_path": "course.segment.geometry.geometry", "centroid_path": "position.location", "timestamp_path": "position.timestamp" }' "$ARLAS_SERVER/arlas/collections/ais-danmark"
  echo
}

index
arlas

echo "Upload wui configuration..."
curl -s https://raw.githubusercontent.com/gisaia/ARLAS-wui/feat/ais-data/src/config.json | jq '.arlas.server.url="http://localhost:9999/arlas"' > /wui-configuration/config.json
curl -o /wui-configuration/config.map.json -s https://raw.githubusercontent.com/gisaia/ARLAS-wui/feat/ais-data/src/config.map.json
echo "Done"