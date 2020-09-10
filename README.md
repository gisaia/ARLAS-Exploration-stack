This project contains :

# Docker-compose file
This docker-compose contains 6 services :
- [arlas-wui](https://github.com/gisaia/ARLAS-wui) version >= 14.0.0-beta.1
- [arlas-hub](https://github.com/gisaia/ARLAS-wui-hub) version >= 0.0.3-beta.2
- [arlas-builder](https://github.com/gisaia/ARLAS-wui-builder) version >= 0.0.6-beta.1
- [arlas-persistence-server](https://github.com/gisaia/ARLAS-persistence) version >= 13.0.0-beta.4
- [elasticsearch](https://github.com/elastic/elasticsearch) version >= 7.4.0
- [arlas-server](https://github.com/gisaia/ARLAS-server) version >= 14.7.0-beta.1

# Start.sh script
This script executes the docker-compose according to parameters.
If no parameters are provided, all the services are started locally.

````
Usage: ./start.sh  [--arlas-persistence-url] [--arlas-server-url] [--es-cluster] [--es-node] [--help]
 -apu |--arlas-persistence-url url of a arlas-persistence service to use
 -asu|--arlas-server-url       url of a arlas-server service to use (if set, --es-cluster and --es-node  will be ignored)
 -esc|--es-cluster             es-cluster to use (if set --es-node is mandatory )
 -esn|--es-node                es-node to use (if set --es-cluster is mandatory ) 
 -essl|--es-enable-ssl         Whether to use SSL to connect to ES Cluster (true or false)
 -esnif|--es-enable-sniffing   Whether to active sniffing in ES Cluster (true or false)
 -escdr|--es-credentials       Credential to use to connect to ES Cluster
 -esidx|--es-arlas-index       ES Index using by arlas to index collection
 -h|--help                     Display manual 
 ````

Run ./start.sh without param returns :

````
DOCKER COMPOSE SERVICES RUNNING : arlas-wui arlas-builder arlas-hub arlas-server elasticsearch arlas-persistence-server
############################################
                                            
############################################
ARLAS WUI in version 14.0.0-beta.1 is running on http://localhost:8096
ARLAS HUB in  version 0.0.3-beta.2 is running on http://localhost:8094
ARLAS BUILDER  in version 0.0.6-beta.1 is running on http://localhost:8095
############################################
                                            
############################################
ARLAS PERSISTENCE SERVER in version 13.0.0-beta.4 is running on http://localhost:19997/arlas-persistence-server
ARLAS SERVER in version 14.7.0-beta.1 is running on http://localhost:19999/arlas
############################################
                                            
############################################
ELASTICSEARCH is running on http://localhost:9200
ELASTICSEARCH options enable sniffing : false
ELASTICSEARCH options enable SSL : false
ELASTICSEARCH credentials :
ARLAS ELASTICSEARCH index : .arlas
````
```localhost``` could be replaced by env variable LOCAL_HOST with .env file

# Stop.sh script
This script shutdowns all services of the docker-compose.

# .env
This file is used by the start.sh script to set some env variable of each component.
ARLAS_PERSISTENCE_LOCAL_FOLDER_HOST allows you to choose the folder where arlas configurations will be stored on your computer.
