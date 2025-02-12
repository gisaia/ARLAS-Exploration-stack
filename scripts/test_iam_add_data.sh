#!/bin/bash
set -o errexit -o pipefail
. conf/stack.env
. ./scripts/test_iam_functions.sh
. ./scripts/test_iam_variables.sh

echo "Fetch sample data"
curl https://raw.githubusercontent.com/gisaia/arlas_cli/master/tests/sample.json -o sample/sample.json
. conf/stack.env

echo "Test: as the org owner, I can add a collection and a dashboard"
add_data_collection_and_dashboard ${USER1_ORG1} ${ORG1} "course_user1_org1_private" "--no-public"

echo "Test: as the org owner, I can add a collection and a dashboard"
add_data_collection_and_dashboard ${USER_ORG2} ${ORG2} "course_user_org2_private" "--no-public"

echo "Test: as the org owner, I can add a public collection and a dashboard"
add_data_collection_and_dashboard ${USER_ORG2} ${ORG2} "course_user_org2_public" "--public"

