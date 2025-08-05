
# ARLAS Exploration Stack with Docker compose

## Prerequisites

- kubernetes cluster (e.g. [KIND](https://kind.sigs.k8s.io/) for testing)
- kubectl
- helm
- load balancer for kubernetes

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

**Configure**

IMPORTANT: configure the passwords before installing the chart!

The main configuration is done in the "umbrella chart" contained in k8s/charts/arlas-stack/values.yaml. Configure in priority all the fields with the mention "__MUST BE CONFIGURED:__". Then detailed configuration can be done in the three sub charts: arlas-services (ARLAS Backend), arlas-uis (ARLAS User interfaces) and aias-services (ARLAS AIRS and AIAS services). The variables for these three charts are documented:
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

This scripts:
- creates the configmaps for the aias configuration files
- update and build the sub charts
- install or upgrade the arlas-stack chart

Note that a job is launched for creating the minio buckets used by AIAS (for AIRS assets and for the download).


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


**Remove deployment**

To start, run: 
```shell
./k8s/scripts/remove_deployment.sh
```

