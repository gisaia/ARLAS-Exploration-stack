import time
import pytest
from arlas.cli.service import Service
from conftest import USER_ADMIN
from helper import create_collection, see_collection
from variables import ANONYMOUS, COLLECTION1_ORG_1_PRIVATE, COLLECTION1_ORG_1_PUBLIC, INDEX_ORG1, INDEX_ORG2, ORG_1, ORPHAN, ORPHAN2, ORPHAN3, OWNER_ORG_1, OWNER_ORG_2, USER_ORG_1, USER_ORG_2


# Test organisation creation
def test_admin_create_org(fixture_init):
    assert Service.create_organisation(USER_ADMIN, ORG_1).get("name") == ORG_1


def test_orphan_not_create_org(fixture_init, fixture_orphans):
    orphan, __, ___ = fixture_orphans
    with pytest.raises(SystemExit):
        assert Service.create_organisation(orphan, ORG_1)


# Test add users
def test_add_user_to_org_as_admin(fixture_init, fixture_org1_owner):
    """as admin, I can add a user in org"""
    oid, email, groups = fixture_org1_owner
    assert OWNER_ORG_1 in list(map(lambda arr: arr[1], Service.list_organisation_users(USER_ADMIN, oid)))


def test_add_user_to_org_as_owner(fixture_init, fixture_org1_owner):
    """as an org owner, I can add a user in my org"""
    oid, email, groups = fixture_org1_owner
    Service.add_user_in_organisation(OWNER_ORG_1, oid, USER_ORG_1, [])
    assert USER_ORG_1 in list(map(lambda arr: arr[1], Service.list_organisation_users(USER_ADMIN, oid)))


@pytest.mark.parametrize("run_as",
                         [OWNER_ORG_1,  # owner org 1 can not invite in org 2
                          USER_ORG_1,   # user  org 1 can not invite in org 2
                          USER_ORG_2,   # user  org 2 can not invite in org 2
                          ORPHAN,       # orphan      can not invite in org 2
                          ORPHAN2,      # orphan2     can not invite in org 2
                          ORPHAN3,])    # orphan3     can not invite in org 2
def test_not_add_user_to_org_as_not_owner(run_as, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner, fixture_orphans):
    """Test: as foreigner owner, foreigner user, user or orphan (with and without org-filter), I can not add a user in org"""
    oid, __, __ = fixture_org2_owner
    with pytest.raises(SystemExit):
        Service.add_user_in_organisation(run_as, oid, USER_ORG_1, [])


# Test collection listing visibility

@pytest.mark.parametrize("run_as",
                         [OWNER_ORG_2,  # owner org 2 can not see private collection org 1
                          USER_ORG_2,   # user  org 2 can not see private collection org 1
                          ANONYMOUS,    # anonymous   can not see private collection org 1
                          ORPHAN,       # orphan      can not see private collection org 1
                          ORPHAN2,      # orphan2     can not see private collection org 1
                          ORPHAN3])     # orphan3     can not see private collection org 1
def test_foreingers_does_not_see_private_collection(run_as, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_user, fixture_orphans, fixture_collections):
    """Test: as foreing user, I can not see the collections of other orgs"""
    assert see_collection(run_as, COLLECTION1_ORG_1_PRIVATE) is False


@pytest.mark.parametrize("run_as, collection",
                         [[OWNER_ORG_1, COLLECTION1_ORG_1_PRIVATE],  # owner org 1 can see private collection org 1
                          [USER_ORG_1, COLLECTION1_ORG_1_PRIVATE],   # user  org 1 can see private collection org 1
                          [OWNER_ORG_2, COLLECTION1_ORG_1_PUBLIC],   # owner org 2 can see public  collection org 1
                          [USER_ORG_2, COLLECTION1_ORG_1_PUBLIC],    # user  org 1 can see public  collection org 1
                          [ANONYMOUS, COLLECTION1_ORG_1_PUBLIC],     # anonymous   can see public  collection org 1
                          [ORPHAN, COLLECTION1_ORG_1_PUBLIC],        # orphan      can see public  collection org 1
                          [ORPHAN2, COLLECTION1_ORG_1_PUBLIC],       # orphan2     can see public  collection org 1
                          [ORPHAN3, COLLECTION1_ORG_1_PUBLIC]])      # orphan3     can see public  collection org 1
def test_users_can_see_collection(run_as, collection, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_user, fixture_orphans, fixture_collections):
    """Test: as a user, I can see the collections of my org and public collections of other orgs"""
    assert see_collection(run_as, collection) is True


