#!/bin/bash
set -o errexit -o pipefail
. conf/stack.env
. ./scripts/test_iam_functions.sh
. ./scripts/test_iam_variables.sh


# USER NOT IN ORG
# READ
echo "Test: as foreing user, I can not see the collections of others"
arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${USER_ORG2} list > /tmp/test_file
must_not_find_keyword "course_user1_org1_private" 

echo "Test: as orphan user, I can not see the collections of others"
arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${ORPHAN} list > /tmp/test_file
echo "skipped until fixed"
#SKIP TODO: activate when fixed : 
#must_not_find_keyword "course_user1_org1_private"

echo "Test: as orphan user, I can not see the collections of others, even with a faking apporpiate org-filter "
arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${ORPHAN_WITH_ORG_FILTER} list > /tmp/test_file
echo "skipped until fixed"
#SKIP TODO: activate when fixed : 
#must_not_find_keyword "course_user1_org1_private"

echo "Test: as a user, I can not see the collections of others, even without my org-filter"
arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${USER3_ORG1} list > /tmp/test_file
echo "skipped until fixed"
#SKIP TODO: activate when fixed : 
#must_not_find_keyword "course_user_org2_private"


# WRITE
echo "Test: as simple user, I can NOT delete the collections of my org"
set +e
yes | arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${USER2_ORG1_ORG2} delete course_user1_org1_private
must_fail $?
set -e

echo "Test: as foreing user, I can NOT delete the collections of others"
echo "skipped until fixed"
#set +e
#SKIP TODO: activate when fixed : 
#yes | arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${USER_ORG2} delete course_user1_org1_private
#must_fail $?
#set -e


echo "Test: as foreing user, I can NOT delete the collections of others, even without org-filter"
set +e
yes | arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${USER3_ORG1} delete course_user_org2_private
must_fail $?
set -e

echo "Test: as orphan user, I can NOT delete the collections of others"
set +e
yes | arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${ORPHAN} delete course_user_org2_private
must_fail $?
set -e


echo "Test: as orphan user, I can NOT delete the collections of others, even with a faking apporpiate org-filter"
set +e
yes | arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${ORPHAN_WITH_ORG_FILTER} delete course_user1_org1_private
must_fail $?
set -e


# USER IN ORG
# READ
echo "Test: as a owner of the org, I can see the collections of my org"
arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${USER1_ORG1} list > /tmp/test_file
must_find_keyword "course_user1_org1_private"

echo "Test: as a owner of the org, I can see the collections of my org"
arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${USER1_ORG1} list > /tmp/test_file
must_find_keyword "course_user1_org1_private"

echo "Test: as a simple user of the org, I can see the collections of my org"
arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${USER2_ORG1_ORG2} list > /tmp/test_file
must_find_keyword "course_user1_org1_private"

