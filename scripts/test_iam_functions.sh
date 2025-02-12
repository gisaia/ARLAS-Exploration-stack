
must_find_keyword(){
    KEYWORD=$1
    if grep "${KEYWORD}" /tmp/test_file; then
        echo "OK"
    else
        echo "TEST FAILED"
        exit 1
    fi
}

must_fail(){
    STATUS_CODE=$1
    if [ "$STATUS_CODE" = 1 ]
    then
        echo "OK"
    else
        echo "TEST FAILED"
        exit 1
    fi
}

must_not_find_keyword(){
    KEYWORD=$1
    if grep "${KEYWORD}" /tmp/test_file; then
        echo "TEST FAILED"
        exit 1
    else
        echo "OK"
    fi
}


add_org(){
    RUN_AS=$1
    ORG_NAME=$2
    RETURNED_ORGID=`arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} iam --config ${RUN_AS} orgs add ${ORG_NAME}`
}

register_user_in_cli(){
    USER_NAME=$1
    PASSWORD=$2
    ORG_NAME=$3

    if [[ -z "$ORG_NAME" ]]; then
        echo "Register ${USER_NAME} without an organisation"
        arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} confs create ${USER_NAME} \
            --server https://${ARLAS_HOST}/arlas \
            --headers "Content-Type:application/json" \
            --persistence https://${ARLAS_HOST}/persist \
            --persistence-headers "Content-Type:application/json" \
            --elastic http://localhost:9200 \
            --elastic-headers "Content-Type:application/json" \
            --allow-delete  \
            --auth-token-url https://${ARLAS_HOST}/arlas_iam_server/session \
            --auth-headers "Content-Type:application/json" \
            --auth-login ${USER_NAME} \
            --auth-password ${PASSWORD} \
            --auth-arlas-iam 
    else
        echo "Register ${USER_NAME} in organisation ${ORG_NAME}"
        arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} confs create ${USER_NAME} \
            --server https://${ARLAS_HOST}/arlas \
            --headers "Content-Type:application/json" \
            --persistence https://${ARLAS_HOST}/persist \
            --persistence-headers "Content-Type:application/json" \
            --elastic http://localhost:9200 \
            --elastic-headers "Content-Type:application/json" \
            --allow-delete  \
            --auth-token-url https://${ARLAS_HOST}/arlas_iam_server/session \
            --auth-headers "Content-Type:application/json" \
            --auth-login ${USER_NAME} \
            --auth-org ${ORG_NAME} \
            --auth-password ${PASSWORD} \
            --auth-arlas-iam 
    fi
}

create_user(){
    RUN_AS=$1
    USER_NAME=$2
    echo "Create user "$USER_NAME
    RETURNED_USERID=`arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} iam --config ${RUN_AS} users add ${USER_NAME}`
    echo ${USER_NAME}"="${RETURNED_USERID}
    echo "Ask to reset password"
    curl -kX POST https://localhost/arlas_iam_server/users/resetpassword -H 'Content-Type: application/json;charset=utf-8' -d $USER_NAME
    echo "Fetch token"
    TOKEN=`docker logs arlas-iam-server --tail 100 | grep "Reset token" | tail -1 | awk -F 'token: ' '{print $2}'`
    echo "Set password to 'secret' with TOKEN "${TOKEN}
    curl -kX POST https://localhost/arlas_iam_server/users/${RETURNED_USERID}/reset/${TOKEN} -H 'Content-Type: application/json;charset=utf-8' -d "secret"
}

