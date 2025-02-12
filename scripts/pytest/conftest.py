import os
import pytest
from arlas.cli.settings import Configuration
from arlas.cli.service import Service
from helper import get_groups_and_roles
from variables import INDEX, ORG_1, ORG_2, ORPHAN, ORPHAN2, SQL_INIT, USER_1_ORG_2, USER_ADMIN, USER_1_ORG_1
from arlas.cli.index import make_mapping


@pytest.fixture(scope="function")
def fixture_init():
    Configuration.init("/tmp/arlas-cli-tests.yaml")
    if INDEX not in list(map(lambda arr: arr[0], Service.list_indices(USER_ADMIN))):
        mapping = make_mapping(
            file="../../sample/sample.json", 
            types={
                "track.timestamps.center": "date-epoch_second",
                "track.timestamps.start": "date-epoch_second",
                "track.timestamps.end": "date-epoch_second"},
            no_fulltext=["cargo_type"])
        Service.create_index(
            USER_ADMIN,
            index=INDEX,
            mapping=mapping)
    os.system("docker exec db psql arlas -c \"" + SQL_INIT.replace(os.linesep, " ") + "\" > /dev/null")


@pytest.fixture(scope="function")
def fixture_org1_user1():
    oid = Service.create_organisation(USER_ADMIN, ORG_1).get("id")
    groups = get_groups_and_roles(oid)
    email = Service.create_user(USER_ADMIN, USER_1_ORG_1).get("email")
    Service.add_user_in_organisation(USER_ADMIN, oid, USER_1_ORG_1, groups)
    return oid, email, groups


@pytest.fixture(scope="function")
def fixture_org2_user2():
    oid = Service.create_organisation(USER_ADMIN, ORG_2).get("id")
    groups = get_groups_and_roles(oid)
    email = Service.create_user(USER_ADMIN, USER_1_ORG_2).get("email")
    Service.add_user_in_organisation(USER_ADMIN, oid, USER_1_ORG_2, groups)
    return oid, email, groups


@pytest.fixture(scope="function")
def fixture_orphans():
    return Service.create_user(USER_ADMIN, ORPHAN).get("email"), Service.create_user(USER_ADMIN, ORPHAN2).get("email")
