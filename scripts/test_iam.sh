#!/bin/bash
set -o errexit -o pipefail

./scripts/test_iam_init_iam_stack_with_orgs_and_users.sh; 
./scripts/test_iam_add_data.sh
./scripts/test_iam_test_permissions.sh
