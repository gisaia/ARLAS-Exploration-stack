# ARLAS Exploration Stack

This projects contains reference docker compose files for all the ARLAS microservices and third party services for running the ARLAS Stack. It also contains the script for starting the stack in different modes:
- basic : ARLAS without authentication, on HTTP
- with ARLAS Identity and Access Management (ARLAS IAM), on HTTPS
- with ARLAS IAM and ARLAS AIAS (ARLAS Item and Asset Services) for managing EO products for instance.



The underlying services and interfaces are :
- [arlas-wui](https://github.com/gisaia/ARLAS-wui)
- [arlas-hub](https://github.com/gisaia/ARLAS-wui-hub)
- [arlas-builder](https://github.com/gisaia/ARLAS-wui-builder)
- [arlas-persistence-server](https://github.com/gisaia/ARLAS-persistence)
- [arlas-permissions-server](https://github.com/gisaia/ARLAS-permissions)
- [elasticsearch](https://github.com/elastic/elasticsearch)
- [arlas-server](https://github.com/gisaia/ARLAS-server)
