
#!/bin/bash
set -o errexit -o pipefail

usage(){
	echo "Usage: ./start.sh  [--arlas-persistence-url] [--arlas-server-url] [--es-cluster] [--es-node]"
	echo " -apu |--arlas-persistence-url url of a arlas-persistence service to use"
	echo " -asu|--arlas-server-url       url of a arlas-server service to use (if set, --es-cluster  and--es-node will be ignored)"
	echo " -esc|--es-cluster             es-cluster to use (if set --es-node is mandatory )"
	echo " -esn|--es-node                es-node to use (if set  --es-cluster is mandatory ) "
    echo " -essl|--es-enable-ssl         Whether to use SSL to connect to ES Cluster (true or false)"
    echo " -esnif|--es-enable-sniffing   Whether to active sniffing in ES Cluster (true or false)"
    echo " -escdr|--es-credentials       Credential to use to connect to ES Cluster"
    echo " -esidx|--es-arlas-index       ES Index using by arlas to index collection"
    echo " -h|--help                     Display manual"
	exit 1
}

#Set variables in version.env as env variable
export $(egrep -v '^#' version.env | xargs)

unset ARLAS_PERSISTENCE_URL
unset ARLAS_SERVER_URL
unset ES_CLUSTER
unset ES_NODE
unset ES_ENABLE_SSL
unset ES_SNIFFING
unset ES_CREDENTIALS
unset ARLAS_ELASTIC_INDEX

docker_compose_services="arlas-wui, arlas-builder, arlas-hub, arlas-server, elasticsearch, arlas-persistence-server"
IFS=', ' read -r -a docker_compose_services_array <<< "$docker_compose_services"

ignore_es=false


for i in "$@"
do
case $i in
    -h|--help)
    ARLAS_HELP="true"
    shift # past argument=value
    ;;
    -apu=*|--arlas-persistence-url=*)
    export ARLAS_PERSISTENCE_URL="${i#*=}"
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
    -esn=*|--es-node=*)
    export ES_NODE="${i#*=}"
    shift # past argument=value
    ;;
    -essl=*|--es-enable-ssl=*)
    export ES_ENABLE_SSL="${i#*=}"
    shift # past argument=value
    ;;
    -esnif=*|--es-enable-sniffing=*)
    export ES_SNIFFING="${i#*=}"
    shift # past argument=value
    ;;
    -escdr=*|--es-credentials=*)
    export ES_CREDENTIALS="${i#*=}"
    shift # past argument=value
    ;;
    -esidx=*|--es-arlas-index=*)
    export ARLAS_ELASTIC_INDEX="${i#*=}"
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

if [ ! -z ${ARLAS_PERSISTENCE_URL+x} ];
    then
        persistence_running_msg="External ARLAS PERSISTENCE SERVER is running on ARLAS_PERSISTENCE_URL   "
        unset docker_compose_services_array[5];
    else
        export ARLAS_PERSISTENCE_URL="http://$LOCAL_HOST:19997/arlas-persistence-server"
        persistence_running_msg="ARLAS PERSISTENCE SERVER in version $ARLAS_PERSISTENCE_VERSION is running on $ARLAS_PERSISTENCE_URL"
fi

if [ ! -z ${ARLAS_SERVER_URL+x} ];
    then
        arlas_server_running_msg="External ARLAS SERVER is running on $ARLAS_SERVER_URL"
        unset docker_compose_services_array[3]
        unset docker_compose_services_array[4]
        ignore_es=true
    else
        export ARLAS_SERVER_URL="http://$LOCAL_HOST:19999/arlas"
        arlas_server_running_msg="ARLAS SERVER in version $ARLAS_SERVER_VERSION is running on $ARLAS_SERVER_URL"
fi

if [ ! -z ${ES_CLUSTER+x} ];
    then
        if [ "$ignore_es" != false ]; then
            echo "WARNING : You have setted an arlas-server url, all the paramaters link to elasticsearch are ignored. "
        else
            if [  -z ${ES_NODE+x} ];
                then
                    echo "ERROR : --es-cluster and --es-node are both mandatory to connect to an ES Cluster. "
                    exit 1
            fi    
            es_running_msg="ELASTICSEARCH is running on cluster $ES_CLUSTER"
            unset docker_compose_services_array[4]
        fi
    else
        es_running_msg="ELASTICSEARCH is running on http://$LOCAL_HOST:9200"
fi

if [ ! -z ${ES_NODE+x} ];
    then
        if [ "$ignore_es" != false ]; then
            echo "WARNING : You have setted an arlas-server url, all the paramaters link to elasticsearch are ignored. "
        else
            if [  -z ${ES_CLUSTER+x} ];
                then
                    echo "ERROR : --es-cluster and --es-node are both mandatory to connect to an ES Cluster. "
                    exit 1
            fi    
            es_running_node_msg="ELASTICSEARCH is running on node $ES_NODE"
        fi
    else
        es_running_msg="ELASTICSEARCH is running on http://localhost:9200"
fi

if [ ! -z ${ES_ENABLE_SSL+x} ];
    then
        es_enable_ssl_msg="ELASTICSEARCH options enable SSL : $ES_ENABLE_SSL"
    else
        es_enable_ssl_msg="ELASTICSEARCH options enable SSL : false"
fi

if [ ! -z ${ES_SNIFFING+x} ];
    then
        es_enables_sniffing_msg="ELASTICSEARCH options enable sniffing : $ES_SNIFFING"
    else
        es_enables_sniffing_msg="ELASTICSEARCH options enable sniffing : false"
fi

if [ ! -z ${ES_CREDENTIALS+x} ];
    then
        es_credentials_msg="ELASTICSEARCH credentials : $ES_CREDENTIALS"
    else
        es_credentials_msg="ELASTICSEARCH credentials : """
fi

if [ ! -z ${ARLAS_ELASTIC_INDEX+x} ];
    then
        es_index_msg="ARLAS ELASTICSEARCH index : $ARLAS_ELASTIC_INDEX"
    else
        es_index_msg="ARLAS ELASTICSEARCH index : .arlas"
fi




echo "DOCKER COMPOSE SERVICES RUNNING : ${docker_compose_services_array[@]}"
echo "############################################"
echo "                                            "
echo "############################################"
echo "ARLAS WUI in version $ARLAS_WUI_VERSION is running on http://$LOCAL_HOST:8096"
echo "ARLAS HUB in  version $ARLAS_HUB_VERSION is running on http://$LOCAL_HOST:8094"
echo "ARLAS BUILDER  in version $ARLAS_BUILDER_VERSION is running on http://$LOCAL_HOST:8095"
echo "############################################"
echo "                                            "
echo "############################################"
echo $persistence_running_msg
echo $arlas_server_running_msg
echo "############################################"
echo "                                            "
echo "############################################"
if [ "$ignore_es" = false ]; 
    then
        echo $es_running_msg
        echo $es_running_node_msg
        echo $es_enables_sniffing_msg
        echo $es_enable_ssl_msg
        echo $es_credentials_msg
        echo $es_index_msg
fi

#Run Docker-compose services
eval "docker-compose up -d ${docker_compose_services_array[@]}"


