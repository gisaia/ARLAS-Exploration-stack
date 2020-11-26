#!/bin/bash
set -o errexit -o pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
PROJECT_ROOT_DIRECTORY="$SCRIPT_DIRECTORY"

usage(){
	echo "Usage: ./add_data.sh [--arlas-server-url] [--es-cluster] [--es-credentials]"
	echo " -asu|--arlas-server-url       URL of a arlas-server service to use. If not set, $LOCAL_HOST:81/server is considered"
	echo " -esc|--es-cluster             ES cluster to use. If not set, $LOCAL_HOST:9200 is considered"
	echo " -escdr|--es-credentials       Credential to use to connect to ES Cluster (if necessary)"
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
    -escdr=*|--es-credentials=*)
    export ES_CREDENTIALS="${i#*=}"
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
        ARLAS_SERVER_URL=$LOCAL_HOST:81/server
        echo "ARLAS-server is running on $LOCAL_HOST:81/server"
fi 

if [ ! -z ${ES_CREDENTIALS+x} ];
    then
        use_es_credential=true
    else
        ARLAS_SERVER_URL=$LOCAL_HOST:81/server
        echo "ARLAS-server is running on $LOCAL_HOST:81/server"
        use_es_credential=false
fi

if [ "$use_es_credential" = true ];
                then


                    echo "## Creating 'airport_index'"
                    curl -f --user ${ES_CREDENTIALS} -XPUT \
                    -H 'Content-Type: application/json' \
                    "${ES_CLUSTER}/airport_index?pretty" \
                    --data @$SCRIPT_DIRECTORY/data/airport_mapping.json 
                    echo "## Adding data to 'airport_index'"
                    curl -s -H "Content-Type: application/json" \
                    --user ${ES_CREDENTIALS} -XPOST "${ES_CLUSTER}/airport_index/_bulk?pretty&refresh" \
                    --data-binary @${SCRIPT_DIRECTORY}/data/data.txt > /dev/null
                    echo "   -> Data added"
                else


                    echo "## Creating 'airport_index'"
                    curl -f  -XPUT \
                    -H 'Content-Type: application/json' \
                    "${ES_CLUSTER}/airport_index?pretty" \
                    --data @$SCRIPT_DIRECTORY/data/airport_mapping.json 
  
                    echo "## Adding data to 'airport_index'"
                    curl -s -H "Content-Type: application/json" \
                     -XPOST "${ES_CLUSTER}/airport_index/_bulk?pretty&refresh" \
                    --data-binary @${SCRIPT_DIRECTORY}/data/data.txt > /dev/null
                    echo "   -> Data added"
            fi



echo "## Referecing 'airport_index' in ARLAS-server"
bash ${SCRIPT_DIRECTORY}/collections/create_collection.sh -asu=${ARLAS_SERVER_URL} -n="airport_collection" -i="airport_index" -ip="id" -tp="startdate" -gp="geometry" -cp="centroid"