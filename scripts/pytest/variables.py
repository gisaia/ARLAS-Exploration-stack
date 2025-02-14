USER_ADMIN = "tech@gisaia.com"
ORG_1 = "org1.com"
OWNER_ORG_1 = "user1@" + ORG_1
USER_ORG_1 = "user2@" + ORG_1

ORG_2 = "org2.com"
OWNER_ORG_2 = "user1@" + ORG_2
USER_ORG_2 = "user2@" + ORG_2
USER_ORG_2_NO_ORG_FILTER = "user3@" + ORG_2

ORPHAN = "orphan@org.com"    # Has no ORG
ORPHAN_ORG_FILTER_ORG1 = "orphan2@org.com"  # Has no ORG but fake to be in org 1 with org-filter
ORPHAN_ORG_FILTER_ORG2 = "orphan3@org.com"  # Has no ORG but fake to be in org 2 with org-filter
ORPHAN_ORG_FILTER_ARLAS_ORG1 = "orphan4@org.com"  # Has no ORG but fake to be in org 1 with arlas-organization
ORPHAN_ORG_FILTER_ORG1_ARLAS_ORG1 = "orphan5@org.com"  # Has no ORG but fake to be in org 2 with arlas-organization and org-filter

ANONYMOUS = "anonymous"

COLLECTION1_ORG_1_PRIVATE = "org1_collection_private"
COLLECTION1_ORG_2_PRIVATE = "org2_collection_private"
COLLECTION1_ORG_1_PUBLIC = "org1_collection_public"


INDEX_ORG1 = "org1.com@courses"
INDEX_ORG2 = "org2.com@courses"
INDICES = [INDEX_ORG1, INDEX_ORG2]

USERS = [OWNER_ORG_1]
ES_ENDPOINT = "http://localhost:9200"

SQL_INIT = """
DELETE FROM APIKEY;
DELETE FROM APIKEYROLE;
DELETE FROM ROLEPERMISSION;
DELETE FROM PERMISSION;
DELETE FROM REFRESHTOKEN;
DELETE FROM TOKENSECRET;
DELETE FROM USER_DATA;
DELETE FROM USER_DATA_READERS;
DELETE FROM USER_DATA_WRITERS;
DELETE FROM USERROLE where userrole.id_role in (select id from role where ID_ORGANISATION IS NOT NULL);
DELETE FROM ROLE WHERE ID_ORGANISATION IS NOT NULL;
DELETE FROM ORGANISATIONMEMBER;
DELETE FROM ORGANISATION;
DELETE FROM USERS WHERE email <> 'tech@gisaia.com';
"""