add_user_to_org(){
    RUN_AS=$1
    USER_NAME=$2
    ORGID=$3
    ORG_NAME=$4
    USER_ONLY=$5
    echo "Add user "$USER_NAME" in organisation id "$ORGID
    echo "Extract roles and group ids"
    GROUPS_PARAMS='--reader group/config.json/'${ORG_NAME}' --writer group/config.json/'${ORG_NAME}
    USER_ROLE_ID=`arlas_cli --config-file ${ARLAS_CLI_CONF_FILE}  iam --config ${RUN_AS} orgs groups ${ORGID} | grep role/arlas/user | awk -F '\|' '{print $2}' | xargs`
    SEE_ALL_GROUP_ID=`arlas_cli --config-file ${ARLAS_CLI_CONF_FILE}  iam --config ${RUN_AS} orgs groups ${ORGID} | grep 'group/config.json/'${ORG_NAME} | awk -F '\|' '{print $2}' | xargs`
    BUILDER_GROUP_ID=`arlas_cli --config-file ${ARLAS_CLI_CONF_FILE}  iam --config ${RUN_AS} orgs groups ${ORGID} | grep 'role/arlas/builder' | awk -F '\|' '{print $2}' | xargs`
    OWNER_GROUP_ID=`arlas_cli --config-file ${ARLAS_CLI_CONF_FILE}  iam --config ${RUN_AS} orgs groups ${ORGID} | grep 'role/arlas/owner' | awk -F '\|' '{print $2}' | xargs`
    DATASET_GROUP_ID=`arlas_cli --config-file ${ARLAS_CLI_CONF_FILE}  iam --config ${RUN_AS} orgs groups ${ORGID} | grep 'role/arlas/dataset' | awk -F '\|' '{print $2}' | xargs`
    echo "Add user in organisation with role role/arlas/user and group/config.json/"${ORG_NAME}
    if [ ${USER_ONLY} == "True" ]; then
        arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} iam --config ${RUN_AS} orgs add_user ${ORGID} ${USER_NAME} --group ${USER_ROLE_ID} --group ${SEE_ALL_GROUP_ID}
    else
        arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} iam --config ${RUN_AS} orgs add_user ${ORGID} ${USER_NAME} --group ${USER_ROLE_ID} --group ${SEE_ALL_GROUP_ID} --group ${BUILDER_GROUP_ID} --group ${OWNER_GROUP_ID} --group ${DATASET_GROUP_ID}
    fi
}

remove_user_from_org(){
    RUN_AS=$1
    USER_NAME=$2
    ORGID=$3
    ORG_NAME=$4
    arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} iam --config ${RUN_AS} orgs delete_user ${ORGID} ${USER_NAME}
}


add_data_collection_and_dashboard(){
    RUN_AS=$1
    ORG_NAME=$2
    DATA_NAME=$3
    ISPUBLIC=$4
    echo "Create mapping for ${DATA_NAME} in ${ORG_NAME}"
    arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} indices --config ${RUN_AS} mapping sample/sample.json --nb-lines 200 --field-mapping track.timestamps.center:date-epoch_second --field-mapping track.timestamps.start:date-epoch_second --field-mapping track.timestamps.end:date-epoch_second --no-fulltext cargo_type --push-on ${ORG_NAME}@${DATA_NAME}
    echo "Index ${DATA_NAME}"
    arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} indices --config ${RUN_AS} data ${ORG_NAME}@${DATA_NAME} sample/sample.json
    echo "Create ${DATA_NAME} collection"
    arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} collections --config ${RUN_AS} create ${DATA_NAME} --index ${ORG_NAME}@${DATA_NAME} --display-name ${DATA_NAME} --id-path track.id --centroid-path track.location --geometry-path track.trail --date-path track.timestamps.center $ISPUBLIC --owner ${ORG_NAME} --orgs ${ORG_NAME}
    echo "Create dashboard"
    export ARLAS_SERVER_URL=http://$ARLAS_HOST
    export COLLECTION=$DATA_NAME
    envsubst '$ARLAS_SERVER_URL' < sample/dashboard.json > sample/dashboard.generated.json
    envsubst '$COLLECTION' < sample/dashboard.generated.json > sample/dashboard.generated2.json
    arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} persist --config ${RUN_AS} add sample/dashboard.generated2.json config.json --name "Course Dashboard" $GROUPS_PARAMS
}
