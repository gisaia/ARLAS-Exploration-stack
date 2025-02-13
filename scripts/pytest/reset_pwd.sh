#!/bin/bash
set -o errexit -o pipefail
USER_NAME=$1
USERID=$2

curl -kX POST https://localhost/arlas_iam_server/users/resetpassword -H 'Content-Type: application/json;charset=utf-8' -d $USER_NAME
TOKEN=`docker logs arlas-iam-server --tail 100 | grep "Reset token" | tail -1 | awk -F 'token: ' '{print $2}'`
curl -kX POST https://localhost/arlas_iam_server/users/${USERID}/reset/${TOKEN} -H 'Content-Type: application/json;charset=utf-8' -d "secret"
