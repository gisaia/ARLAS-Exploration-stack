
# ARLAS Exploration Stack with Docker compose

## Prerequisites

- kubernetes cluster
- kubectl
- helm
- load balancer for kubernetes

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

**Configure**

The main configuration is done in the umbrella chart contained in k8s/charts/arlas-stack/values.yaml. Configure in priority all the fields with the mention "__MUST BE CONFIGURED:__". Then detailed configuration can be done in the three sub charts: arlas-services (ARLAS Backend), arlas-uis (ARLAS User interfaces) and aias-services (ARLAS AIRS and AIAS services). The variables for these three charts are documented:
- [ARLAS Stack](helm/arlas-stack/README.md)
- [ARLAS Services](helm/arlas-services/README.md)
- [ARLAS User interface](helm/arlas-uis/README.md)
- [AIAS Services](helm/aias-services/README.md)

Then configure carefully the AIAS configuration files:
- conf/aias/agate.yaml
- conf/aias/airs.yaml
- conf/aias/aproc.yaml
- conf/aias/drivers.yaml
- conf/aias/download_drivers.yaml
- conf/aias/enrich_drivers.yaml
- conf/aias/fam.yaml
- conf/aias/roles.yaml

**Start**

To start, run: 
```shell
./k8s/scripts/start.sh 
```

It deploys the ARLAS Stack in the `arlas` namespace of the cluster.

**Remove deployment**

To start, run: 
```shell
./k8s/scripts/remove_deployment.sh
```

