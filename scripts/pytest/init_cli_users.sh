
#!/bin/bash
set -o errexit -o pipefail

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

ARLAS_HOST=localhost
ARLAS_CLI_CONF_FILE=/tmp/arlas-cli-tests.yaml
rm $ARLAS_CLI_CONF_FILE

arlas_cli --config-file $ARLAS_CLI_CONF_FILE --version

register_user_in_cli tech@gisaia.com admin

register_user_in_cli user1@org1.com secret org1.com
register_user_in_cli user2@org1.com secret org1.com

register_user_in_cli user1@org2.com secret org2.com
register_user_in_cli user2@org2.com secret org2.com

register_user_in_cli orphan@org.com secret ""
register_user_in_cli orphan2@org.com secret org1.com
register_user_in_cli orphan3@org.com secret org2.com


arlas_cli --config-file ${ARLAS_CLI_CONF_FILE} confs create anonymous \
    --server https://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence https://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete  \
    --auth-headers "Content-Type:application/json" \
    --no-auth-arlas-iam
