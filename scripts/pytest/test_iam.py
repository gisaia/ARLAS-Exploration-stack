import pytest
from arlas.cli.service import Service
from conftest import USER_ADMIN
from helper import see_collection
from variables import ORG_1, USER_1_ORG_1, USER_2_ORG_1, USER_2_ORG_2


def test_create_org(fixture_init):
    assert Service.create_organisation(USER_ADMIN, ORG_1).get("name") == ORG_1


def test_add_user_to_org_as_admin(fixture_init, fixture_org1_user1):
    """as admin, I can add a user in org"""
    oid, email, groups = fixture_org1_user1
    assert USER_1_ORG_1 in list(map(lambda arr: arr[1], Service.list_organisation_users(USER_ADMIN, oid)))


def test_add_user_to_org_as_owner(fixture_init, fixture_org1_user1):
    """as an org owner, I can add a user in my org"""
    oid, email, groups = fixture_org1_user1
    Service.add_user_in_organisation(USER_1_ORG_1, oid, USER_2_ORG_1, [])
    assert USER_2_ORG_1 in list(map(lambda arr: arr[1], Service.list_organisation_users(USER_ADMIN, oid)))


def test_add_user_to_org_as_owner(fixture_init, fixture_org1_user1, fixture_org2_user2, fixture_orphans):
    """Test: as foreing user, I can not see the collections of others"""
    see_collection(USER_2_ORG_2, )