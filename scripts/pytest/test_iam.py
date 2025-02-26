import json
import time

import pytest
import requests
from arlas.cli.service import Service
from conftest import USER_ADMIN
from helper import (anonymous_iam_call, api_key_call, create_collection,
                    create_user, get_groups_and_roles_ids, see_collection,
                    see_collection_iam, see_organisation, see_user)
from variables import (ANONYMOUS, COLLECTION1_ORG_1_PRIVATE,
                       COLLECTION1_ORG_1_PUBLIC, COLLECTION1_ORG_2_PRIVATE,
                       INDEX_ORG1, INDEX_ORG2, ORG_1, ORPHAN,
                       ORPHAN_ORG_FILTER_ARLAS_ORG1, ORPHAN_ORG_FILTER_ORG1,
                       ORPHAN_ORG_FILTER_ORG1_ARLAS_ORG1,
                       ORPHAN_ORG_FILTER_ORG2, OWNER_ORG_1, OWNER_ORG_2,
                       PERMISSION, USER_ORG_1, USER_ORG_2,
                       USER_ORG_2_NO_ORG_FILTER, USER_TO_UID)

# LIST OF SERVICES NOT YET TESTED
# GET /auth
# GET /organisations/{oid}/emails
# GET/DELETE/POST /organisations/{oid}/permissions/columnfilter while /organisations/{oid}/permissions is tested

CAN_NOT_SEE_FOREIGN_PRIVE_COLLECTIONS = [OWNER_ORG_2,                        # owner org 2 can not see private collection org 1
                                         USER_ORG_2,                         # user  org 2 can not see private collection org 1
                                         USER_ORG_2_NO_ORG_FILTER,           # user  org 2 can not see private collection org 1
                                         ANONYMOUS,                          # anonymous   can not see private collection org 1
                                         ORPHAN,                             # orphan      can not see private collection org 1
                                         ORPHAN_ORG_FILTER_ORG1,             # orphan2     can not see private collection org 1
                                         ORPHAN_ORG_FILTER_ORG2,             # orphan3     can not see private collection org 1
                                         ORPHAN_ORG_FILTER_ARLAS_ORG1,       # orphan4 can not see private collection org 1
                                         ORPHAN_ORG_FILTER_ORG1_ARLAS_ORG1,  # orphan5 can not see private collection org 1
                                         ]

CAN_NOT_SEE_ORG1 = CAN_NOT_SEE_FOREIGN_PRIVE_COLLECTIONS

CAN_SEE_ORG1 = [OWNER_ORG_1, USER_ORG_1]

NON_ADMIN = [
    OWNER_ORG_2,
    USER_ORG_2,
    USER_ORG_2_NO_ORG_FILTER,
    ANONYMOUS,
    ORPHAN
]

CAN_SEE_COLLECTIONS = [[OWNER_ORG_1, COLLECTION1_ORG_1_PRIVATE],               # owner org 1 can see private collection org 1
                       [USER_ORG_1, COLLECTION1_ORG_1_PRIVATE],                # user  org 1 can see private collection org 1
                       [OWNER_ORG_2, COLLECTION1_ORG_1_PUBLIC],                # owner org 2 can see public  collection org 1
                       [USER_ORG_2, COLLECTION1_ORG_1_PUBLIC],                 # user  org 1 can see public  collection org 1
                       [USER_ORG_2_NO_ORG_FILTER, COLLECTION1_ORG_1_PUBLIC],   # user  org 2 can see private collection org 1
                       [ANONYMOUS, COLLECTION1_ORG_1_PUBLIC],                  # anonymous   can see public  collection org 1
                       [ORPHAN, COLLECTION1_ORG_1_PUBLIC],                     # orphan      can see public  collection org 1
                       [ORPHAN_ORG_FILTER_ORG1, COLLECTION1_ORG_1_PUBLIC],     # orphan      can see public  collection org 1
                       [ORPHAN_ORG_FILTER_ORG2, COLLECTION1_ORG_1_PUBLIC],     # orphan      can see public  collection org 1
                       [ORPHAN_ORG_FILTER_ARLAS_ORG1, COLLECTION1_ORG_1_PUBLIC],  # orphan2  can see public  collection org 1
                       [ORPHAN_ORG_FILTER_ORG1_ARLAS_ORG1, COLLECTION1_ORG_1_PUBLIC],  # orphan3 can see public  collection org 1
                       ]

