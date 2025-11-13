
# ARLAS Exploration Stack with Kubernetes

## Prerequisites

- git
- kubernetes cluster (e.g. [KIND](https://kind.sigs.k8s.io/) for testing: `kind create cluster --name arlas-kind-cluster`)
- kubectl
- helm
- load balancer for kubernetes

Get the project by cloning the [ARLAS Exploration Stack](https://github.com/gisaia/ARLAS-Exploration-stack) project.

```shell
git clone git@github.com:gisaia/ARLAS-Exploration-stack.git
cd ARLAS-Exploration-stack
```

The third party helm charts are provided by bitnami. Its repository must be registered:

```shell
helm repo add bitnami https://charts.bitnami.com/bitnami
```

__Important__: Bitnami charts are not supported anymore by bitnamy. The charts are used for development purpose only. You must deploy your own third party service charts.

__Note for test/dev environment__: If your cluster does not have an ingress controller, you can install `metallb` and `nginx_ingress_controller`:

```shell
k8s/scripts/install_metallb.sh
k8s/scripts/install_nginx_ingress_controller.sh
```

## Configuring the ARLAS stack

### Directory structure

The repository contains files related to docker compose deployment and kubernetes deployment. The `k8s/` directory contains the charts and the scripts for running the stack with kubernetes.

Files are organized as follows:

- `k8s/`: everything for installing the ARLAS Stack chart
   - `scripts/`: scripts for initializing and installing the charts
   - `charts/`: contains the umbrella chart (`k8s/charts/arlas-stack/Chart.yaml`) and sub charts for arlas backend, arlas front end and AIAS

### Storage

The default storage class of the cluster might have a `delete` reclaim policy. For that reason, the chart deploys a `standard-retain` storage class based on `rancher.io/local-path` provisioner. You might want to use a different provisioner with a `reclaim` policy. See `defaultStorageClass` in  `k8s/charts/arlas-stack/values.yaml`

### Configuration

Most of the configuration should be done by setting values for the charts. Default values are set in the `values.yaml` files of the various charts. The `k8s/charts/arlas-stack/values_template.yaml` file is a __template__ that contains the values for a coherent stack deployment. If you need to change values, __do not modify directly this template file__. Instead, create a file in the project root directory named `custom_values.yaml` and set there the values you want to overwrite. Bellow is an example:

```yaml
global: 
  dnsDomain: &arlasAppDnsDomain site.mydomain.io
  elasticDnsDomain: &arlasAppElasticDnsDomain elastic.mydomain.k8s
  minioDnsDomain: &arlasAppMinioDnsDomain minio.mydomain.k8s
  keycloakDnsDomain: &arlasAppKeycloakDnsDomain keycloak.mydomain.k8s
  openIdProvider: &arlasAppOpenIdProvider https://keycloak.mydomain.k8s/auth/realms/arlas/.well-known/openid-configuration
```

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
In case you want to use a local protomap basemap, you must specify the right Persistent Volume Claim storage size for the protomap file: set the `arlas-uis.basemap.storageSize` property in the arlas-stack chart values.yaml file (at least 120 Gi for full coverage). Then place the protomap file in `conf/protomaps/world.pmtiles` and launch `./k8s/scripts/copy_files.sh`.

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

Note that a job is launched for creating the minio buckets used by AIAS (for AIRS assets and for the download).

Once the chart installed, copy the basemap files in the Persistent Volume Claim:

```shell
./k8s/scripts/copy_files.sh
```

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

## Test/dev environment

### Services, DNS and Certificates

Four services are exposed with an ingress:

- `keycloak`, default DNS is `keycloak.arlas.k8s`
- `elasticsearch`, default DNS is `elastic.arlas.k8s`
- `apisix`, which serves ARLAS and AIAS, default DNS is `site.arlas.k8s`
- `minio`, which serves as the object store, default DNS is `minio.arlas.k8s`

These DNS names can be changed in `custom_values.yaml` with the model in `k8s/charts/arlas-stack/values.yaml`.

In a test environment, you will need to link the ingress external IP with the domain names of the services. You can for instance add them in /etc/hosts:

```
172.18.0.10	keycloak.arlas.k8s
172.18.0.10	elastic.arlas.k8s
172.18.0.10	site.arlas.k8s
```

The arlas-ingress IP is obtained with:
```shell
kubectl get svc ingress-nginx-controller  -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```

## Configuring `arlas_cli` for the keycloak test realm

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
## EO Catalog

Just like the docker compose deployment, you can init a catalog:

```shell
./scripts/init_aias_catalog.sh local.k8s.kc.data main org.com
```

Remember to change `main` and `org.com` according to the values you changed in the arlas-stack chart values.yaml file.


**Remove deployment**

To start, run: 
```shell
./k8s/scripts/remove_deployment.sh
```
