#!/bin/bash
set -o errexit -o pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
PROJECT_ROOT_DIRECTORY="$SCRIPT_DIRECTORY"

usage(){
	echo "Usage: ./start.sh [--arlas-server-url] [--es-cluster] "
	echo " -asu|--arlas-server-url       URL of a arlas-server service to use. If not set, $LOCAL_HOST:19999 is considered"
	echo " -esc|--es-cluster             ES cluster to use. If not set, $LOCAL_HOST:9200/arlas is considered"
    echo " -h|--help                     Display manual"
	exit 1
}
export $(egrep -v '^#' .env | xargs)

for i in "$@"
do
case $i in
    -h|--help)
    ARLAS_HELP="true"
    shift # past argument=value
    ;;
    -asu=*|--arlas-server-url=*)
    export ARLAS_SERVER_URL="${i#*=}"
    shift # past argument=value
    ;;
    -esc=*|--es-cluster=*)
    export ES_CLUSTER="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

if [ ! -z ${ARLAS_HELP+x} ];
    then
        usage;
fi

if [ ! -z ${ES_CLUSTER+x} ];
    then
        echo "ELASTICSEARCH is running on cluster $ES_CLUSTER"
    else
        ES_CLUSTER=$LOCAL_HOST:9200
        echo "ELASTICSEARCH is running on $LOCAL_HOST:9200"
fi 
if [ ! -z ${ARLAS_SERVER_URL+x} ];
    then
        echo "ARLAS-server is running on $ARLAS_SERVER_URL"
    else
        ARLAS_SERVER_URL=$LOCAL_HOST:19999/arlas
        echo "ARLAS-server is running on $LOCAL_HOST:19999/arlas"
fi 

echo "## Deleting 'airport_index' in case it already exists"
curl -f -X DELETE "${ES_CLUSTER}/airport_index?pretty"  || echo " !!! Couldn't reach Elasticsearch at ${ES_CLUSTER}"; echo ""; usage; exit -1;

echo "## Creating 'airport_index'"
curl -f -XPUT \
  -H 'Content-Type: application/json' \
  "${ES_CLUSTER}/airport_index?pretty" \
  --data @$SCRIPT_DIRECTORY/data/airport_mapping.json || echo " !!! Couldn't reach Elasticsearch at ${ES_CLUSTER}"; echo ""; usage; exit -1;
  
echo "## Adding data to 'airport_index'"
curl -s -H "Content-Type: application/json" \
  -XPOST "${ES_CLUSTER}/airport_index/_bulk?pretty&refresh" \
  --data-binary @${SCRIPT_DIRECTORY}/data/data.txt > /dev/null
echo "   -> Data added"

echo "## Referecing 'airport_index' in ARLAS-server"
bash ${SCRIPT_DIRECTORY}/collections/create_collection.sh -asu=${ARLAS_SERVER_URL} -n="airport_collection" -i="airport_index" -ip="id" -tp="startdate" -gp="geometry" -cp="centroid"