# Test collection describe visibility

@pytest.mark.parametrize("run_as",
                         [OWNER_ORG_2,  # owner org 2 can not see private collection org 1
                          USER_ORG_2,   # user  org 2 can not see private collection org 1
                          ANONYMOUS,    # anonymous   can not see private collection org 1
                          ORPHAN,       # orphan      can not see private collection org 1
                          ORPHAN2,      # orphan2     can not see private collection org 1
                          ORPHAN3])     # orphan3     can not see private collection org 1
def test_foreingers_does_not_see_private_collection_description(run_as, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_user, fixture_orphans, fixture_collections):
    """Test: as foreing user, I can not see the description of the collections of other orgs"""
    with pytest.raises(SystemExit):
        Service.describe_collection(arlas=run_as, collection=COLLECTION1_ORG_1_PRIVATE)


@pytest.mark.parametrize("run_as, collection",
                         [[OWNER_ORG_1, COLLECTION1_ORG_1_PRIVATE],  # owner org 1 can see private collection org 1
                          [USER_ORG_1, COLLECTION1_ORG_1_PRIVATE],   # user  org 1 can see private collection org 1
                          [OWNER_ORG_2, COLLECTION1_ORG_1_PUBLIC],   # owner org 2 can see public collection org 1
                          [USER_ORG_2, COLLECTION1_ORG_1_PUBLIC],    # user  org 1 can see public collection org 1
                          [ANONYMOUS, COLLECTION1_ORG_1_PUBLIC],     # anonymous      can see public collection org 1
                          [ORPHAN, COLLECTION1_ORG_1_PUBLIC],        # orphan      can see public collection org 1
                          [ORPHAN2, COLLECTION1_ORG_1_PUBLIC],       # orphan2     can see public collection org 1
                          [ORPHAN3, COLLECTION1_ORG_1_PUBLIC]])      # orphan3     can see public collection org 1
def test_users_can_see_collection_description(run_as, collection, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_user, fixture_orphans, fixture_collections):
    """Test: as a user, I can see the description of collections of my org and public collections of other orgs"""
    Service.describe_collection(arlas=run_as, collection=collection)


# Test collection sample visibility

@pytest.mark.parametrize("run_as",
                         [OWNER_ORG_2,  # owner org 2 can not see private collection org 1
                          USER_ORG_2,   # user  org 2 can not see private collection org 1
                          ANONYMOUS,    # anonymous   can not see private collection org 1
                          ORPHAN,       # orphan      can not see private collection org 1
                          ORPHAN2,      # orphan2     can not see private collection org 1
                          ORPHAN3])     # orphan3     can not see private collection org 1
def test_foreingers_does_not_see_private_collection_sample(run_as, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_user, fixture_orphans, fixture_collections):
    """Test: as foreing user, I can not see sample of the collections of other orgs"""
    with pytest.raises(SystemExit):
        Service.sample_collection(run_as, COLLECTION1_ORG_1_PRIVATE, False, 1)


@pytest.mark.parametrize("run_as, collection",
                         [[OWNER_ORG_1, COLLECTION1_ORG_1_PRIVATE],  # owner org 1 can see private collection org 1
                          [USER_ORG_1, COLLECTION1_ORG_1_PRIVATE],   # user  org 1 can see private collection org 1
                          [OWNER_ORG_2, COLLECTION1_ORG_1_PUBLIC],   # owner org 2 can see public  collection org 1
                          [USER_ORG_2, COLLECTION1_ORG_1_PUBLIC],    # user  org 1 can see public  collection org 1
                          [ANONYMOUS, COLLECTION1_ORG_1_PUBLIC],     # anonymous   can see public  collection org 1
                          [ORPHAN, COLLECTION1_ORG_1_PUBLIC],        # orphan      can see public  collection org 1
                          [ORPHAN2, COLLECTION1_ORG_1_PUBLIC],       # orphan2     can see public  collection org 1
                          [ORPHAN3, COLLECTION1_ORG_1_PUBLIC]])      # orphan3     can see public  collection org 1
def test_users_can_see_collection_sample(run_as, collection, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_user, fixture_orphans, fixture_collections):
    """Test: as a user, I can see sample of the collections of my org and public collections of other orgs"""
    Service.sample_collection(run_as, collection, False, 1)


# Test collection creation
def test_owner_can_create_collection(fixture_init, fixture_org1_owner):
    """Test: as owner, I can create a collection"""
    create_collection(OWNER_ORG_1, ORG_1, COLLECTION1_ORG_1_PRIVATE, INDEX_ORG1, False)


