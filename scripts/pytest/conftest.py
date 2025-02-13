import os
import pytest
from arlas.cli.settings import Configuration
from arlas.cli.service import Service
from helper import create_collection, create_user, get_groups_and_roles
from variables import COLLECTION1_ORG_1_PRIVATE, COLLECTION1_ORG_1_PUBLIC, COLLECTION1_ORG_2_PRIVATE, INDEX_ORG1, INDEX_ORG2, INDICES, ORG_1, ORG_2, ORPHAN, ORPHAN2, ORPHAN3, SQL_INIT, OWNER_ORG_2, USER_ORG_1, USER_ADMIN, OWNER_ORG_1, USER_ORG_2
from arlas.cli.index import make_mapping


@pytest.fixture(scope="function")
def fixture_init():
    Configuration.init("/tmp/arlas-cli-tests.yaml")
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
    os.system("docker exec db psql arlas -c \"" + SQL_INIT.replace(os.linesep, " ") + "\" > /dev/null")
    collections = Service.list_collections(USER_ADMIN)[1:]
    for collection in collections:
        Service.delete_collection(USER_ADMIN, collection[0])


@pytest.fixture(scope="function")
def fixture_org1_owner():
    oid = Service.create_organisation(USER_ADMIN, ORG_1).get("id")
    groups = get_groups_and_roles(oid)
    email = create_user(USER_ADMIN, OWNER_ORG_1)
    Service.add_user_in_organisation(USER_ADMIN, oid, OWNER_ORG_1, list(groups.values()))
    return oid, email, groups


@pytest.fixture(scope="function")
def fixture_org1_owner_and_user(fixture_org1_owner):
    oid, email1, groups = fixture_org1_owner
    email2 = create_user(OWNER_ORG_1, USER_ORG_1)
    print(Service.add_user_in_organisation(OWNER_ORG_1, oid, USER_ORG_1, [groups.get("role/arlas/user"), groups.get("group/config.json/" + ORG_1)]))
    return oid, email1, email2, groups


@pytest.fixture(scope="function")
def fixture_org2_owner():
    oid = Service.create_organisation(USER_ADMIN, ORG_2).get("id")
    groups = get_groups_and_roles(oid)
    email, id = create_user(USER_ADMIN, OWNER_ORG_2)
    Service.add_user_in_organisation(USER_ADMIN, oid, OWNER_ORG_2, list(groups.values()))
    return oid, email, groups


@pytest.fixture(scope="function")
def fixture_org2_owner_and_user(fixture_org2_owner):
    oid, email1, groups = fixture_org2_owner
    email2 = create_user(OWNER_ORG_2, USER_ORG_2)
    Service.add_user_in_organisation(OWNER_ORG_2, oid, USER_ORG_2, [groups.get("role/arlas/user"), groups.get("group/config.json/" + ORG_2)])
    return oid, email1, email2, groups


@pytest.fixture(scope="function")
def fixture_orphans():
    email1, id1 = create_user(USER_ADMIN, ORPHAN)
    email2, id1 = create_user(USER_ADMIN, ORPHAN2)
    email3, id1 = create_user(USER_ADMIN, ORPHAN3)
    return email1, email2, email3


@pytest.fixture(scope="function")
def fixture_collections():
    create_collection(OWNER_ORG_1, ORG_1, COLLECTION1_ORG_1_PRIVATE, INDEX_ORG1, False)
    create_collection(OWNER_ORG_1, ORG_1, COLLECTION1_ORG_1_PUBLIC, INDEX_ORG1, True)
    create_collection(OWNER_ORG_2, ORG_2, COLLECTION1_ORG_2_PRIVATE, INDEX_ORG2, False)
    Service.describe_collection(OWNER_ORG_1, COLLECTION1_ORG_1_PRIVATE)
    Service.describe_collection(OWNER_ORG_1, COLLECTION1_ORG_1_PUBLIC)
    Service.describe_collection(OWNER_ORG_2, COLLECTION1_ORG_2_PRIVATE)
