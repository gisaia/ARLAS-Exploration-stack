#!/bin/bash
[ -z "$1" ] && echo "Please provide the configuration name" && exit 1;

CONF=$1
if [ ${CONF} == "local.iam.admin" ]; then
    echo "create user"
    USERID=`arlas_cli --config-file /tmp/arlas-cli.yaml iam --config ${CONF} users add user@org.com`
    echo "create organisation"
    ORGID=`arlas_cli --config-file /tmp/arlas-cli.yaml iam --config ${CONF} orgs add org.com`
    echo "extract roles and group ids"
    USER_ROLE_ID=`arlas_cli --config-file /tmp/arlas-cli.yaml  iam --config local.iam.admin orgs groups ${ORGID} | grep role/arlas/user | awk -F '\|' '{print $2}' | xargs`
    SEE_ALL_GROUP_ID=`arlas_cli --config-file /tmp/arlas-cli.yaml  iam --config local.iam.admin orgs groups ${ORGID} | grep 'group/config.json/org.com' | awk -F '\|' '{print $2}' | xargs`
    BUILDER_GROUP_ID=`arlas_cli --config-file /tmp/arlas-cli.yaml  iam --config local.iam.admin orgs groups ${ORGID} | grep 'role/arlas/builder' | awk -F '\|' '{print $2}' | xargs`
    OWNER_GROUP_ID=`arlas_cli --config-file /tmp/arlas-cli.yaml  iam --config local.iam.admin orgs groups ${ORGID} | grep 'role/arlas/owner' | awk -F '\|' '{print $2}' | xargs`
    DATASET_GROUP_ID=`arlas_cli --config-file /tmp/arlas-cli.yaml  iam --config local.iam.admin orgs groups ${ORGID} | grep 'role/arlas/dataset' | awk -F '\|' '{print $2}' | xargs`
    echo "add user in organisation with role role/arlas/user and group/config.json/org.com"
    arlas_cli --config-file /tmp/arlas-cli.yaml iam --config ${CONF} orgs add_user ${ORGID} user@org.com --group ${USER_ROLE_ID} --group ${SEE_ALL_GROUP_ID} --group ${BUILDER_GROUP_ID} --group ${OWNER_GROUP_ID} --group ${DATASET_GROUP_ID}
    echo "ask to reset password"
    curl -kX POST https://localhost/arlas_iam_server/users/resetpassword -H 'Content-Type: application/json;charset=utf-8' -d "user@org.com"
    echo "fetch token"
    TOKEN=`docker logs arlas-iam-server --tail 100 | grep "Reset token" | tail-1 | awk -F 'token: ' '{print $2}'`
    echo "set password to 'secret'"
    curl -kX POST https://localhost/arlas_iam_server/users/${USERID}/reset/${TOKEN} -H 'Content-Type: application/json;charset=utf-8' -d "secret"
fi

yes|arlas_cli --config-file /tmp/arlas-cli.yaml collections --config ${CONF} delete courses

curl https://raw.githubusercontent.com/gisaia/arlas_cli/master/tests/sample.json -o sample/sample.json
arlas_cli --config-file /tmp/arlas-cli.yaml indices --config ${CONF} mapping sample/sample.json --nb-lines 200 --field-mapping track.timestamps.center:date-epoch_second --field-mapping track.timestamps.start:date-epoch_second --field-mapping track.timestamps.end:date-epoch_second --no-fulltext cargo_type --push-on courses
arlas_cli --config-file /tmp/arlas-cli.yaml indices --config ${CONF} data courses sample/sample.json
arlas_cli --config-file /tmp/arlas-cli.yaml collections --config ${CONF} create courses --index courses --display-name courses --id-path track.id --centroid-path track.location --geometry-path track.trail --date-path track.timestamps.center --no-public --owner org.com
arlas_cli --config-file /tmp/arlas-cli.yaml persist --config ${CONF} add sample/dashboard.json config.json --name "Course Dashboard" --reader "group/config.json/org.com"
