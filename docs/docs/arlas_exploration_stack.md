# ARLAS Exploration Stack

The [ARLAS Exploration Stack](https://github.com/gisaia/ARLAS-Exploration-stack) project contains reference docker compose files for all the ARLAS microservices and third party services for running the ARLAS Stack. It also contains the script for starting the stack in different modes:

- [Simple](#simple-deployment): ARLAS without authentication, on HTTP
- [IAM](#iam-deployment): With ARLAS Identity and Access Management (ARLAS IAM), on HTTPS
- [AIAS](#aias-deployment): With ARLAS IAM and ARLAS AIAS (ARLAS Item and Asset Services) for managing EO products for instance. *(WORK IN PROGRESS)*

You can start the ARLAS Exploration Stack either with [docker compose](arlas_exploration_stack_dc.md) or with [helm](arlas_exploration_stack_helm.md).


### Simple deployment

The simple deployment has:

- [apisix](https://apisix.apache.org/)
- [arlas-wui](https://github.com/gisaia/ARLAS-wui)
- [arlas-hub](https://github.com/gisaia/ARLAS-wui-hub)
- [arlas-builder](https://github.com/gisaia/ARLAS-wui-builder)
- [arlas-persistence-server](https://github.com/gisaia/ARLAS-persistence)
- [arlas-permissions-server](https://github.com/gisaia/ARLAS-permissions)
- [arlas-server](https://github.com/gisaia/ARLAS-server)
- [elasticsearch](https://github.com/elastic/elasticsearch)
- [protomaps](https://protomaps.com/)


### IAM deployment

The IAM deployment has:

- [apisix](https://apisix.apache.org/)
- [arlas-wui-iam](https://github.com/gisaia/ARLAS-wui-iam)
- [arlas-iam-server](https://github.com/gisaia/ARLAS-IAM)
- [postgres](https://www.postgresql.org/)
- [arlas-wui](https://github.com/gisaia/ARLAS-wui)
- [arlas-hub](https://github.com/gisaia/ARLAS-wui-hub)
- [arlas-builder](https://github.com/gisaia/ARLAS-wui-builder)
- [arlas-persistence-server](https://github.com/gisaia/ARLAS-persistence)
- [arlas-permissions-server](https://github.com/gisaia/ARLAS-permissions)
- [arlas-server](https://github.com/gisaia/ARLAS-server)
- [elasticsearch](https://github.com/elastic/elasticsearch)
- [protomaps](https://protomaps.com/)

### AIAS deployment

The AIAS (ARLAS Item and Asset Services) deployment has:

- [apisix](https://apisix.apache.org/)
- [arlas-wui-iam](https://github.com/gisaia/ARLAS-wui-iam)
- [arlas-iam-server](https://github.com/gisaia/ARLAS-IAM)
- [postgres](https://www.postgresql.org/)
- [arlas-wui](https://github.com/gisaia/ARLAS-wui)
- [arlas-hub](https://github.com/gisaia/ARLAS-wui-hub)
- [arlas-builder](https://github.com/gisaia/ARLAS-wui-builder)
- [arlas-persistence-server](https://github.com/gisaia/ARLAS-persistence)
- [arlas-permissions-server](https://github.com/gisaia/ARLAS-permissions)
- [arlas-server](https://github.com/gisaia/ARLAS-server)
- [agate](https://github.com/gisaia/aias)
- [fam](https://github.com/gisaia/aias)
- [fam-wui](https://github.com/gisaia/aias)
- [aproc-service](https://github.com/gisaia/aias)
- [aproc-proc](https://github.com/gisaia/aias)
- [elasticsearch](https://github.com/elastic/elasticsearch)
- [protomaps](https://protomaps.com/)
- [minio](https://min.io)
- [redis](https://redis.io)
- [rabbitmq](https://www.rabbitmq.com)