@pytest.mark.parametrize("run_as, index",
                         [[OWNER_ORG_1, INDEX_ORG2],  # owner org 1 can not create collection in org 1 with index org2
                          [USER_ORG_1, INDEX_ORG1],   # user  org 1 can not create collection in org 1 with index org1
                          [USER_ORG_1, INDEX_ORG2],   # user  org 1 can not create collection in org 1 with index org2
                          [USER_ORG_2, INDEX_ORG1],   # user  org 2 can not create collection in org 1 with index org1
                          [USER_ORG_2, INDEX_ORG2],   # user  org 2 can not create collection in org 1 with index org2
                          [OWNER_ORG_2, INDEX_ORG1],  # owner org 2 can not create collection in org 1 with index org1
                          [OWNER_ORG_2, INDEX_ORG2],  # owner org 2 can not create collection in org 1 with index org2
                          [ANONYMOUS, INDEX_ORG1],    # anonymous   can not create collection in org 1 with index org1
                          [ANONYMOUS, INDEX_ORG2],    # anonymous   can not create collection in org 1 with index org2
                          [ORPHAN, INDEX_ORG1],       # orphan      can not create collection in org 1 with index org1
                          [ORPHAN, INDEX_ORG2],       # orphan      can not create collection in org 1 with index org2
                          [ORPHAN2, INDEX_ORG1],      # orphan2     can not create collection in org 1 with index org1
                          [ORPHAN2, INDEX_ORG2],      # orphan2     can not create collection in org 1 with index org2
                          [ORPHAN3, INDEX_ORG1],      # orphan3     can not create collection in org 1 with index org1
                          [ORPHAN3, INDEX_ORG2]])     # orphan3     can not create collection in org 1 with index org2
def test_can_not_create_collection(run_as, index, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_user, fixture_orphans):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not create a collection"""
    with pytest.raises(SystemExit):
        create_collection(run_as, ORG_1, COLLECTION1_ORG_1_PRIVATE, index, False)


#  Test delete collection
def test_owner_can_delete_collection(fixture_init, fixture_org1_owner, fixture_org2_owner, fixture_collections):
    """Test: as owner, I can create a collection"""
    Service.delete_collection(arlas=OWNER_ORG_1, collection=COLLECTION1_ORG_1_PRIVATE)


@pytest.mark.parametrize("run_as",
                         [USER_ORG_1,   # user  org 1 can not delete collection in org 1
                          USER_ORG_2,   # user  org 2 can not delete collection in org 1
                          OWNER_ORG_2,  # owner org 2 can not delete collection in org 1
                          ANONYMOUS,    # anonymous   can not delete collection in org 1
                          ORPHAN,       # orphan      can not delete collection in org 1
                          ORPHAN2,      # orphan2     can not delete collection in org 1
                          ORPHAN3])     # orphan3     can not delete collection in org 1
def test_can_not_delete_collection(run_as, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_user, fixture_orphans, fixture_collections):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not delete a collection"""
    with pytest.raises(SystemExit):
        Service.delete_collection(arlas=run_as, collection=COLLECTION1_ORG_1_PRIVATE)


#  Test update collection
def test_owner_can_update_collection(fixture_init, fixture_org1_owner, fixture_org2_owner, fixture_collections):
    """Test: as owner, I can update a collection"""
    Service.set_collection_visibility(arlas=OWNER_ORG_1, collection=COLLECTION1_ORG_1_PRIVATE, public=True)


@pytest.mark.parametrize("run_as",
                         [USER_ORG_1,   # user  org 1 can not delete collection in org 1
                          USER_ORG_2,   # user  org 2 can not delete collection in org 1
                          OWNER_ORG_2,  # owner org 2 can not delete collection in org 1
                          ANONYMOUS,    # anonymous   can not delete collection in org 1
                          ORPHAN,       # orphan      can not delete collection in org 1
                          ORPHAN2,      # orphan2     can not delete collection in org 1
                          ORPHAN3])     # orphan3     can not delete collection in org 1
def test_can_not_update_collection(run_as, fixture_init, fixture_org1_owner_and_user, fixture_org2_owner_and_user, fixture_orphans, fixture_collections):
    """Test: as user, foreigner or orphan (with and without org-filter), I can not update a collection"""
    with pytest.raises(SystemExit):
        Service.set_collection_visibility(arlas=run_as, collection=COLLECTION1_ORG_1_PRIVATE, public=True)