CAN_NOT_CREATE_DELETE_OR_UPDATE = [USER_ORG_1,                # user  org 1 can not delete collection in org 1
                                   USER_ORG_2,                # user  org 2 can not delete collection in org 1
                                   OWNER_ORG_2,               # owner org 2 can not delete collection in org 1
                                   USER_ORG_2_NO_ORG_FILTER,  # user  org 2 can not delete collection in org 1
                                   ANONYMOUS,                 # anonymous   can not delete collection in org 1
                                   ORPHAN,                    # orphan      can not delete collection in org 1
                                   ORPHAN_ORG_FILTER_ORG1,    # orphan2     can not delete collection in org 1
                                   ORPHAN_ORG_FILTER_ORG2,    # orphan3     can not delete collection in org 1
                                   ORPHAN_ORG_FILTER_ARLAS_ORG1,  # orphan3 can not delete collection in org 1
                                   ORPHAN_ORG_FILTER_ORG1_ARLAS_ORG1  # orphan3 can not delete collection in org 1
                                   ]

CAN_NOT_ADD_USER_IN_ORG_2 = [OWNER_ORG_1,                # owner org 1 can not invite in org 2
                             USER_ORG_1,                 # user  org 1 can not invite in org 2
                             USER_ORG_2,                 # user  org 2 can not invite in org 2
                             USER_ORG_2_NO_ORG_FILTER,   # user  org 2 can not invite in org 2
                             ORPHAN,                     # orphan      can not invite in org 2
                             ORPHAN_ORG_FILTER_ORG1,     # orphan2     can not invite in org 2
                             ORPHAN_ORG_FILTER_ORG2,     # orphan3     can not invite in org 2
                             ORPHAN_ORG_FILTER_ARLAS_ORG1,  # orphan4 can not invite in org 2
                             ORPHAN_ORG_FILTER_ORG1_ARLAS_ORG1,  # orphan5 can not invite in org 2
                             ]


# Test organisation creation
def test_admin_create_org(fixture_cli_confs, fixture_init):
    """Test: as admin, I can create an org"""
    assert Service.create_organisation(USER_ADMIN, ORG_1).get("name") == ORG_1


