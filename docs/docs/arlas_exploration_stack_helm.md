
# ARLAS Exploration Stack with Kubernetes


This documentation is for running ARLAS Exploration stack from the https://github.com/gisaia/ARLAS-Exploration-stack project. You can also install it by using the [online chart](https://artifacthub.io/packages/helm/arlas-stack/arlas-aias):

```shell
helm repo add arlas-stack https://gisaia.github.io/ARLAS-Exploration-stack
helm install my-arlas-aias arlas-stack/arlas-aias
```

## Prerequisites

You need the following command lines to install the charts:
- git
- kubectl
- helm 4.3.0

Also, you will need a kubernetes cluster with:
- a load balancer for kubernetes
- the operators for elasticsearch, keycloak and rabbitmq
- metrics server if autoscaling is enabled

For testing purpose, see the [Setup a test environement](#setup-a-test-environement) section

The S3 storage remote third party helm charts are provided by SeaweedFS. Its repository must be registered:

```shell
helm repo add seaweedfs https://seaweedfs.github.io/seaweedfs/helm
helm repo update
```

## The ARLAS Exploration stack project

Get the project by cloning the [ARLAS Exploration Stack](https://github.com/gisaia/ARLAS-Exploration-stack) project.

```shell
git clone git@github.com:gisaia/ARLAS-Exploration-stack.git
cd ARLAS-Exploration-stack
```

### Directory structure

The repository contains files related to docker compose deployment and kubernetes deployment. The `k8s/` directory contains the charts and the scripts for running the stack with kubernetes.

Files are organized as follows:

- `k8s/`: everything for installing the ARLAS Stack chart
   - `scripts/`: scripts for initializing and installing the charts
   - `charts/`: contains the umbrella chart (`k8s/charts/arlas-stack/Chart.yaml`) and sub charts for arlas backend, arlas front end and AIAS

## Configuring the ARLAS stack

### Storage

The default storage class of the cluster might have a `delete` reclaim policy. For that reason, the chart deploys a `standard-retain` storage class based on `rancher.io/local-path` provisioner. You might want to use a different provisioner with a `reclaim` policy. See `defaultStorageClass` in  `k8s/charts/arlas-stack/values.yaml`

### Configuration

Most of the configuration should be done by setting values for the charts. Default values are set in the `values.yaml` files of the various charts. 

IMPORTANT: the passwords must be configured before the first install of the chart!

The main initial configuration is done in the "umbrella chart" contained in `k8s/charts/arlas-stack/values.yaml`. Configure in priority all the fields with the mention "__MUST BE CONFIGURED:__". Note that keycloak deployment uses by default the provided certificate. 
Once you changed all the "__MUST BE CONFIGURED:__" variables, the default stack can be installed.

More configuration options can be set in the three sub charts: arlas-services (ARLAS Backend), arlas-uis (ARLAS User interfaces) and aias-services (ARLAS AIRS and AIAS services). 

The variables for the charts are documented:

- [ARLAS Stack](helm/arlas-stack/README.md)
- [ARLAS Services](helm/arlas-services/README.md)
- [ARLAS User interface](helm/arlas-uis/README.md)
- [AIAS Services](helm/aias-services/README.md)

The detailed settings of AIAS services are located in the `conf/aias/` yaml files:

- [conf/aias/agate.yaml](https://docs.arlas.io/external_docs/aias/agate/configuration/)
- [conf/aias/airs.yaml](https://docs.arlas.io/external_docs/aias/airs/configuration/)
- [conf/aias/aproc.yaml](https://docs.arlas.io/external_docs/aias/aproc/configuration/)
- [conf/aias/drivers.yaml](https://docs.arlas.io/external_docs/aias/aproc/configuration/#ingest-drivers)
- [conf/aias/download_drivers.yaml](https://docs.arlas.io/external_docs/aias/aproc/configuration/#download-drivers)
- [conf/aias/enrich_drivers.yaml](https://docs.arlas.io/external_docs/aias/aproc/configuration/#enrich-drivers)
- [conf/aias/dc3build_drivers.yaml](https://docs.arlas.io/external_docs/aias/aproc/configuration/#dc3build-drivers)
- [conf/aias/fam.yaml](https://docs.arlas.io/external_docs/aias/fam/configuration/)
- [conf/aias/roles.yaml](https://docs.arlas.io/external_docs/aias/roles/)

### Basemap
In case you want to use a local protomap basemap, you must specify the right Persistent Volume Claim storage size for the protomap file: set the `arlas-uis.basemap.storageSize` property in the arlas-stack chart values.yaml file (at least 120 Gi for full coverage).

## Running the ARLAS stack

### Start the ARLAS Stack

To start, run: 
```shell
./k8s/scripts/start.sh 
```

This script:

- creates the configmaps for the AIAS configuration files
- create a secret and configmap for keycloak certificate if the certificate exists (e.g. created with `./scripts/create_certificate.sh keycloak.arlas.k8s`)
- update and build the sub charts
- install or upgrade the arlas-stack chart


--set-json 'global.elasticDnsDomain="elasticsearch.arlas.k8s"' --set-json 'elasticsearch.ingress.hostname="elasticsearch.arlas.k8s"'


### Stop the ARLAS Stack

You can remove the deployment with:

```shell
./k8s/scripts/remove_deployment.sh
```

The script:

- uninstall the chart
- delete the keycloak-tls secret if exists

### Restart the ARLAS Stack

Before re-starting the ARLAS stack, please make sure that the persistence volume have a `bound` or `available` status. If they are `released`, then you can make them `available` with the folmlowing script:

```shell
./k8s/scripts/free_released_persistence_volumes.sh
```

## Setup a test environement

This section is only for the deployment of the ARLAS Exploration stack in a **testing purpose**. This is not for production.

### K8s Cluster for a test environement
For a simple test environement of the ARLAS Exploration stack, you can install a [KIND](https://kind.sigs.k8s.io/) cluster:

1 - [Install KIND](https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-release-binaries)

2 - Create a cluster:
```shell
kind create cluster --config k8s/kind/kind.yaml
```

### Load balancer for a test environement

__Note for test/dev environment__: If your KIND cluster does not have an ingress controller, you can install `nginx_ingress_controller`:

```shell
k8s/scripts/install_nginx_ingress_controller.sh
```

### Metric server

__Note for test/dev environment__: If your KIND cluster does not have a metric controller and you want to use autoscaling on arlas server, you can install one like this:

```shell
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch -n kube-system deployment metrics-server --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'
```

### Installing operators

__Note for test/dev environment__:  If your KIND cluster does not have operators like keycloak, elasticsearch or rabbitmq, you can install them:
```shell
k8s/scripts/install_operators.sh keycloak@26.7.4 elasticsearch@3.5.0 rabbitmq@2.23.0
```

### Services, DNS and Certificates

Seven services are exposed with an ingress:

- `keycloak`, default DNS is `keycloak.arlas.k8s`
- `elasticsearch`, default DNS is `elastic.arlas.k8s`
- `kibana`, default DNS is `kibana.arlas.k8s`
- `apisix`, which serves ARLAS and AIAS, default DNS is `site.arlas.k8s`
- `seaweedfs`, which serves as the object store, default DNS is `seaweedfs.arlas.k8s`
- `elasticsearch-logs`, default DNS is `elastic.logs.arlas.k8s`
- `kibana-logs`, default DNS is `kibana.logs.arlas.k8s`
  
In a test environment use the ip of your machine e.g. 192.168.102.141 to access applications :

```
192.168.102.141	elastic.arlas.k8s
192.168.102.141	kibana.arlas.k8s
192.168.102.141	site.arlas.k8s
192.168.102.141	minio.arlas.k8s
192.168.102.141	keycloak.arlas.k8s
192.168.102.141	elastic.logs.arlas.k8s
192.168.102.141	kibana.logs.arlas.k8s
```

### Configuring `arlas_cli` for the keycloak test realm

Let's assume the domain names are `elastic.arlas.k8s`, `keycloak.arlas.k8s` and `site.arlas.k8s`, then you can init your arlas_cli configuration file with:

```shell
./k8s/scripts/init_arlas_cli_confs.sh site.arlas.k8s:443 elastic.arlas.k8s:443 keycloak.arlas.k8s:443
```
Replace `site.arlas.k8s:443`, `elastic.arlas.k8s:443` and `keycloak.arlas.k8s:443` with your own values.

You can now list the indices:

```shell
arlas_cli --config-file /tmp/arlas-cli.yaml indices list
Using default configuration local.k8s.kc.data
+----------------------------------+--------+-------+---------+
| name                             | status | count | size    |
+----------------------------------+--------+-------+---------+
| .arlas                           | open   | 0     | 249b    |
+----------------------------------+--------+-------+---------+
Total count: 0
```

and collections:

```shell
arlas_cli --config-file /tmp/arlas-cli.yaml collections list
Using default configuration local.k8s.kc.data
+------+-------+
| name | index |
+------+-------+
+------+-------+
```
## Earth Observation Catalog

Once you registered a product in a collection with the interface (https://site.arlas.k8s/fam-wui/), then you can create the collection and its dashboard with the command line:
```shell
./scripts/init_aias_catalog.sh local.k8s.kc.data main org.com
```

Remember to change `main` and `org.com` according to the values you changed in the arlas-stack chart values.yaml file.
