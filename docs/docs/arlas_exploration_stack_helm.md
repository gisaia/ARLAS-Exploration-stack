
# ARLAS Exploration Stack with Kubernetes

## Prerequisites

- kubernetes cluster (e.g. [KIND](https://kind.sigs.k8s.io/) for testing)
- kubectl
- helm
- load balancer for kubernetes

Register the bitnami repository:

```shell
helm repo add bitnami https://charts.bitnami.com/bitnami
```

It will be necessary to bind domain names to the external IPs. In the present case, we use `arlas.k8s` as a local test domain with three sub domains: `elastic`, `keycloak` and `site`. You can for instance add them in /etc/hosts:

```
172.18.0.5	keycloak.arlas.k8s
172.18.0.3	elastic.arlas.k8s
172.18.0.2	site.arlas.k8s
```

You will determine the external IPs [once the chart installed](#finding-the-external-ips-of-the-loadbalancers).

## Configuring and running ARLAS stack

To run ARLAS stack, clone the [ARLAS Exploration Stack](https://github.com/gisaia/ARLAS-Exploration-stack) project and follow the guidelines.

```shell
git clone git@github.com:gisaia/ARLAS-Exploration-stack.git
cd ARLAS-Exploration-stack
```

### Directory structure

Files are organized as follow:
- `conf/aias/`: configuration files for ARLAS AIAS. IMPORTANT: The starting scripts transform them into `configmaps`. Other folders in `conf` are not used.
- `k8s/`: everything for installing the ARLAS Stack chart
   - `scripts/`: scripts for initializing and installing the charts
   - `charts/`: contains the umbrella chart (`k8s/charts/arlas-stack/Chart.yaml`) and sub charts for arlas backend, arlas front end and aias

### AIAS deployment with Keycloak

#### Configuration

IMPORTANT: configure the passwords before installing the chart!

The main initial configuration is done in the "umbrella chart" contained in k8s/charts/arlas-stack/values.yaml. Configure in priority all the fields with the mention "__MUST BE CONFIGURED:__". Once configured, the default stack can be installed.

More configuration options can be set in the three sub charts: arlas-services (ARLAS Backend), arlas-uis (ARLAS User interfaces) and aias-services (ARLAS AIRS and AIAS services). The variables for these three charts are documented:
- [ARLAS Stack](helm/arlas-stack/README.md)
- [ARLAS Services](helm/arlas-services/README.md)
- [ARLAS User interface](helm/arlas-uis/README.md)
- [AIAS Services](helm/aias-services/README.md)


The detailed settings of AIAS services are located in the `conf/aias/` yaml files:
- [conf/aias/agate.yaml](https://docs.arlas.io/external_docs/aias/agate/configuration/)
- [conf/aias/airs.yaml](https://docs.arlas.io/external_docs/aias/airs/configuration/)
- [conf/aias/aproc.yaml](https://docs.arlas.io/external_docs/aias/aproc/configuration/)
- [conf/aias/drivers.yaml]()
- [conf/aias/download_drivers.yaml]()
- [conf/aias/enrich_drivers.yaml]()
- [conf/aias/fam.yaml](https://docs.arlas.io/external_docs/aias/fam/configuration/)
- [conf/aias/roles.yaml]()

#### Basemap
In case you want to use a local protomap basemap, you must specify the right Persistent Volume Claim storage size for the protomap file: set the `arlas-uis.basemap.storageSize` property in the arlas-stack chart values.yaml file (at least 120 Gi for full coverage). Then place the protomap file in `conf/protomaps/world.pmtiles` and launch `./k8s/scripts/copy_files.sh`.

### Start the ARLAS Stack

To start, run: 
```shell
./k8s/scripts/start.sh 
```

This scripts:
- creates the configmaps for the aias configuration files
- update and build the sub charts
- install or upgrade the arlas-stack chart

Note that a job is launched for creating the minio buckets used by AIAS (for AIRS assets and for the download).

Once the chart installed, copy the basemap files in the Persistent Volume Claim.


### Using the ARLAS Stack

#### Finding the external IPs of the LoadBalancers

It deploys the ARLAS Stack in the `arlas` namespace of the cluster. A kubernetes load balancer must be running. For testing, you can run `cloud-provider-kind`. The external ip address of the apisix load balancer can be found with the following commands

```shell
kubectl get services arlas-stack-apisix-data-plane -n arlas -o=jsonpath={.status.loadBalancer.ingress[0].ip}; echo
``` 

and the one of elasticsearch with the same method:
```shell
kubectl get services arlas-stack-elasticsearch -n arlas  -o=jsonpath={.status.loadBalancer.ingress[0].ip}; echo
``` 

and the one of keycloak with the same method:
```shell
kubectl get services arlas-stack-keycloak -n arlas  -o=jsonpath={.status.loadBalancer.ingress[0].ip}; echo
``` 

In the following, we assume that these three external IPs are bound to:
- `site.arlas.k8s`
- `elastic.arlas.k8s`
- `keycloak.arlas.k8s`

These domains must be configured/changed in the values.yaml file of the arlas-stack chart.

The arlas service pods that are depending on keycloak availability will not be running until the keycloak client for arlas is created and available. You can import the keycloak test realm located in `conf/keycloak/keycloak.realm.json`. The import can be done from the user interface of keyckloak (eg http://keycloak.arlas.k8s:8080/auth/).


#### Configuring `arlas_cli` for the keycloak test realm

Let's assume the domain names are `elastic.arlas.k8s`, `keycloak.arlas.k8s` and `site.arlas.k8s`, then you can init your arlas_cli configuration file with:

```shell
./k8s/scripts/init_arlas_cli_confs.sh site.arlas.k8s:80 elastic.arlas.k8s:9200 keycloak.arlas.k8s:8080
```

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
### EO Catalog

Just like the docker compose deployement, you can init a catalog:

```shell
./scripts/init_aias_catalog.sh local.k8s.kc.data main org.com
```

Remember to change `main` and `org.com` according to the values you changed in the arlas-stack chart values.yaml file.


**Remove deployment**

To start, run: 
```shell
./k8s/scripts/remove_deployment.sh
```

