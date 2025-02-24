import os
import time

import pytest
from arlas.cli.configurations import create_configuration
from arlas.cli.index import make_mapping
from arlas.cli.service import Service
from arlas.cli.settings import Configuration, Settings
from arlas.cli.variables import variables as cli_variables
from helper import create_collection, create_user, get_groups_and_roles
from variables import (ANONYMOUS, COLLECTION1_ORG_1_PRIVATE,
                       COLLECTION1_ORG_1_PUBLIC, COLLECTION1_ORG_2_PRIVATE,
                       INDEX_ORG1, INDEX_ORG2, INDICES, ORG_1, ORG_2, ORPHAN,
                       ORPHAN_ORG_FILTER_ARLAS_ORG1, ORPHAN_ORG_FILTER_ORG1,
                       ORPHAN_ORG_FILTER_ORG1_ARLAS_ORG1,
                       ORPHAN_ORG_FILTER_ORG2, OWNER_ORG_1, OWNER_ORG_2,
                       SQL_INIT, USER_ADMIN, USER_ORG_1, USER_ORG_2,
                       USER_ORG_2_NO_ORG_FILTER, USER_TO_UID)

ARLAS_CLI_CONF_FILE = "/tmp/arlas-cli-tests.yaml"  # NOSONAR


def register_user_in_cli(user_name: str, password: str, org_name: str, use_auth: bool = True, additional_header=None):
    if use_auth:
        auth_token_url = "https://localhost/arlas_iam_server/session"
        auth_headers = ["Content-Type:application/json"]
        if additional_header:
            auth_headers.append(additional_header)
        auth_login = user_name
        auth_password = password
    else:
        auth_token_url = None
        auth_headers = None
        auth_login = None
        auth_password = None

    create_configuration(
        name=user_name,
        server="https://localhost/arlas",
        headers=["Content-Type:application/json"],
        persistence="https://localhost/persist",
        persistence_headers=["Content-Type:application/json"],
        elastic="http://localhost:9200",
        elastic_headers=["Content-Type:application/json"],
        allow_delete=True,
        auth_token_url=auth_token_url,
        auth_headers=auth_headers,
        auth_login=auth_login,
        auth_password=auth_password,
        auth_arlas_iam=use_auth,
        auth_org=org_name,
        auth_client_id=None,
        auth_client_secret=None,
        auth_grant_type=None,
        elastic_login=None,
        elastic_password=None
    )


@pytest.fixture(scope="class")
def fixture_cli_confs():
    cli_variables["configuration_file"] = ARLAS_CLI_CONF_FILE
    if os.path.exists(ARLAS_CLI_CONF_FILE):
        os.remove(ARLAS_CLI_CONF_FILE)
    Configuration.settings = Settings(arlas={}, mappings={}, models={})

    Configuration.save(cli_variables["configuration_file"])

    register_user_in_cli(USER_ADMIN, "admin", None)

    register_user_in_cli(OWNER_ORG_1, "secret", "org1.com")
    register_user_in_cli(USER_ORG_1, "secret", "org1.com")

    register_user_in_cli(OWNER_ORG_2, "secret", "org2.com")
    register_user_in_cli(USER_ORG_2, "secret", "org2.com")
    register_user_in_cli(USER_ORG_2_NO_ORG_FILTER, "secret", None)

    register_user_in_cli(ORPHAN, "secret", None)
    register_user_in_cli(ORPHAN_ORG_FILTER_ORG1, "secret", "org1.com")
    register_user_in_cli(ORPHAN_ORG_FILTER_ORG2, "secret", "org2.com")

    register_user_in_cli(ORPHAN_ORG_FILTER_ARLAS_ORG1, "secret", None, additional_header="arlas-organization:org1")
    register_user_in_cli(ORPHAN_ORG_FILTER_ORG1_ARLAS_ORG1, "secret", "org1.com", additional_header="arlas-organization:org1")

    register_user_in_cli(ANONYMOUS, None, None, use_auth=False)


@pytest.fixture(scope="function")
def fixture_init():
    USER_TO_UID.clear()
    for index in INDICES:
        if index not in list(map(lambda arr: arr[0], Service.list_indices(USER_ADMIN))):
            mapping = make_mapping(
                file="sample/sample.json",
                types={
                    "track.timestamps.center": "date-epoch_second",
                    "track.timestamps.start": "date-epoch_second",
                    "track.timestamps.end": "date-epoch_second"},
                no_fulltext=["cargo_type"])
            Service.create_index(
                USER_ADMIN,
                index=index,
                mapping=mapping)
            Service.index_hits(USER_ADMIN, index, "sample/sample.json")
    os.system("docker exec db psql arlas -c \"" + SQL_INIT.replace(os.linesep, " ") + "\" > /dev/null")
    collections = Service.list_collections(USER_ADMIN)[1:]
    for collection in collections:
        time.sleep(2)
        Service.delete_collection(USER_ADMIN, collection[0])


