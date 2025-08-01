ARLAS_HOST=172.18.0.3
ES_HOST=172.18.0.4

arlas_cli --config-file /tmp/arlas-cli.yaml confs delete local.k8s.kc.data

arlas_cli --config-file /tmp/arlas-cli.yaml \
    confs create local.k8s.kc.data \
    --server http://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence http://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic https://${ES_HOST}:9200 \
    --elastic-login elastic \
    --elastic-password secret4elastic \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete \
    --auth-grant-type password \
    --auth-client-id arlas-front \
    --auth-token-url http://${ARLAS_HOST}/auth/realms/arlas/protocol/openid-connect/token \
    --auth-headers "Content-Type:application/x-www-form-urlencoded" \
    --auth-login user_all_roles \
    --auth-password secret \
    --auth-org "" \
    --no-auth-arlas-iam

export USER_CONF=local.k8s.kc.data
arlas_cli --print-curl --config-file /tmp/arlas-cli.yaml indices --config ${USER_CONF} mapping sample/sample.json --nb-lines 200 --field-mapping track.timestamps.center:date-epoch_second --field-mapping track.timestamps.start:date-epoch_second --field-mapping track.timestamps.end:date-epoch_second --no-fulltext cargo_type --push-on org.com@courses
arlas_cli --config-file /tmp/arlas-cli.yaml indices --config ${USER_CONF} data org.com@courses sample/sample.json
arlas_cli --print-curl --config-file /tmp/arlas-cli.yaml collections --config ${USER_CONF} create courses --index org.com@courses --display-name courses --id-path track.id --centroid-path track.location --geometry-path track.trail --date-path track.timestamps.center --no-public --owner org.com --orgs org.com
