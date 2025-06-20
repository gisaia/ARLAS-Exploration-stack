# ARLAS Exploration Stack

This projects contains reference docker compose files for all the ARLAS microservices and third party services for running the ARLAS Stack. 

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
