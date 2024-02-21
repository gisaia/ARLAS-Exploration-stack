# ARLAS Exploration Stack

ARLAS Exploration Stack is a set of micro services started with docker compose for running the opensource ARLAS web application.

## Starting the stack

`start.sh` starts the ARLAS Exploration Stack composed of containerized services. If no parameters are provided, all the services are started locally.

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

## Stopping the stack

`stop.sh` shuts down all services of the docker-compose.

## Services

The stack contains 6 services :
- [arlas-wui](https://github.com/gisaia/ARLAS-wui)
- [arlas-hub](https://github.com/gisaia/ARLAS-wui-hub)
- [arlas-builder](https://github.com/gisaia/ARLAS-wui-builder)
- [arlas-persistence-server](https://github.com/gisaia/ARLAS-persistence)
- [arlas-permissions-server](https://github.com/gisaia/ARLAS-permissions)
- [elasticsearch](https://github.com/elastic/elasticsearch)
- [arlas-server](https://github.com/gisaia/ARLAS-server)


## Configuration

### env.sh
The `env.sh` exports a set of variables for setting the service versions. This file changes over time, when new releases of ARLAS services are made available.
Also, `$ARLAS_PERSISTENCE_LOCAL_FOLDER_HOST` allows you to choose the folder where arlas configurations should be stored .

### .env
This file is used by the start.sh script to overwrite environement variables. This file is not provided in the git repo and is ignored by git. It is the best place to set your custom values.

## Adding data

If you want to create an ARLAS collection with some data, the best place to start is `arlas_cli`: https://gisaia.github.io/arlas_cli/
