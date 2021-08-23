This project contains :

# Docker-compose file
This docker-compose contains 6 services :
- [arlas-wui](https://github.com/gisaia/ARLAS-wui) version >= 18.0.2
- [arlas-hub](https://github.com/gisaia/ARLAS-wui-hub) version >= 18.0.0
- [arlas-builder](https://github.com/gisaia/ARLAS-wui-builder) version >= 18.0.3
- [arlas-persistence-server](https://github.com/gisaia/ARLAS-persistence) version >= 18.0.0
- [arlas-permissions-server](https://github.com/gisaia/ARLAS-permissions) version >= 18.0.0
- [elasticsearch](https://github.com/elastic/elasticsearch) version >= 7.9.2
- [arlas-server](https://github.com/gisaia/ARLAS-server) version >= 18.7.0

# Start.sh script
This script executes the docker-compose according to parameters.

If no parameters are provided, all the services are started locally.

````
Usage: ./start.sh [--arlas-permissions-url] [--arlas-persistence-url] [--arlas-server-url] [--es-cluster] [--es-node] [--help]
 -apu |--arlas-persistence-url url of a arlas-persistence service to use
 -apermu |--arlas-permissions-url url of a arlas-permissions service to use
 -asu|--arlas-server-url       url of a arlas-server service to use (if set, --es-cluster and --es-node  will be ignored)
 -esc|--es-cluster             es-cluster to use (if set --es-node is mandatory )
 -esn|--es-node                es-node to use (if set --es-cluster is mandatory ) 
 -essl|--es-enable-ssl         Whether to use SSL to connect to ES Cluster (true or false)
 -esnif|--es-enable-sniffing   Whether to active sniffing in ES Cluster (true or false)
 -escdr|--es-credentials       Credential to use to connect to ES Cluster
 -esidx|--es-arlas-index       ES Index using by arlas to index collection
 -h|--help                     Display manual 
 ````

Run ./start.sh without passing any parameters returns :

````
############################################
THE ARLAS STACK IS READY
############################################
                                            
############################################
ARLAS WUI in version 18.0.2 is running on http://localhost:81/wui
ARLAS HUB in  version 18.0.0 is running on http://localhost:81/hub
ARLAS BUILDER  in version 18.0.3 is running on http://localhost:81/builder
############################################
                                            
############################################
ARLAS PERSISTENCE SERVER in version 18.0.0 is running on http://localhost:81/persist/
ARLAS PERMISSIONS SERVER in version 18.0.0 is running on http://localhost:81/permissions/
ARLAS SERVER in version 18.7.0 is running on http://localhost:81/server/
############################################
                                            
############################################
ELASTICSEARCH is running on http://localhost:9200

ELASTICSEARCH options enable sniffing : false
ELASTICSEARCH options enable SSL : false
ELASTICSEARCH credentials :
ARLAS ELASTICSEARCH index : .arlas
````
```localhost``` can be replaced by an env variable __$LOCAL_HOST__ in `.env` file

# Stop.sh script
This script shutdowns all services of the docker-compose.

# .env
This file is used by the start.sh script to set some env variables of each component.
$ARLAS_PERSISTENCE_LOCAL_FOLDER_HOST allows you to choose the folder where arlas configurations will be stored on your computer.
