
# ARLAS Exploration Stack with Docker compose

## Prerequisites

## Run ARLAS stack

To run ARLAS stack, clone the [ARLAS Exploration Stack](https://github.com/gisaia/ARLAS-Exploration-stack) project and follow the guidelines.

```shell
git clone git@github.com:gisaia/ARLAS-Exploration-stack.git
cd ARLAS-Exploration-stack
```

### Simple deployment

**Start**

TODO

**Test**

TODO

### IAM deployment

**Start**

TODO

**Test**

TODO

### AIAS deployment

**Start**

To start, run: 
```shell
helm dependency build k8s/charts/aias
helm install aias k8s/charts/aias
```