@pytest.mark.parametrize("run_as", NON_ADMIN)
def test_non_admin_not_create_org(run_as, fixture_cli_confs, fixture_init, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as not admin, I can not create an org"""
    if run_as == ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        assert anonymous_iam_call("organisations/" + ORG_1, post={}).status_code > 299
    else:
        with pytest.raises(SystemExit):
            Service.create_organisation(run_as, ORG_1)


def test_anonymous_not_create_org_on_user_domain(fixture_cli_confs, fixture_init, fixture_orphans):
    """Test: as anonymous, I can not create an org on my domain"""
    assert anonymous_iam_call("organisations", post={}).status_code > 299


def test_user_create_org_on_user_domain(fixture_cli_confs, fixture_init, ):
    create_user(USER_ADMIN, USER_ORG_1)
    """Test: as user, I can create an org on my domain"""
    assert Service.create_organisation_from_user_domain(USER_ORG_1)


def test_user_not_create_org_on_forbidden_user_domain(fixture_cli_confs, fixture_init):
    create_user(USER_ADMIN, USER_ORG_1)
    """Test: as user, I can not create an org on my domain if forbidden"""
    assert Service.forbid_organisation(USER_ADMIN, ORG_1).get("name") == ORG_1
    with pytest.raises(SystemExit):
        Service.create_organisation_from_user_domain(USER_ORG_1)


# Test organisation listing visibility

@pytest.mark.parametrize("run_as", CAN_NOT_SEE_ORG1)
def test_foreigners_do_not_see_other_orgs(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as foreign user, I can not see the organisations that I do not belong to"""
    if run_as == ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        requests.get("https://localhost/arlas_iam_server/organisations", headers={"accept": "application/json;charset=utf-8"}, verify=False).status_code > 299  # NOSONAR
    else:
        assert see_organisation(run_as, ORG_1) is False


@pytest.mark.parametrize("run_as", CAN_SEE_ORG1)
def test_users_can_see_orgs(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user):
    """Test: as a user, I can see the collections of my org and public collections of other orgs"""
    oid, __, __, __ = fixture_org1_owner_and_user
    assert see_organisation(run_as, oid) is True


# Test organisation delete

def test_admin_delete_org(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user):
    oid, __, __, __ = fixture_org1_owner_and_user
    assert Service.delete_organisation(USER_ADMIN, oid)


@pytest.mark.parametrize("run_as", NON_ADMIN)
def test_non_admin_not_delete_org(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    oid, __, __, __ = fixture_org1_owner_and_user
    if run_as == ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        assert requests.delete("https://localhost/arlas_iam_server/organisations/" + oid, headers={"accept": "application/json;charset=utf-8"}, verify=False).status_code > 299  # NOSONAR
    else:
        with pytest.raises(SystemExit):
            Service.delete_organisation(run_as, oid)


# Test add users
def test_add_user_to_org_as_admin(fixture_cli_confs, fixture_init, fixture_org1_owner):
    """as admin, I can add a user in org"""
    oid, __, __ = fixture_org1_owner
    assert OWNER_ORG_1 in list(map(lambda arr: arr[1], Service.list_organisation_users(USER_ADMIN, oid)))


def test_add_user_to_org_as_owner(fixture_cli_confs, fixture_init, fixture_org1_owner):
    """as an org owner, I can add a user in my org"""
    oid, __, __ = fixture_org1_owner
    Service.add_user_in_organisation(OWNER_ORG_1, oid, USER_ORG_1, [])
    assert USER_ORG_1 in list(map(lambda arr: arr[1], Service.list_organisation_users(USER_ADMIN, oid)))


@pytest.mark.parametrize("run_as", CAN_NOT_ADD_USER_IN_ORG_2)
def test_not_add_user_to_org_as_not_owner(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as foreigner owner, foreigner user, user or orphan (with and without org-filter), I can not add a user in org 2"""
    oid, __, __, __, __ = fixture_org2_owner_and_users
    with pytest.raises(SystemExit):
        Service.add_user_in_organisation(run_as, oid, ORPHAN, [])


# Test user listing visibility

@pytest.mark.parametrize("run_as", CAN_NOT_SEE_ORG1)
def test_foreigners_do_not_see_other_org_users(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as foreign user, I can not see the users of other orgs"""
    oid, __, __, __ = fixture_org1_owner_and_user
    if run_as == ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        requests.get("https://localhost/arlas_iam_server/organisations/" + oid + "/users", headers={"accept": "application/json;charset=utf-8"}, verify=False).status_code > 299  # NOSONAR
    else:
        with pytest.raises(SystemExit):
            see_user(run_as, oid, USER_ORG_1)


def test_users_can_see_user_from_org(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as a org user, I can  see the users of my org"""
    oid, __, __, __ = fixture_org1_owner_and_user
    assert see_user(OWNER_ORG_1, oid, OWNER_ORG_1) is True
    assert see_user(OWNER_ORG_1, oid, USER_ORG_1) is True


# Test collection listing visibility


@pytest.mark.parametrize("run_as", CAN_NOT_SEE_FOREIGN_PRIVE_COLLECTIONS)
def test_foreigners_do_not_see_private_collection(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as foreign user, I can not see the collections of other orgs - ARLAS SERVER"""
    assert see_collection(run_as, COLLECTION1_ORG_1_PRIVATE) is False


@pytest.mark.parametrize("run_as, collection", CAN_SEE_COLLECTIONS)
def test_users_can_see_collection(run_as, collection, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as a user, I can see the collections of my org and public collections of other orgs - ARLAS SERVER"""
    assert see_collection(run_as, collection) is True


@pytest.mark.parametrize("run_as", CAN_NOT_SEE_FOREIGN_PRIVE_COLLECTIONS)
def test_foreigners_do_not_see_private_collection_iam(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as foreign user, I can not see the collections of other orgs - IAM"""
    oid, __, __, __ = fixture_org1_owner_and_user
    if run_as == ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        assert requests.delete("https://localhost/arlas_iam_server/organisations/" + oid + "/collections", headers={"accept": "application/json;charset=utf-8"}, verify=False).status_code > 299  # NOSONAR
    else:
        with pytest.raises(SystemExit):
            Service.list_organisation_collections(run_as, oid)


def test_users_can_see_collection_iam(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as a user, I can see the collections of my org and public collections of other orgs - IAM"""
    oid1, __, __, __ = fixture_org1_owner_and_user
    oid2, __, __, __, __ = fixture_org2_owner_and_users
    assert see_collection_iam(OWNER_ORG_1, oid1, COLLECTION1_ORG_1_PRIVATE) is True
    assert see_collection_iam(OWNER_ORG_1, oid1, COLLECTION1_ORG_1_PUBLIC) is True

    assert see_collection_iam(OWNER_ORG_2, oid2, COLLECTION1_ORG_2_PRIVATE) is True
    assert see_collection_iam(OWNER_ORG_2, oid2, COLLECTION1_ORG_1_PUBLIC) is True


# Test collection describe visibility

@pytest.mark.parametrize("run_as", CAN_NOT_SEE_FOREIGN_PRIVE_COLLECTIONS)
def test_foreigners_do_not_see_private_collection_description(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as foreign user, I can not see the description of the collections of other orgs"""
    with pytest.raises(SystemExit):
        Service.describe_collection(arlas=run_as, collection=COLLECTION1_ORG_1_PRIVATE)


@pytest.mark.parametrize("run_as, collection", CAN_SEE_COLLECTIONS)
def test_users_can_see_collection_description(run_as, collection, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as a user, I can see the description of collections of my org and public collections of other orgs"""
    Service.describe_collection(arlas=run_as, collection=collection)


# Test collection sample visibility

@pytest.mark.parametrize("run_as", CAN_NOT_SEE_FOREIGN_PRIVE_COLLECTIONS)
def test_foreigners_do_not_see_private_collection_sample(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as foreign user, I can not see sample of the collections of other orgs"""
    with pytest.raises(SystemExit):
        Service.sample_collection(run_as, COLLECTION1_ORG_1_PRIVATE, False, 1)


@pytest.mark.parametrize("run_as, collection", CAN_SEE_COLLECTIONS)
def test_users_can_see_collection_sample(run_as, collection, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as a user, I can see sample of the collections of my org and public collections of other orgs"""
    Service.sample_collection(run_as, collection, False, 1)


#  CREATING, DELETING AND UPDATING COLLECTIONS
# Test collection creation

def test_owner_can_create_collection(fixture_cli_confs, fixture_init, fixture_org1_owner):
    """Test: as owner, I can create a collection"""
    create_collection(OWNER_ORG_1, ORG_1, COLLECTION1_ORG_1_PRIVATE, INDEX_ORG1, False)


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_create_collection(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not create a collection"""
    with pytest.raises(SystemExit):
        create_collection(run_as, ORG_1, COLLECTION1_ORG_1_PRIVATE, INDEX_ORG1, False)


def test_owner_can_not_create_collection_with_wrong_index_prefix(fixture_cli_confs, fixture_init, fixture_org1_owner):
    """Test: as owner I can not create a collection on an index that does not start with my org"""
    with pytest.raises(SystemExit):
        create_collection(OWNER_ORG_1, ORG_1, COLLECTION1_ORG_1_PRIVATE, INDEX_ORG2, False)


#  Test delete collection
def test_owner_can_delete_collection(fixture_cli_confs, fixture_init, fixture_org1_owner, fixture_org2_owner, fixture_collections):
    """Test: as owner, I can create a collection"""
    Service.delete_collection(arlas=OWNER_ORG_1, collection=COLLECTION1_ORG_1_PRIVATE)


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE) 
def test_can_not_delete_collection(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not delete a collection"""
    with pytest.raises(SystemExit):
        Service.delete_collection(arlas=run_as, collection=COLLECTION1_ORG_1_PRIVATE)


#  Test update collection
def test_owner_can_update_collection(fixture_cli_confs, fixture_init, fixture_org1_owner, fixture_org2_owner, fixture_collections):
    """Test: as owner, I can update a collection"""
    Service.set_collection_visibility(arlas=OWNER_ORG_1, collection=COLLECTION1_ORG_1_PRIVATE, public=True)


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_update_collection(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans, fixture_collections):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not update a collection"""
    with pytest.raises(SystemExit):
        Service.set_collection_visibility(arlas=run_as, collection=COLLECTION1_ORG_1_PRIVATE, public=True)


#  CREATING AND DELETING GROUPS, PERMISSIONS AND ASSOCIATIONS

def test_owner_can_create_and_delete_group_and_permission(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user):
    """Test: as owner, I can create a group and permission"""
    oid, __, __, __ = fixture_org1_owner_and_user
    permission_id = Service.add_permission_in_organisation(OWNER_ORG_1, oid, PERMISSION, "nakskov").get("id")
    group_id = Service.add_group_in_organisation(OWNER_ORG_1, oid, "nakskov", "Around nakskov").get("id")
    assert Service.add_permission_to_group_in_organisation(OWNER_ORG_1, oid, group_id, permission_id).get("id")
    assert Service.delete_permission_from_group_in_organisation(OWNER_ORG_1, oid, group_id, permission_id)
    assert Service.delete_group_in_organisation(OWNER_ORG_1, oid, group_id)
    assert Service.delete_permission_in_organisation(OWNER_ORG_1, oid, permission_id)


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_create_permission(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not create a permission"""
    oid, __, __, __ = fixture_org1_owner_and_user
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.add_permission_in_organisation(run_as, oid, PERMISSION, "nakskov")
    else:
        assert anonymous_iam_call("/".join(["organisations", oid, "permissions"]), post=json.dumps({"value": PERMISSION, "description": "nakskov"})).status_code == 401


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_create_group(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not create a group"""
    oid, __, __, __ = fixture_org1_owner_and_user
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.add_group_in_organisation(run_as, oid, "nakskov", "Around nakskov")
    else:
        assert anonymous_iam_call("/".join(["organisations", oid, "groups"]), post=json.dumps({"name": "nakskov", "description": "Around nakskov"})).status_code == 401


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_associate_role_permission(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not associate a role and permission"""
    oid, __, __, __ = fixture_org1_owner_and_user
    permission_id = Service.add_permission_in_organisation(OWNER_ORG_1, oid, PERMISSION, "nakskov").get("id")
    role_id = Service.add_group_in_organisation(OWNER_ORG_1, oid, "nakskov", "Around nakskov").get("id")
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.add_permission_to_group_in_organisation(run_as, oid, role_id, permission_id).get("id")
    else:
        assert anonymous_iam_call("/".join(["organisations", oid, "roles", role_id, "permissions", permission_id]), post=json.dumps({})).status_code == 401


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_delete_group(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not delete a group"""
    oid, __, __, __ = fixture_org1_owner_and_user
    group_id = Service.add_group_in_organisation(OWNER_ORG_1, oid, "nakskov", "Around nakskov").get("id")
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.delete_group_in_organisation(run_as, oid, group_id)
    else:
        assert anonymous_iam_call("/".join(["organisations", oid, "groups", group_id]), delete=True).status_code == 401


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_delete_permission(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not delete a permission"""
    oid, __, __, __ = fixture_org1_owner_and_user
    permission_id = Service.add_permission_in_organisation(OWNER_ORG_1, oid, PERMISSION, "nakskov").get("id")
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.delete_permission_in_organisation(run_as, oid, permission_id)
    else:
        assert anonymous_iam_call("/".join(["organisations", oid, "permissions", permission_id]), delete=True).status_code == 401


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_delete_association(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not delete an association"""
    oid, __, __, __ = fixture_org1_owner_and_user
    permission_id = Service.add_permission_in_organisation(OWNER_ORG_1, oid, PERMISSION, "nakskov").get("id")
    group_id = Service.add_group_in_organisation(OWNER_ORG_1, oid, "nakskov", "Around nakskov").get("id")
    Service.add_permission_to_group_in_organisation(OWNER_ORG_1, oid, group_id, permission_id).get("id")
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.delete_permission_from_group_in_organisation(run_as, oid, group_id, permission_id)
    else:
        assert anonymous_iam_call("/".join(["organisations", oid, "roles", group_id, "permissions", permission_id]), delete=True).status_code == 401


# PERMISSION VISIBILITY
def test_can_see_all_hits(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_collections):
    """Test: as user with full visibility, I see all collection hits"""
    __, __, __, __ = fixture_org1_owner_and_user
    count = Service.count_collection(USER_ORG_1, COLLECTION1_ORG_1_PRIVATE)[1]
    assert count == ['org1_collection_private', 69]


def test_can_see_one_hit_with_permission(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_collections):
    """Test: as user with full visibility, I see all collection hits"""
    oid, __, __, groups = fixture_org1_owner_and_user
    Service.remove_user_from_organisation_group(OWNER_ORG_1, oid, USER_TO_UID[USER_ORG_1], groups.get("group/config.json/" + ORG_1))
    permission_id = Service.add_permission_in_organisation(OWNER_ORG_1, oid, PERMISSION, "nakskov").get("id")
    group_id = Service.add_group_in_organisation(OWNER_ORG_1, oid, "nakskov", "Around nakskov").get("id")
    Service.add_permission_to_group_in_organisation(OWNER_ORG_1, oid, group_id, permission_id).get("id")
    Service.add_user_to_organisation_group(OWNER_ORG_1, oid, USER_TO_UID[USER_ORG_1], group_id)
    count = Service.count_collection(USER_ORG_1, COLLECTION1_ORG_1_PRIVATE)[1]
    assert count == ['org1_collection_private', 1]


# CREATE AND DELETE API KEYS

@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_create_apikey(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    oid, __, __, groups = fixture_org1_owner_and_user
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.create_api_key(run_as, oid, "API key for " + run_as, 1, USER_TO_UID[OWNER_ORG_1], get_groups_and_roles_ids(oid))
    else:
        assert anonymous_iam_call("/".join(["organisations", oid, "users", USER_TO_UID[OWNER_ORG_1], "apikeys"]), post=json.dumps({"name": "API key for anonymous", "ttlInDays": 1, "roleIds": groups})).status_code == 401


def test_can_not_create_apikey_for_other_org_users(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    oid, __, __, __ = fixture_org1_owner_and_user
    oid2, __, __, __, __ = fixture_org2_owner_and_users
    with pytest.raises(SystemExit):
        Service.create_api_key(OWNER_ORG_1, oid, "API key for " + OWNER_ORG_2, 1, USER_TO_UID[OWNER_ORG_2], get_groups_and_roles_ids(oid2))
    with pytest.raises(SystemExit):
        Service.create_api_key(OWNER_ORG_1, oid2, "API key for " + OWNER_ORG_2, 1, USER_TO_UID[OWNER_ORG_2], get_groups_and_roles_ids(oid2))


def test_can_create_apikey_as_owner_and_admin(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    oid, __, __, __ = fixture_org1_owner_and_user
    Service.create_api_key(OWNER_ORG_1, oid, "API key for " + OWNER_ORG_1, 1, USER_TO_UID[OWNER_ORG_1], get_groups_and_roles_ids(oid))
    Service.create_api_key(USER_ADMIN, oid, "API key for " + USER_ORG_1, 1, USER_TO_UID[USER_ORG_1], get_groups_and_roles_ids(oid))


def test_can_delete_apikey_as_owner(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    oid, __, __, __ = fixture_org1_owner_and_user
    kid = Service.create_api_key(OWNER_ORG_1, oid, "API key for " + OWNER_ORG_1, 1, USER_TO_UID[OWNER_ORG_1], get_groups_and_roles_ids(oid)).get("id")
    Service.delete_api_key(OWNER_ORG_1, oid, USER_TO_UID[OWNER_ORG_1], kid)


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_delete_apikey(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    oid, __, __, __ = fixture_org1_owner_and_user
    kid = Service.create_api_key(OWNER_ORG_1, oid, "API key for " + OWNER_ORG_1, 1, USER_TO_UID[OWNER_ORG_1], get_groups_and_roles_ids(oid)).get("id")
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.delete_api_key(run_as, oid, USER_TO_UID[OWNER_ORG_1], kid)
    else:
        assert anonymous_iam_call("/".join(["organisations", oid, "users", USER_TO_UID[OWNER_ORG_1], "apikeys", id]), delete=True).status_code == 401


def test_apikey_works_no_group(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_collections):
    time.sleep(2)
    oid, __, __, __ = fixture_org1_owner_and_user
    key = Service.create_api_key(OWNER_ORG_1, oid, "API key for " + OWNER_ORG_1 + " no groups", 1, USER_TO_UID[OWNER_ORG_1], [])
    collections = api_key_call("/explore/_list", key.get("keyId"), key.get("keySecret")).json()
    assert set(map(lambda c: c.get("collection_name"), collections)) == {COLLECTION1_ORG_1_PUBLIC}


def test_apikey_works_with_groups(fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_collections):
    oid, __, __, __ = fixture_org1_owner_and_user
    print(get_groups_and_roles_ids(oid))
    key = Service.create_api_key(OWNER_ORG_1, oid, "API key for " + OWNER_ORG_1 + " with groups", 1, USER_TO_UID[OWNER_ORG_1], get_groups_and_roles_ids(oid))
    collections = api_key_call("/explore/_list", key.get("keyId"), key.get("keySecret")).json()
    assert set(map(lambda c: c.get("collection_name"), collections)) == {COLLECTION1_ORG_1_PRIVATE, COLLECTION1_ORG_1_PUBLIC}

# FORBIDDEN ORGS


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_authorize_org(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    assert Service.forbid_organisation(USER_ADMIN, "gisaia.com").get("name") == "gisaia.com"
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.authorize_organisation(run_as, "gisaia.com")
    else:
        assert anonymous_iam_call("/".join(["organisations", "forbidden", "gisaia.com"]), delete=True).status_code == 401


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_add_forbidden_org(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.forbid_organisation(run_as, "gisaia.com")
    else:
        assert anonymous_iam_call("/".join(["organisations", "forbidden"]), post=json.dumps({"name": "gisaia.com"})).status_code == 401


def test_can_forbid_org(fixture_cli_confs, fixture_init):
    assert Service.forbid_organisation(USER_ADMIN, "gisaia.com").get("name") == "gisaia.com"


def test_can_authorize_org(fixture_cli_confs, fixture_init):
    test_can_forbid_org(fixture_cli_confs, fixture_init)
    assert Service.authorize_organisation(USER_ADMIN, "gisaia.com").get("message") == "ok"


@pytest.mark.parametrize("run_as", CAN_NOT_CREATE_DELETE_OR_UPDATE)
def test_can_not_list_forbidden(run_as, fixture_cli_confs, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_users, fixture_orphans):
    assert Service.forbid_organisation(USER_ADMIN, "gisaia.com").get("name") == "gisaia.com"
    if run_as != ANONYMOUS:  # arlas_cli does not handle calls to iam without identity
        with pytest.raises(SystemExit):
            Service.forbidden_organisations(run_as)
    else:
        assert anonymous_iam_call("/".join(["organisations", "forbidden"])).status_code == 401


def test_can_list_forbidden(fixture_cli_confs, fixture_init):
    assert Service.forbid_organisation(USER_ADMIN, "gisaia.com").get("name") == "gisaia.com"
    print(Service.forbidden_organisations(USER_ADMIN))
