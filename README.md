# ARLAS Exploration Stack

This projects contains reference docker compose files for all the ARLAS microservices and third party services for running the ARLAS Stack. 

It also contains the script for starting the stack in different modes:

- **Simple**: ARLAS without authentication, on HTTP
- **IAM**: With ARLAS Identity and Access Management (ARLAS IAM), on HTTPS
- **KC**: With Keycloak as Identity and Access Management, on HTTPS
- **AIAS**: With ARLAS IAM and ARLAS AIAS (ARLAS Item and Asset Services) for managing EO products for instance. *(WORK IN PROGRESS)*

See the [full documentation](https://docs.arlas.io/external_docs/ARLAS-Exploration-stack/arlas_exploration_stack/) to run and deploy ARLAS Exploration stack.

# Developers

To release, run:
```shell
./scripts/release.sh X.Y
```
where `X.Y` is the version of the stack. `X` must be aligned with the major version ARLAS (WUI and Server) while `Y` is the increment of the stack.

To update the version of the dependencies, such as ARLAS containers, edit `conf/versions.env`.

## Tests

Launch tests for IAM:

```shell
./start.sh iam
pip3.10 install arlas_cli
pip3.10 install pytest==8.3.4
pytest -s scripts/pytest/test_iam.py
```
