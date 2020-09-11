#!/bin/bash
set -o errexit

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
PROJECT_ROOT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"

function clean_exit {
  ARG=$?
	rm -f ${SCRIPT_DIRECTORY}/collectionParams.replaced.json
    exit $ARG
}

trap clean_exit EXIT

usage(){
	echo ""
	echo "Usage: ./create_collection.sh  [--arlas-server-url] [--name] [--index] [--id_path] [--centroid_path] [--geometry_path] [--timestamp_path]"
	echo ""
	echo " -asu|--arlas-server-url       url of a arlas-server service used to create the collection"
	echo " -n|--name                     Name of the collection"
	echo " -i|--index                    Elasticsearch index that the collection references"
	echo " -ip|--index_path              id field path in the index"
	echo " -tp|--timestamp_path          temporal field path in the index"
    echo " -cp|--centroid_path           geo-point field path in the index"
    echo " -gp|--geometry_path           geo-shape field path in the index"
    echo " -h|--help                     Display manual"
	exit 1
}

for i in "$@"
do
case $i in
    -h|--help)
    DISPLAY_HELP="true"
    shift # past argument=value
    ;;
    -asu=*|--arlas-server-url=*)
    export ARLAS_SERVER_URL="${i#*=}"
    shift # past argument=value
    ;;
    -n=*|--name=*)
    export COLLECTION_NAME="${i#*=}"
    shift # past argument=value
    ;;
    -i=*|--index=*)
    export INDEX="${i#*=}"
    shift # past argument=value
    ;;
    -ip=*|--id_path=*)
    export ID_PATH="${i#*=}"
    shift # past argument=value
    ;;
    -tp=*|--timestamp_path=*)
    export TIMESTAMP_PATH="${i#*=}"
    shift # past argument=value
    ;;
    -cp=*|--centroid_path=*)
    export CENTROID_PATH="${i#*=}"
    shift # past argument=value
    ;;
    -gp=*|--geometry_path=*)
    export GEOMETRY_PATH="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

if [ ! -z ${DISPLAY_HELP+x} ];
    then
        usage;
fi

if  [ -z "$ARLAS_SERVER_URL"  ] ; then echo "Please specify a URL to ARLAS-server"; usage; exit -1; else  echo "- ARLAS-server: ${ARLAS_SERVER_URL} " ; fi
if  [ -z "$INDEX"  ] ; then echo "Please specify an index"; usage; exit -1; else  echo "- Index: ${INDEX} " ; fi
if  [ -z "$COLLECTION_NAME"  ] ; then echo "Please specify a collection name"; usage; exit -1; else  echo "- Collection name: ${COLLECTION_NAME} " ; fi
if  [ -z "$ID_PATH"  ] ; then echo "Please specify id field path"; usage; exit -1; else  echo "- Id path: ${ID_PATH} " ; fi
if  [ -z "$CENTROID_PATH"  ] ; then echo "Please specify centroid field path"; usage; exit -1; else  echo "- Centroid path: ${CENTROID_PATH} " ; fi
if  [ -z "$GEOMETRY_PATH"  ] ; then echo "Please specify geometry field path"; usage; exit -1; else  echo "- Geometry path: ${GEOMETRY_PATH} " ; fi
if  [ -z "$TIMESTAMP_PATH"  ] ; then echo "Please specify timestamp field path"; usage; exit -1; else  echo "- Timestamp path: ${TIMESTAMP_PATH} " ; fi

envsubst '$INDEX' < $SCRIPT_DIRECTORY/collectionParams.json > $SCRIPT_DIRECTORY/collectionParams.replaced.json
envsubst '$ID_PATH' < $SCRIPT_DIRECTORY/collectionParams.replaced.json > $SCRIPT_DIRECTORY/collectionParams.replaced.tmp.json
mv $SCRIPT_DIRECTORY/collectionParams.replaced.tmp.json $SCRIPT_DIRECTORY/collectionParams.replaced.json
envsubst '$TIMESTAMP_PATH' < $SCRIPT_DIRECTORY/collectionParams.replaced.json > $SCRIPT_DIRECTORY/collectionParams.replaced.tmp.json
mv $SCRIPT_DIRECTORY/collectionParams.replaced.tmp.json $SCRIPT_DIRECTORY/collectionParams.replaced.json
envsubst '$CENTROID_PATH' < $SCRIPT_DIRECTORY/collectionParams.replaced.json > $SCRIPT_DIRECTORY/collectionParams.replaced.tmp.json
mv $SCRIPT_DIRECTORY/collectionParams.replaced.tmp.json $SCRIPT_DIRECTORY/collectionParams.replaced.json
envsubst '$GEOMETRY_PATH' < $SCRIPT_DIRECTORY/collectionParams.replaced.json > $SCRIPT_DIRECTORY/collectionParams.replaced.tmp.json
mv $SCRIPT_DIRECTORY/collectionParams.replaced.tmp.json $SCRIPT_DIRECTORY/collectionParams.replaced.json


curl -s -X PUT \
  --header 'Content-Type: application/json;charset=utf-8' \
  --header 'Accept: application/json' \
  "${ARLAS_SERVER_URL}"'/collections/'"${COLLECTION_NAME}" \
  --data @$SCRIPT_DIRECTORY/collectionParams.replaced.json > /dev/null || echo " !!! Couldn't reach ARLAS-server at ${ARLAS_SERVER_URL}";
