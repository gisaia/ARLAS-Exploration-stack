#!/bin/bash
set -o errexit -o pipefail
. conf/stack.env
. ./scripts/test_iam_functions.sh
. ./scripts/test_iam_variables.sh

rm $ARLAS_CLI_CONF_FILE
arlas_cli --config-file $ARLAS_CLI_CONF_FILE --version

register_user_in_cli $ADMIN admin

# ORG1
echo "Test: as the admin, I can create an organisation"
add_org ${ADMIN} ${ORG1}
ORG1_ID=$RETURNED_ORGID

echo "Test: as the admin, I can create a user"
create_user ${ADMIN} ${USER1_ORG1} ${ORG1_ID} ${ORG1}

echo "Test: as the admin, I can add the user in the org"
add_user_to_org ${ADMIN} ${USER1_ORG1} ${ORG1_ID} ${ORG1} ${IS_OWNER}
register_user_in_cli ${USER1_ORG1} secret ${ORG1}

echo "Test: as the org owner, I can create a second user"
create_user ${USER1_ORG1} ${USER2_ORG1_ORG2} ${ORG1_ID} ${ORG1}

echo "Test: as the org owner, I can add the user in the org"
add_user_to_org ${USER1_ORG1} ${USER2_ORG1_ORG2} ${ORG1_ID} ${ORG1} ${IS_USER}
register_user_in_cli ${USER2_ORG1_ORG2} secret ${ORG1}

echo "Test: as the org owner, I can create a third user"
create_user ${USER1_ORG1} ${USER3_ORG1} ${ORG1_ID} ${ORG1}
add_user_to_org ${USER1_ORG1} ${USER3_ORG1} ${ORG1_ID} ${ORG1} ${IS_USER}
register_user_in_cli ${USER3_ORG1} secret

# ORG2
echo "Test: as the admin, I can create an oraganisation"
add_org ${ADMIN} ${ORG2}
ORG2_ID=$RETURNED_ORGID

echo "Test: as the admin, I can create a user"
create_user ${ADMIN} ${USER_ORG2} ${ORG2_ID} ${ORG2}

echo "Test: as the admin, I can add the user in the org"
add_user_to_org ${ADMIN} ${USER_ORG2} ${ORG2_ID} ${ORG2} ${IS_OWNER}
register_user_in_cli ${USER_ORG2} secret ${ORG2}

echo "Test: as the org owner, I can add the user of an other org in my org"
add_user_to_org ${USER_ORG2} ${USER2_ORG1_ORG2} ${ORG2_ID} ${ORG2} ${IS_USER}

# ORPHAN
create_user ${ADMIN} ${ORPHAN} "" ""
register_user_in_cli $ORPHAN secret

# ORPHAN_WITH_ORG_FILTER
create_user ${ADMIN} ${ORPHAN_WITH_ORG_FILTER} ${ORG1_ID} ${ORG1}
register_user_in_cli $ORPHAN_WITH_ORG_FILTER secret