@pytest.fixture(scope="function")
def fixture_org1_owner():
    oid = Service.create_organisation(USER_ADMIN, ORG_1).get("id")
    groups = get_groups_and_roles(oid)
    email, id = create_user(USER_ADMIN, OWNER_ORG_1)
    USER_TO_UID[email] = id
    Service.add_user_in_organisation(USER_ADMIN, oid, OWNER_ORG_1, list(groups.values()))
    return oid, email, groups


@pytest.fixture(scope="function")
def fixture_org1_owner_and_user(fixture_org1_owner):
    oid, email1, groups = fixture_org1_owner
    email2, id2 = create_user(OWNER_ORG_1, USER_ORG_1)
    USER_TO_UID[email2] = id2
    Service.add_user_in_organisation(OWNER_ORG_1, oid, USER_ORG_1, [groups.get("role/arlas/user"), groups.get("group/config.json/" + ORG_1)])
    return oid, email1, email2, groups


@pytest.fixture(scope="function")
def fixture_org2_owner():
    oid = Service.create_organisation(USER_ADMIN, ORG_2).get("id")
    groups = get_groups_and_roles(oid)
    email, id = create_user(USER_ADMIN, OWNER_ORG_2)
    USER_TO_UID[email] = id
    Service.add_user_in_organisation(USER_ADMIN, oid, OWNER_ORG_2, list(groups.values()))
    return oid, email, groups


@pytest.fixture(scope="function")
def fixture_org2_owner_and_users(fixture_org2_owner):
    oid, email1, groups = fixture_org2_owner
    email2, id2 = create_user(OWNER_ORG_2, USER_ORG_2)
    Service.add_user_in_organisation(OWNER_ORG_2, oid, USER_ORG_2, [groups.get("role/arlas/user"), groups.get("group/config.json/" + ORG_2)])
    email3, id3 = create_user(OWNER_ORG_2, USER_ORG_2_NO_ORG_FILTER)
    USER_TO_UID[email2] = id2
    USER_TO_UID[email3] = id3
    Service.add_user_in_organisation(OWNER_ORG_2, oid, USER_ORG_2_NO_ORG_FILTER, [groups.get("role/arlas/user"), groups.get("group/config.json/" + ORG_2)])
    return oid, email1, email2, email3, groups


@pytest.fixture(scope="function")
def fixture_orphans():
    email1, id1 = create_user(USER_ADMIN, ORPHAN)
    email2, id2 = create_user(USER_ADMIN, ORPHAN_ORG_FILTER_ORG1)
    email3, id3 = create_user(USER_ADMIN, ORPHAN_ORG_FILTER_ORG2)
    email4, id4 = create_user(USER_ADMIN, ORPHAN_ORG_FILTER_ARLAS_ORG1)
    email5, id5 = create_user(USER_ADMIN, ORPHAN_ORG_FILTER_ORG1_ARLAS_ORG1)
    USER_TO_UID[email1] = id1
    USER_TO_UID[email2] = id2
    USER_TO_UID[email3] = id3
    USER_TO_UID[email4] = id4
    USER_TO_UID[email5] = id5
    return email1, email2, email3, email4, email5


@pytest.fixture(scope="function")
def fixture_collections():
    create_collection(OWNER_ORG_1, ORG_1, COLLECTION1_ORG_1_PRIVATE, INDEX_ORG1, False)
    create_collection(OWNER_ORG_1, ORG_1, COLLECTION1_ORG_1_PUBLIC, INDEX_ORG1, True)
    create_collection(OWNER_ORG_2, ORG_2, COLLECTION1_ORG_2_PRIVATE, INDEX_ORG2, False)
    time.sleep(1)
    Service.describe_collection(OWNER_ORG_1, COLLECTION1_ORG_1_PRIVATE)
    Service.describe_collection(OWNER_ORG_1, COLLECTION1_ORG_1_PUBLIC)
    Service.describe_collection(OWNER_ORG_2, COLLECTION1_ORG_2_PRIVATE)
    time.sleep(1)
