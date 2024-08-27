## File: dc/ref-dc-aias-airs.yaml
### Service: airs-server
Image: `ARLAS_VERSION_AIRS` with `gisaia/airs:0.3.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `AIRS_COLLECTION_URL` | `${AIRS_COLLECTION_URL:-https://raw.githubuserconte ...` | `` |  |  |
| `AIRS_CORS_HEADERS` | `${AIRS_CORS_HEADERS:-*}` | `` |  |  |
| `AIRS_CORS_METHODS` | `${AIRS_CORS_METHODS:-*}` | `` |  |  |
| `AIRS_CORS_ORIGINS` | `${AIRS_CORS_ORIGINS:-*}` | `` |  |  |
| `AIRS_HOST` | `${AIRS_HOST:-0.0.0.0}` | `` |  |  |
| `AIRS_INDEX_COLLECTION_PREFIX` | `${AIRS_INDEX_COLLECTION_PREFIX:-airs}` | `` |  |  |
| `AIRS_INDEX_ENDPOINT_URL` | `${AIRS_INDEX_ENDPOINT_URL}` | `` |  | `http://elasticsearch:9200` in `conf/aias.env` |
| `AIRS_INDEX_LOGIN` | `${ELASTIC_USER}` | `` |  | `elastic` in `conf/elastic.env` |
| `AIRS_INDEX_PWD` | `${ELASTIC_PASSWORD}` | `` |  | `elastic` in `conf/elastic.env` |
| `AIRS_LOGGER_LEVEL` | `${AIRS_LOGGER_LEVEL}` | `` |  | `INFO` in `conf/aias.env` |
| `AIRS_MAPPING_URL` | `${AIRS_MAPPING_URL:-/app/conf/mapping.json}` | `` |  |  |
| `AIRS_PORT` | `${AIRS_PORT:-8000}` | `` |  |  |
| `AIRS_PREFIX` | `${AIRS_PREFIX:-/airs}` | `` |  |  |
| `AIRS_S3_ACCESS_KEY_ID` | `${AIRS_S3_ACCESS_KEY_ID}` | `` |  | `airs` in `conf/aias.env` |
| `AIRS_S3_ASSET_HTTP_ENDPOINT_URL` | `${AIRS_S3_ASSET_HTTP_ENDPOINT_URL}` | `` |  | `http://minio:9000/{}/{}` in `conf/aias.env` |
| `AIRS_S3_BUCKET` | `${AIRS_S3_BUCKET:-airs-storage}` | `` |  | `airs` in `conf/aias.env` |
| `AIRS_S3_ENDPOINT_URL` | `${AIRS_S3_ENDPOINT_URL:-http://minio:9000}` | `` |  | `http://minio:9000` in `conf/aias.env` |
| `AIRS_S3_PLATFORM` | `${AIRS_S3_PLATFORM:-MINIO}` | `` |  |  |
| `AIRS_S3_REGION` | `${AIRS_S3_REGION:-Standart}` | `` |  |  |
| `AIRS_S3_SECRET_ACCESS_KEY` | `${AIRS_S3_SECRET_ACCESS_KEY}` | `` |  | `airssecret` in `conf/aias.env` |
| `AIRS_S3_TIER` | `${AIRS_S3_TIER:-Standard}` | `` |  |  |
| `ELASTIC_APM_APPLICATION_PACKAGES` | `io.arlas` | `` |  | None |
| `ELASTIC_APM_ENVIRONMENT` | `${ELASTIC_APM_ENVIRONMENT}` | `` |  | `ARLAS` in `conf/elastic.env` |
| `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `${ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST:-*}` | `` |  |  |
| `ELASTIC_APM_LOG_ECS_REFORMATTING` | `${ELASTIC_APM_LOG_ECS_REFORMATTING:-OVERRIDE}` | `` |  |  |
| `ELASTIC_APM_SECRET_TOKEN` | `${ELASTIC_APM_SECRET_TOKEN}` | `` |  | `not_a_secret` in `conf/elastic.env` |
| `ELASTIC_APM_SERVER_URLS` | `${ELASTIC_APM_SERVER_URLS:-http://apm-server:8200}` | `` |  |  |
| `ELASTIC_APM_SERVICE_NAME` | `airs-server` | `` |  | None |
| `ELASTIC_APM_TRANSACTION_IGNORE_USER_AGENTS` | `GoogleHC/*, kube-probe/*, curl*, GoogleStackdriver ...` | `` |  | None |
| `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `${ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME:- ...` | `` |  |  |
## File: dc/ref-dc-aias-aproc-proc.yaml
### Service: aproc-proc
Image: `ARLAS_VERSION_APROC_PROC` with `gisaia/aproc-proc:0.3.5` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APROC_LOGGER_LEVEL` | `${APROC_LOGGER_LEVEL:-INFO}` | `` |  | `INFO` in `conf/aias.env` |
| `APROC_CONFIGURATION_FILE` | `/home/app/worker/conf/aproc.yaml` | `` |  | None |
| `CELERY_BROKER_URL` | `pyamqp://guest:guest@rabbitmq:5672//` | `` |  | None |
| `CELERY_RESULT_BACKEND` | `redis://redis:6379/0` | `` |  | None |
| `AIRS_ENDPOINT` | `http://airs-server:8000/airs` | `` |  | None |
| `APROC_ENDPOINT_FROM_APROC` | `http://aproc-service:8001/aproc` | `` |  | None |
| `ROOT_DIRECTORY` | `/inputs` | `` |  | None |
| `ARLAS_SMTP_ACTIVATED` | `"${ARLAS_SMTP_ACTIVATED:-false}"` | `` |  | `false` in `conf/aias.env`<br>`false` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_HOST` | `"${ARLAS_SMTP_HOST}"` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_PORT` | `"${ARLAS_SMTP_PORT:-25}"` | `` |  | `25` in `conf/aias.env` |
| `ARLAS_SMTP_USERNAME` | `"${ARLAS_SMTP_USERNAME}"` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_PASSWORD` | `"${ARLAS_SMTP_PASSWORD}"` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_FROM` | `"${ARLAS_SMTP_FROM}"` | `` |  | `tobechanged@tobechanged.io` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `APROC_DOWNLOAD_ADMIN_EMAILS` | `"${APROC_DOWNLOAD_ADMIN_EMAILS}"` | `` |  | `"admin@the.boss,someone.else@the.boss"` in `conf/aias.env` |
| `APROC_DOWNLOAD_OUTBOX_DIR` | `"/outbox"` | `` |  | None |
| `APROC_DOWNLOAD_CONTENT_USER` | `${APROC_DOWNLOAD_CONTENT_USER}` | `` |  | `"\"ARLAS Services: Dear {arlas-user-email}. <br>Yo ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_USER` | `${APROC_DOWNLOAD_SUBJECT_USER}` | `` |  | `"\"ARLAS Services: Your download of {collection}/{ ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_CONTENT_ERROR` | `${APROC_DOWNLOAD_CONTENT_ERROR}` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_ERROR` | `${APROC_DOWNLOAD_SUBJECT_ERROR}` | `` |  | `"\"ARLAS Services: ERROR: The download of {collect ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_CONTENT_ADMIN` | `${APROC_DOWNLOAD_CONTENT_ADMIN}` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_ADMIN` | `${APROC_DOWNLOAD_SUBJECT_ADMIN}` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_SUBJECT_USER` | `${APROC_DOWNLOAD_REQUEST_SUBJECT_USER}` | `` |  | `"\"ARLAS Services: Thank you for your download req ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_CONTENT_USER` | `${APROC_DOWNLOAD_REQUEST_CONTENT_USER}` | `` |  | `"\"ARLAS Services: Dear {arlas-user-email}. <br>Yo ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_SUBJECT_ADMIN` | `${APROC_DOWNLOAD_REQUEST_SUBJECT_ADMIN}` | `` |  | `"\"ARLAS Services: {arlas-user-email} requested th ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_CONTENT_ADMIN` | `${APROC_DOWNLOAD_REQUEST_CONTENT_ADMIN}` | `` |  | `"\"ARLAS Services: {arlas-user-email} requested th ...` in `conf/aias.env` |
| `APROC_EMAIL_PATH_PREFIX_ADD` | `${APROC_EMAIL_PATH_PREFIX_ADD}` | `` |  | `"/tmp/"` in `conf/aias.env` |
| `APROC_PATH_TO_WINDOWS` | `${APROC_PATH_TO_WINDOWS}` | `` |  | `false` in `conf/aias.env` |
| `ARLAS_URL_SEARCH` | `${ARLAS_URL_SEARCH}` | `` |  | `"http://arlas-server:9999/arlas/explore/{collectio ...` in `conf/aias.env` |
| `AIRS_INDEX_COLLECTION_PREFIX` | `${AIRS_INDEX_COLLECTION_PREFIX}` | `` |  |  |
| `APROC_INDEX_ENDPOINT_URL` | `http://elasticsearch:9200` | `` |  | None |
| `APROC_INDEX_NAME` | `APROC_INDEX_NAME` | `` |  | `aproc_downloads` in `conf/aias.env` |
| `APROC_RESOURCE_ID_HASH_STARTS_AT` | `3` | `` |  | None |
| `TMP_FOLDER` | `"/outbox"` | `` |  | None |
## File: dc/ref-dc-aias-aproc-service.yaml
### Service: aproc-service
Image: `ARLAS_VERSION_APROC_SERVICE` with `gisaia/aproc-service:0.3.5` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APROC_LOGGER_LEVEL` | `${APROC_LOGGER_LEVEL:-INFO}` | `` |  | `INFO` in `conf/aias.env` |
| `APROC_HOST` | `0.0.0.0` | `` |  | None |
| `APROC_PORT` | `8001` | `` |  | None |
| `APROC_PREFIX` | `/aproc` | `` |  | None |
| `APROC_CONFIGURATION_FILE` | `/app/conf/aproc.yaml` | `` |  | None |
| `CELERY_BROKER_URL` | `pyamqp://guest:guest@rabbitmq:5672//` | `` |  | None |
| `CELERY_RESULT_BACKEND` | `redis://redis:6379/0` | `` |  | None |
| `AIRS_ENDPOINT` | `http://airs-server:8000/airs` | `` |  | None |
| `ARLAS_SMTP_ACTIVATED` | `"${ARLAS_SMTP_ACTIVATED:-false}"` | `` |  | `false` in `conf/aias.env`<br>`false` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_HOST` | `"${ARLAS_SMTP_HOST}"` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_PORT` | `"${ARLAS_SMTP_PORT:-25}"` | `` |  | `25` in `conf/aias.env` |
| `ARLAS_SMTP_USERNAME` | `"${ARLAS_SMTP_USERNAME}"` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_PASSWORD` | `"${ARLAS_SMTP_PASSWORD}"` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_FROM` | `"${ARLAS_SMTP_FROM}"` | `` |  | `tobechanged@tobechanged.io` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `APROC_DOWNLOAD_ADMIN_EMAILS` | `"${APROC_DOWNLOAD_ADMIN_EMAILS}"` | `` |  | `"admin@the.boss,someone.else@the.boss"` in `conf/aias.env` |
| `APROC_DOWNLOAD_OUTBOX_DIR` | `"/outbox"` | `` |  | None |
| `APROC_DOWNLOAD_CONTENT_USER` | `${APROC_DOWNLOAD_CONTENT_USER}` | `` |  | `"\"ARLAS Services: Dear {arlas-user-email}. <br>Yo ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_USER` | `${APROC_DOWNLOAD_SUBJECT_USER}` | `` |  | `"\"ARLAS Services: Your download of {collection}/{ ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_CONTENT_ERROR` | `${APROC_DOWNLOAD_CONTENT_ERROR}` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_ERROR` | `${APROC_DOWNLOAD_SUBJECT_ERROR}` | `` |  | `"\"ARLAS Services: ERROR: The download of {collect ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_CONTENT_ADMIN` | `${APROC_DOWNLOAD_CONTENT_ADMIN}` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_ADMIN` | `${APROC_DOWNLOAD_SUBJECT_ADMIN}` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_SUBJECT_USER` | `${APROC_DOWNLOAD_REQUEST_SUBJECT_USER}` | `` |  | `"\"ARLAS Services: Thank you for your download req ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_CONTENT_USER` | `${APROC_DOWNLOAD_REQUEST_CONTENT_USER}` | `` |  | `"\"ARLAS Services: Dear {arlas-user-email}. <br>Yo ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_SUBJECT_ADMIN` | `${APROC_DOWNLOAD_REQUEST_SUBJECT_ADMIN}` | `` |  | `"\"ARLAS Services: {arlas-user-email} requested th ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_CONTENT_ADMIN` | `${APROC_DOWNLOAD_REQUEST_CONTENT_ADMIN}` | `` |  | `"\"ARLAS Services: {arlas-user-email} requested th ...` in `conf/aias.env` |
| `APROC_EMAIL_PATH_PREFIX_ADD` | `${APROC_EMAIL_PATH_PREFIX_ADD}` | `` |  | `"/tmp/"` in `conf/aias.env` |
| `APROC_PATH_TO_WINDOWS` | `${APROC_PATH_TO_WINDOWS}` | `` |  | `false` in `conf/aias.env` |
| `ARLAS_URL_SEARCH` | `${ARLAS_URL_SEARCH}` | `` |  | `"http://arlas-server:9999/arlas/explore/{collectio ...` in `conf/aias.env` |
| `AIRS_INDEX_COLLECTION_PREFIX` | `${AIRS_INDEX_COLLECTION_PREFIX}` | `` |  |  |
| `APROC_INDEX_ENDPOINT_URL` | `http://elasticsearch:9200` | `` |  | None |
| `APROC_INDEX_NAME` | `APROC_INDEX_NAME` | `` |  | `aproc_downloads` in `conf/aias.env` |
| `APROC_RESOURCE_ID_HASH_STARTS_AT` | `3` | `` |  | None |
## File: dc/ref-dc-aias-fam-wui.yaml
### Service: arlas-fam-wui
Image: `ARLAS_VERSION_FAM_WUI` with `gisaia/arlas-fam-wui:0.3.5` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `FAM_WUI_BASE_HREF` | `/fam-wui` | `` |  | None |
| `ARLAS_USE_AUTHENT` | `true` | `` |  | None |
| `ARLAS_AUTHENT_MODE` | `iam` | `` |  | None |
| `ARLAS_IAM_SERVER_URL` | `https://${ARLAS_HOST}/arlas_iam_server` | `` |  | `localhost` in `conf/aias.env` |
| `ARLAS_AUTHENT_THRESHOLD` | `60000` | `` |  | None |
| `ARLAS_TAB_NAME` | `"ARLAS FAM Wui"` | `` |  | None |
| `FAM_SERVER_URL` | `https://${ARLAS_HOST}/fam` | `` |  | `localhost` in `conf/aias.env` |
| `FAM_DEFAULT_PATH` | `''` | `` |  | None |
| `FAM_COLLECTION` | `${AIAS_COLLECTION_NAME}` | `` |  |  |
| `APROC_SERVER_URL` | `https://${ARLAS_HOST}/aproc` | `` |  | `localhost` in `conf/aias.env` |
| `APROC_COLLECTION` | `${AIAS_COLLECTION_NAME}` | `` |  |  |
| `APROC_CATALOG` | `${AIAS_CATALOG_NAME}` | `` |  |  |
| `AIRS_SERVER_URL` | `https://${ARLAS_HOST}/airs` | `` |  | `localhost` in `conf/aias.env` |
| `AIRS_COLLECTION` | `${AIAS_COLLECTION_NAME}` | `` |  |  |
| `ARLAS_STATIC_LINKS` | `${ARLAS_FAM_LINKS}` | `` |  |  |
## File: dc/ref-dc-aias-fam.yaml
### Service: fam-service
Image: `ARLAS_VERSION_FAM` with `gisaia/fam:0.3.5` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `FAM_LOGGER_LEVEL` | `${FAM_LOGGER_LEVEL:-INFO}` | `` |  |  |
| `FAM_PREFIX` | `/fam` | `` |  | None |
| `INGESTED_FOLDER` | `/inputs` | `` |  | None |
| `APROC_RESOURCE_ID_HASH_STARTS_AT` | `3` | `` |  | None |
## File: dc/ref-dc-aias-minio-init.yaml
### Service: createbuckets
Image: `ARLAS_VERSION_MINIO_MC` with `minio/mc:RELEASE.2024-04-29T09-56-05Z` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `AIRS_S3_BUCKET` | `${AIRS_S3_BUCKET}` | `` |  | `airs` in `conf/aias.env` |
| `MINIO_ROOT_PASSWORD` | `${MINIO_ROOT_PASSWORD}` | `` |  | empty value in `conf/minio.env` |
| `MINIO_ROOT_USER` | `${MINIO_ROOT_USER}` | `` |  |  |
## File: dc/ref-dc-aias-minio.yaml
### Service: minio
Image: `ARLAS_VERSION_MINIO` with `minio/minio:RELEASE.2024-05-01T01-11-10Z` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `MINIO_BROWSER` | `off` | `` |  | None |
| `MINIO_ROOT_PASSWORD` | `${MINIO_ROOT_PASSWORD}` | `` |  | empty value in `conf/minio.env` |
| `MINIO_ROOT_USER` | `${MINIO_ROOT_USER}` | `` |  |  |
## File: dc/ref-dc-aias-rabbitmq.yaml
### Service: rabbitmq
Image: `ARLAS_VERSION_RABBITMQ` with `rabbitmq:3.13.2-management-alpine` in `conf/versions.env`

## File: dc/ref-dc-aias-redis.yaml
### Service: redis
Image: `ARLAS_VERSION_REDIS` with `redis/redis-stack:7.2.0-v10` in `conf/versions.env`

## File: dc/ref-dc-aias-volumes.yaml
## File: dc/ref-dc-apisix-ssl.yaml
### Service: apisix

## File: dc/ref-dc-apisix.yaml
### Service: apisix
Image: `APISIX_VERSION` with `apache/apisix:3.8.0-debian` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APISIX_STAND_ALONE` | `${APISIX_STAND_ALONE:-true}` | `` |  | `true` in `conf/apisix.env` |
## File: dc/ref-dc-apm.yaml
### Service: apm-server
Image: `APM_VERSION` with `docker.elastic.co/apm/apm-server:8.9.2` in `conf/versions.env`

## File: dc/ref-dc-arlas-builder.yaml
### Service: arlas-builder
Image: `ARLAS_BUILDER_VERSION` with `gisaia/arlas-wui-builder:25.1.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `${ARLAS_AUTHENT_CLEAR_HASH:-true}` | `` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `${ARLAS_AUTHENT_CLIENT_ID:-}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `${ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK:-true}` | `` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `${ARLAS_AUTHENT_ENABLE_SESSION_CHECKS:-true}` | `` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `${ARLAS_AUTHENT_FORCE_CONNECT}` | `` |  | `false` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_ISSUER` | `${ARLAS_AUTHENT_ISSUER}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_LOGIN_URL` | `${ARLAS_AUTHENT_LOGIN_URL}` | `` |  | `https://localhost/hub/login` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_LOGOUT_URL` | `${ARLAS_AUTHENT_LOGOUT_URL}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_MODE` | `${ARLAS_AUTHENT_MODE}` | `` |  | `iam` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `${ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REDIRECT_URI` | `${ARLAS_AUTHENT_REDIRECT_URI:-/wui/callback}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `${ARLAS_AUTHENT_REQUIRE_HTTPS:-false}` | `` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `${ARLAS_AUTHENT_RESPONSE_TYPE:-code}` | `` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `${ARLAS_AUTHENT_SCOPE:-profile}` | `` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `${ARLAS_AUTHENT_SHOW_DEBUG:-false}` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `${ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI}` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `${ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT:-10000}` | `` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `${ARLAS_AUTHENT_STORAGE:-memorystorage}` | `` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `${ARLAS_AUTHENT_THRESHOLD}` | `` |  | `60000` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `${ARLAS_AUTHENT_TIMEOUT_FACTOR:-0.75}` | `` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `${ARLAS_AUTHENT_USE_DISCOVERY}` | `` |  | `true` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_BASEMAPS` | `${ARLAS_BASEMAPS:-[{"name":"Empty","url":"/styles/ ...` | `` |  | `'[` in `conf/arlas.env` |
| `ARLAS_BASEMAPS` | `[{"name":"Streets-light","url":"https://api.maptil ...` | `` |  | None |
| `ARLAS_BUILDER_BASE_HREF` | `${ARLAS_BUILDER_BASE_HREF:-/builder}` | `` |  |  |
| `ARLAS_EXTERNAL_NODE_PAGE` | `${ARLAS_EXTERNAL_NODE_PAGE:-true}` | `` |  |  |
| `ARLAS_IAM_SERVER_URL` | `${ARLAS_IAM_SERVER_URL:-/arlas_iam_server}` | `` |  |  |
| `ARLAS_PERMISSIONS_URL` | `${ARLAS_PERMISSIONS_URL:-/arlas_permissions_server ...` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_PERSISTENCE_URL` | `${ARLAS_PERSISTENCE_URL:-/arlas_persistence_server ...` | `` |  | `https://localhost/persist` in `conf/arlas_iam.env`<br>`/persist` in `conf/persistence-file.env` |
| `ARLAS_SERVER_URL` | `${ARLAS_SERVER_URL:-/arlas}` | `` |  | `https://localhost/arlas` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `${ARLAS_USE_AUTHENT}` | `` |  | `true` in `conf/arlas_iam.env`<br>`false` in `conf/arlas_keycloak.env` |
| `ARLAS_WUI_URL` | `${ARLAS_WUI_URL:-/wui/}` | `` |  | `https://localhost/wui/` in `conf/arlas_iam.env` |
## File: dc/ref-dc-arlas-hub.yaml
### Service: arlas-hub
Image: `ARLAS_HUB_VERSION` with `gisaia/arlas-wui-hub:25.1.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `${ARLAS_AUTHENT_CLEAR_HASH:-true}` | `` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `${ARLAS_AUTHENT_CLIENT_ID:-}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `${ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK:-true}` | `` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `${ARLAS_AUTHENT_ENABLE_SESSION_CHECKS:-true}` | `` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `false` | `` |  ${ARLAS_AUTHENT_FORCE_CONNECT} | None |
| `ARLAS_AUTHENT_ISSUER` | `${ARLAS_AUTHENT_ISSUER}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_LOGOUT_URL` | `${ARLAS_AUTHENT_LOGOUT_URL}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_MODE` | `${ARLAS_AUTHENT_MODE}` | `` |  | `iam` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REDIRECT_URI` | `${ARLAS_AUTHENT_REDIRECT_URI}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `${ARLAS_AUTHENT_REQUIRE_HTTPS:-false}` | `` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `${ARLAS_AUTHENT_RESPONSE_TYPE}` | `` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `${ARLAS_AUTHENT_SCOPE}` | `` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `${ARLAS_AUTHENT_SHOW_DEBUG:-false}` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `${ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI}` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `${ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT:-10000}` | `` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `${ARLAS_AUTHENT_STORAGE:-memorystorage}` | `` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `${ARLAS_AUTHENT_THRESHOLD}` | `` |  | `60000` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `${ARLAS_AUTHENT_TIMEOUT_FACTOR:-0.75}` | `` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `${ARLAS_AUTHENT_USE_DISCOVERY}` | `` |  | `true` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_BUILDER_URL` | `${ARLAS_BUILDER_URL:-/builder/}` | `` |  | `https://localhost/builder/` in `conf/arlas_iam.env` |
| `ARLAS_HUB_BASE_HREF` | `${ARLAS_HUB_BASE_HREF:-/hub}` | `` |  |  |
| `ARLAS_IAM_SERVER_URL` | `${ARLAS_IAM_SERVER_URL:-/arlas_iam_server}` | `` |  |  |
| `ARLAS_PERMISSIONS_URL` | `${ARLAS_PERMISSIONS_URL:-/arlas_permissions_server ...` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_PERSISTENCE_URL` | `${ARLAS_PERSISTENCE_URL:-/persist}` | `` |  | `https://localhost/persist` in `conf/arlas_iam.env`<br>`/persist` in `conf/persistence-file.env` |
| `ARLAS_USE_AUTHENT` | `${ARLAS_USE_AUTHENT}` | `` |  | `true` in `conf/arlas_iam.env`<br>`false` in `conf/arlas_keycloak.env` |
| `ARLAS_WUI_URL` | `${ARLAS_WUI_URL:-/wui/}` | `` |  | `https://localhost/wui/` in `conf/arlas_iam.env` |
## File: dc/ref-dc-arlas-permissions-server.yaml
### Service: arlas-permissions-server
Image: `ARLAS_PERMISSIONS_VERSION` with `gisaia/arlas-permissions-server:25.0.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `${ARLAS_AUTH_POLICY_CLASS:-io.arlas.filter.impl.No ...` | `` |  | `io.arlas.filter.impl.HTTPPolicyEnforcer` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `"${ARLAS_AUTH_PERMISSION_URL}"` | `` |  | `http://arlas-iam-server:9998/arlas_iam_server/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_ENABLED` | `${ARLAS_AUTH_ENABLED:-false}` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_PERMISSIONS_APP_PATH` | `/` | `` |  | None |
| `ARLAS_PERMISSIONS_PREFIX` | `/arlas_permissions_server` | `` |  | None |
| `ARLAS_CACHE_TIMEOUT` | `"${ARLAS_CACHE_TIMEOUT:-5}"` | `` |  |  |
| `ARLAS_PERMISSIONS_LOGGING_CONSOLE_LEVEL` | `"${ARLAS_PERMISSIONS_LOGGING_CONSOLE_LEVEL}"` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_PERMISSIONS_LOGGING_LEVEL` | `"${ARLAS_PERMISSIONS_LOGGING_LEVEL}"` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_PERMISSIONS_PORT` | `"${ARLAS_PERMISSIONS_PORT:-9996}"` | `` |  |  |
| `ELASTIC_APM_APPLICATION_PACKAGES` | `io.arlas` | `` |  | None |
| `ELASTIC_APM_ENVIRONMENT` | `${ELASTIC_APM_ENVIRONMENT}` | `` |  | `ARLAS` in `conf/elastic.env` |
| `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `${ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST:-*}` | `` |  |  |
| `ELASTIC_APM_LOG_ECS_REFORMATTING` | `${ELASTIC_APM_LOG_ECS_REFORMATTING:-OVERRIDE}` | `` |  |  |
| `ELASTIC_APM_SECRET_TOKEN` | `${ELASTIC_APM_SECRET_TOKEN}` | `` |  | `not_a_secret` in `conf/elastic.env` |
| `ELASTIC_APM_SERVER_URLS` | `${ELASTIC_APM_SERVER_URLS:-http://apm-server:8200}` | `` |  |  |
| `ELASTIC_APM_SERVICE_NAME` | `arlas-permission-server` | `` |  | None |
| `ELASTIC_APM_TRANSACTION_IGNORE_USER_AGENTS` | `GoogleHC/*, kube-probe/*, curl*, GoogleStackdriver ...` | `` |  | None |
| `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `${ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME:- ...` | `` |  |  |
| `JDK_JAVA_OPTIONS` | `${ARLAS_PERMISSIONS_JDK_JAVA_OPTIONS}` | `` |  | empty value in `conf/permissions.env` |
## File: dc/ref-dc-arlas-persistence-server.yaml
### Service: arlas-persistence-server
Image: `ARLAS_PERSISTENCE_VERSION` with `gisaia/arlas-persistence-server:25.0.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `${ARLAS_AUTH_POLICY_CLASS:-io.arlas.filter.impl.No ...` | `` |  | `io.arlas.filter.impl.HTTPPolicyEnforcer` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_ENABLED` | `${ARLAS_AUTH_ENABLED:-false}` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `${ARLAS_AUTH_PERMISSION_URL:-}` | `` |  | `http://arlas-iam-server:9998/arlas_iam_server/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_CACHE_TIMEOUT` | `${ARLAS_CACHE_TIMEOUT:-5}` | `` |  |  |
| `ARLAS_PERSISTENCE_APP_PATH` | `${ARLAS_PERSISTENCE_APP_PATH:-/}` | `` |  |  |
| `ARLAS_PERSISTENCE_ENGINE` | `${ARLAS_PERSISTENCE_ENGINE:-hibernate}` | `` |  | `file` in `conf/persistence-file.env` |
| `ARLAS_PERSISTENCE_HIBERNATE_PASSWORD` | `${POSTGRES_PASSWORD}` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `ARLAS_PERSISTENCE_HIBERNATE_URL` | `${ARLAS_PERSISTENCE_HIBERNATE_URL:-jdbc:postgresql ...` | `` |  |  |
| `ARLAS_PERSISTENCE_HIBERNATE_USER` | `${POSTGRES_USER}` | `` |  | `pg-user` in `conf/postgres.env` |
| `ARLAS_PERSISTENCE_LOCAL_FOLDER` | `/persist/` | `` |  | None |
| `ARLAS_PERSISTENCE_LOGGING_CONSOLE_LEVEL` | `${ARLAS_PERSISTENCE_LOGGING_CONSOLE_LEVEL}` | `` |  | `INFO` in `conf/persistence-file.env`<br>empty value in `conf/persistence-postgres.env` |
| `ARLAS_PERSISTENCE_LOGGING_LEVEL` | `${ARLAS_PERSISTENCE_LOGGING_LEVEL}` | `` |  | `INFO` in `conf/persistence-file.env`<br>empty value in `conf/persistence-postgres.env` |
| `ARLAS_PERSISTENCE_PORT` | `${ARLAS_PERSISTENCE_PORT:-9997}` | `` |  |  |
| `ARLAS_PERSISTENCE_PREFIX` | `${ARLAS_PERSISTENCE_PREFIX:-/arlas-persistence-ser ...` | `` |  | `/persist` in `conf/persistence-file.env` |
| `ELASTIC_APM_APPLICATION_PACKAGES` | `io.arlas` | `` |  | None |
| `ELASTIC_APM_ENVIRONMENT` | `${ELASTIC_APM_ENVIRONMENT}` | `` |  | `ARLAS` in `conf/elastic.env` |
| `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `${ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST:-*}` | `` |  |  |
| `ELASTIC_APM_LOG_ECS_REFORMATTING` | `${ELASTIC_APM_LOG_ECS_REFORMATTING:-OVERRIDE}` | `` |  |  |
| `ELASTIC_APM_SECRET_TOKEN` | `${ELASTIC_APM_SECRET_TOKEN}` | `` |  | `not_a_secret` in `conf/elastic.env` |
| `ELASTIC_APM_SERVER_URLS` | `${ELASTIC_APM_SERVER_URLS:-http://apm-server:8200}` | `` |  |  |
| `ELASTIC_APM_SERVICE_NAME` | `arlas-persistence-server` | `` |  | None |
| `ELASTIC_APM_TRANSACTION_IGNORE_USER_AGENTS` | `GoogleHC/*, kube-probe/*, curl*, GoogleStackdriver ...` | `` |  | None |
| `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `${ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME:- ...` | `` |  |  |
| `JDK_JAVA_OPTIONS` | `${ARLAS_PERSISTENCE_JDK_JAVA_OPTIONS}` | `` |  | empty value in `conf/persistence-postgres.env` |
## File: dc/ref-dc-arlas-server-es-ssl.yaml
### Service: arlas-server
Image: `ARLAS_SERVER_VERSION` with `gisaia/arlas-server:25.1.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_APP_PATH` | `/` | `` |  | None |
| `ARLAS_BASE_URI` | `"${ARLAS_BASE_URI:-http://arlas-server:9999/arlas/ ...` | `` |  |  |
| `ARLAS_CACHE_TIMEOUT` | `"${ARLAS_CACHE_TIMEOUT:-5}"` | `` |  |  |
| `ARLAS_CORS_ALLOWED_HEADERS` | `"arlas-user,arlas-groups,arlas-organization,X-Requ ...` | `` |  | None |
| `ARLAS_CORS_ENABLED` | `"${ARLAS_CORS_ENABLED:-true}"` | `` |  |  |
| `ARLAS_ELASTIC_CLUSTER` | `${ARLAS_ELASTIC_CLUSTER:-arlas-es-cluster}` | `` |  |  |
| `ARLAS_ELASTIC_CREDENTIALS` | `"${ELASTIC_USER}:${ELASTIC_PASSWORD}"` | `` |  |  |
| `ARLAS_ELASTIC_ENABLE_SSL` | `"${ARLAS_ELASTIC_ENABLE_SSL:-true}"` | `` |  |  |
| `ARLAS_ELASTIC_INDEX` | `"${ARLAS_ELASTIC_INDEX:-.arlas}"` | `` |  |  |
| `ARLAS_ELASTIC_NODES` | `${ARLAS_ELASTIC_NODES:-elasticsearch:9200}` | `` |  |  |
| `ARLAS_ELASTIC_SKIP_MASTER` | `"${ARLAS_ELASTIC_SKIP_MASTER:-true}"` | `` |  |  |
| `ARLAS_ELASTIC_SNIFFING` | `${ES_SNIFFING:-false}` | `` |  |  |
| `ARLAS_INSPIRE_ENABLED` | `"${ARLAS_INSPIRE_ENABLED:-false}"` | `` |  |  |
| `ARLAS_LOGGING_CONSOLE_LEVEL` | `"${ARLAS_LOGGING_CONSOLE_LEVEL}"` | `` |  | `INFO` in `conf/arlas.env` |
| `ARLAS_LOGGING_LEVEL` | `"${ARLAS_LOGGING_LEVEL}"` | `` |  | `INFO` in `conf/arlas.env` |
| `ARLAS_PREFIX` | `/arlas` | `` |  | None |
| `ARLAS_SERVICE_CSW_ENABLE` | `"${ARLAS_SERVICE_CSW_ENABLE:-false}"` | `` |  |  |
| `ARLAS_SERVICE_RASTER_TILES_ENABLE` | `"${ARLAS_SERVICE_RASTER_TILES_ENABLE:-false}"` | `` |  |  |
| `ARLAS_SERVICE_WFS_ENABLE` | `"${ARLAS_SERVICE_WFS_ENABLE:-false}"` | `` |  |  |
| `ELASTIC_APM_APPLICATION_PACKAGES` | `io.arlas` | `` |  | None |
| `ELASTIC_APM_ENVIRONMENT` | `${ELASTIC_APM_ENVIRONMENT}` | `` |  | `ARLAS` in `conf/elastic.env` |
| `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `${ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST:-*}` | `` |  |  |
| `ELASTIC_APM_LOG_ECS_REFORMATTING` | `${ELASTIC_APM_LOG_ECS_REFORMATTING:-OVERRIDE}` | `` |  |  |
| `ELASTIC_APM_SECRET_TOKEN` | `${ELASTIC_APM_SECRET_TOKEN}` | `` |  | `not_a_secret` in `conf/elastic.env` |
| `ELASTIC_APM_SERVER_URLS` | `${ELASTIC_APM_SERVER_URLS:-http://apm-server:8200}` | `` |  |  |
| `ELASTIC_APM_SERVICE_NAME` | `arlas-server` | `` |  | None |
| `ELASTIC_APM_TRANSACTION_IGNORE_USER_AGENTS` | `GoogleHC/*, kube-probe/*, curl*, GoogleStackdriver ...` | `` |  | None |
| `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `${ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME:- ...` | `` |  |  |
| `JDK_JAVA_OPTIONS` | `${ARLAS_SERVER_JDK_JAVA_OPTIONS}` | `` |  |  |
## File: dc/ref-dc-arlas-server.yaml
### Service: arlas-server
Description: a comment

Image: `ARLAS_SERVER_VERSION` with `gisaia/arlas-server:25.1.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `${ARLAS_AUTH_POLICY_CLASS:-io.arlas.filter.impl.No ...` | `` |  | `io.arlas.filter.impl.HTTPPolicyEnforcer` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `"${ARLAS_AUTH_PERMISSION_URL}"` | `` |  | `http://arlas-iam-server:9998/arlas_iam_server/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_APP_PATH` | `/` | `` |  | None |
| `ARLAS_BASE_URI` | `ARLAS_BASE_URI` | `http://arlas-server:9999/arlas/` |  Arlas base uri |  |
| `ARLAS_CACHE_TIMEOUT` | `"${ARLAS_CACHE_TIMEOUT:-5}"` | `` |  |  |
| `ARLAS_CORS_ALLOWED_HEADERS` | `"arlas-user,arlas-groups,arlas-organization,X-Requ ...` | `` |  | None |
| `ARLAS_CORS_ENABLED` | `"${ARLAS_CORS_ENABLED:-true}"` | `` |  |  |
| `ARLAS_ELASTIC_CLUSTER` | `${ARLAS_ELASTIC_CLUSTER:-arlas-es-cluster}` | `` |  |  |
| `ARLAS_ELASTIC_ENABLE_SSL` | `false` | `` |  | None |
| `ARLAS_ELASTIC_INDEX` | `"${ARLAS_ELASTIC_INDEX:-.arlas}"` | `` |  |  |
| `ARLAS_ELASTIC_NODES` | `${ARLAS_ELASTIC_NODES:-elasticsearch:9200}` | `` |  |  |
| `ARLAS_ELASTIC_SKIP_MASTER` | `"${ARLAS_ELASTIC_SKIP_MASTER:-true}"` | `` |  |  |
| `ARLAS_ELASTIC_SNIFFING` | `${ES_SNIFFING:-false}` | `` |  |  |
| `ARLAS_INSPIRE_ENABLED` | `"${ARLAS_INSPIRE_ENABLED:-false}"` | `` |  |  |
| `ARLAS_LOGGING_CONSOLE_LEVEL` | `"${ARLAS_LOGGING_CONSOLE_LEVEL}"` | `` |  | `INFO` in `conf/arlas.env` |
| `ARLAS_LOGGING_LEVEL` | `"${ARLAS_LOGGING_LEVEL}"` | `` |  | `INFO` in `conf/arlas.env` |
| `ARLAS_PREFIX` | `/arlas` | `` |  | None |
| `ARLAS_SERVICE_CSW_ENABLE` | `"${ARLAS_SERVICE_CSW_ENABLE:-false}"` | `` |  |  |
| `ARLAS_SERVICE_RASTER_TILES_ENABLE` | `"${ARLAS_SERVICE_RASTER_TILES_ENABLE:-false}"` | `` |  |  |
| `ARLAS_SERVICE_WFS_ENABLE` | `"${ARLAS_SERVICE_WFS_ENABLE:-false}"` | `` |  |  |
| `JDK_JAVA_OPTIONS` | `${ARLAS_SERVER_JDK_JAVA_OPTIONS}` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `${ARLAS_AUTH_KEYCLOAK_REALM:-}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `${ARLAS_AUTH_KEYCLOAK_RESOURCE:-}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `${ARLAS_AUTH_KEYCLOAK_SECRET:-}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_URL` | `${ARLAS_AUTH_KEYCLOAK_URL}` | `` |  | empty value in `conf/arlas_keycloak.env` |
## File: dc/ref-dc-arlas-wui.yaml
### Service: arlas-wui
Image: `ARLAS_WUI_VERSION` with `gisaia/arlas-wui:25.1.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `${ARLAS_AUTHENT_CLEAR_HASH:-true}` | `` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `${ARLAS_AUTHENT_CLIENT_ID:-}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `${ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK:-true}` | `` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `${ARLAS_AUTHENT_ENABLE_SESSION_CHECKS:-true}` | `` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `${ARLAS_AUTHENT_FORCE_CONNECT}` | `` |  | `false` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_ISSUER` | `${ARLAS_AUTHENT_ISSUER}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_LOGIN_URL` | `${ARLAS_AUTHENT_LOGIN_URL}` | `` |  | `https://localhost/hub/login` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_LOGOUT_URL` | `${ARLAS_AUTHENT_LOGOUT_URL}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_MODE` | `${ARLAS_AUTHENT_MODE}` | `` |  | `iam` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `${ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REDIRECT_URI` | `${ARLAS_AUTHENT_REDIRECT_URI:-/wui/callback}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `${ARLAS_AUTHENT_REQUIRE_HTTPS:-false}` | `` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `${ARLAS_AUTHENT_RESPONSE_TYPE:-code}` | `` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `${ARLAS_AUTHENT_SCOPE:-profile}` | `` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `${ARLAS_AUTHENT_SHOW_DEBUG:-false}` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `${ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI}` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `${ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT:-10000}` | `` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `${ARLAS_AUTHENT_STORAGE:-memorystorage}` | `` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `${ARLAS_AUTHENT_THRESHOLD}` | `` |  | `60000` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `${ARLAS_AUTHENT_TIMEOUT_FACTOR:-0.75}` | `` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `${ARLAS_AUTHENT_USE_DISCOVERY}` | `` |  | `true` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_GEOCODING_FIND_PLACE_URL` | `${ARLAS_GEOCODING_FIND_PLACE_URL}` | `` |  | empty value in `conf/arlas.env` |
| `ARLAS_GEOCODING_FIND_PLACE_ZOOM_TO` | `${ARLAS_GEOCODING_FIND_PLACE_ZOOM_TO:-10}` | `` |  |  |
| `ARLAS_HUB_URL` | `${ARLAS_HUB_URL:-/hub/}` | `` |  |  |
| `ARLAS_IAM_SERVER_URL` | `${ARLAS_IAM_SERVER_URL:-/arlas_iam_server}` | `` |  |  |
| `ARLAS_PERSISTENCE_URL` | `${ARLAS_PERSISTENCE_URL:-/arlas_persistence_server ...` | `` |  | `https://localhost/persist` in `conf/arlas_iam.env`<br>`/persist` in `conf/persistence-file.env` |
| `ARLAS_USE_AUTHENT` | `${ARLAS_USE_AUTHENT}` | `` |  | `true` in `conf/arlas_iam.env`<br>`false` in `conf/arlas_keycloak.env` |
| `ARLAS_WUI_BASE_HREF` | `${ARLAS_WUI_BASE_HREF:-/wui}` | `` |  |  |
| `PUBLIC_HOST` | `${HOST}` | `` |  | `localhost` in `conf/stack.env` |
## File: dc/ref-dc-elastic-init.yaml
### Service: elasticsearch-setup
Image: `ELASTIC_VERSION` with `docker.elastic.co/elasticsearch/elasticsearch:8.9. ...` in `conf/versions.env`

## File: dc/ref-dc-elastic-ssl.yaml
### Service: elasticsearch
Image: `ELASTIC_VERSION` with `docker.elastic.co/elasticsearch/elasticsearch:8.9. ...` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ELASTIC_PASSWORD` | `${ELASTIC_PASSWORD}` | `` |  | `elastic` in `conf/elastic.env` |
| `APM_SECRET_TOKEN` | `${APM_SECRET_TOKEN}` | `` |  | empty value in `conf/elastic.env` |
| `discovery.type` | `single-node` | `` |  | None |
| `cluster.name` | `arlas-es-cluster` | `` |  | None |
| `node.name` | `arlas-data-node-1` | `` |  | None |
| `ES_JAVA_OPTS` | `${ES_JAVA_OPTS}` | `` |  | `-Xms1g -Xmx1g` in `conf/elastic.env` |
| `xpack.security.enabled` | `true` | `` |  | None |
| `xpack.security.http.ssl.enabled` | `true` | `` |  | None |
| `xpack.security.http.ssl.key` | `certs/elasticsearch/elasticsearch.key` | `` |  | None |
| `xpack.security.http.ssl.certificate` | `certs/elasticsearch/elasticsearch.crt` | `` |  | None |
| `xpack.security.http.ssl.certificate_authorities` | `certs/ca/ca.crt` | `` |  | None |
| `xpack.security.transport.ssl.enabled` | `true` | `` |  | None |
| `xpack.security.transport.ssl.key` | `certs/elasticsearch/elasticsearch.key` | `` |  | None |
| `xpack.security.transport.ssl.certificate` | `certs/elasticsearch/elasticsearch.crt` | `` |  | None |
| `xpack.security.transport.ssl.certificate_authorities` | `certs/ca/ca.crt` | `` |  | None |
| `xpack.security.transport.ssl.verification_mode` | `certificate` | `` |  | None |
| `path.repo` | `/usr/share/elasticsearch/backup` | `` |  | None |
| `tracing.apm.enabled` | `false` | `` |  | None |
## File: dc/ref-dc-elastic.yaml
### Service: elasticsearch
Image: `ELASTIC_VERSION` with `docker.elastic.co/elasticsearch/elasticsearch:8.9. ...` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `discovery.type` | `single-node` | `` |  | None |
| `cluster.name` | `arlas-es-cluster` | `` |  | None |
| `node.name` | `arlas-data-node-1` | `` |  | None |
| `ES_JAVA_OPTS` | `${ES_JAVA_OPTS}` | `` |  | `-Xms1g -Xmx1g` in `conf/elastic.env` |
| `xpack.security.enabled` | `false` | `` |  | None |
| `xpack.security.http.ssl.enabled` | `false` | `` |  | None |
| `xpack.security.transport.ssl.enabled` | `false` | `` |  | None |
| `tracing.apm.enabled` | `false` | `` |  | None |
## File: dc/ref-dc-filebeat.yaml
### Service: filebeat
Image: `FILEBEAT_VERSION` with `docker.elastic.co/beats/filebeat:8.9.2` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `FILEBEAT_ELASTIC_CERT_AUTH` | `"/usr/share/filebeat/certs/ca/ca.crt"` | `` |  | None |
| `FILEBEAT_ELASTIC_CERT` | `"/usr/share/filebeat/certs/elasticsearch-logs/elas ...` | `` |  | None |
| `FILEBEAT_ELASTIC_KEY` | `"/usr/share/filebeat/certs/elasticsearch-logs/elas ...` | `` |  | None |
| `FILEBEAT_ELASTIC_NODES` | `"${FILEBEAT_ELASTIC_NODES:-https://elasticsearch-l ...` | `` |  |  |
| `FILEBEAT_ELASTIC_PASSWORD` | `"${ELASTIC_PASSWORD}"` | `` |  | `elastic` in `conf/elastic.env` |
| `FILEBEAT_ELASTIC_USERNAME` | `"${FILEBEAT_ELASTIC_USERNAME:-elastic}"` | `` |  | empty value in `conf/elastic.env` |
| `FILEBEAT_KIBANA_CERT_AUTH` | `"/usr/share/filebeat/certs/ca/ca.crt"` | `` |  | None |
| `FILEBEAT_KIBANA_CERT` | `"/usr/share/filebeat/certs/kibana-logs/kibana-logs ...` | `` |  | None |
| `FILEBEAT_KIBANA_KEY` | `"/usr/share/filebeat/certs/kibana-logs/kibana-logs ...` | `` |  | None |
| `FILEBEAT_KIBANA_NODE` | `"${FILEBEAT_KIBANA_NODE:-https://kibana-logs:5601} ...` | `` |  |  |
| `FILEBEAT_KIBANA_PASSWORD` | `"${ELASTIC_PASSWORD}"` | `` |  | `elastic` in `conf/elastic.env` |
| `FILEBEAT_KIBANA_USERNAME` | `"${FILEBEAT_KIBANA_USERNAME:-elastic}"` | `` |  | empty value in `conf/elastic.env` |
## File: dc/ref-dc-iam-server.yaml
### Service: auth-server
Image: `ARLAS_IAM_SERVER_VERSION` with `docker.cloudsmith.io/gisaia/private/arlas-iam-serv ...` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_ACCESS_TOKEN_TTL` | `600000` | `` |  | None |
| `ARLAS_ANONYMOUS_VALUE` | `"${ARLAS_ANONYMOUS_VALUE:-anonymous}"` | `` |  |  |
| `ARLAS_AUTH_INIT_ADMIN` | `"${ARLAS_AUTH_INIT_ADMIN}"` | `` |  | `tech@gisaia.com` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_INIT_PASSWORD` | `"${ARLAS_AUTH_INIT_PASSWORD}"` | `` |  | `admin` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_CACHE_TIMEOUT` | `"${ARLAS_CACHE_TIMEOUT:-5}"` | `` |  |  |
| `ARLAS_IAM_CACHE_FACTORY_CLASS` | `"${ARLAS_IAM_CACHE_FACTORY_CLASS:-io.arlas.commons ...` | `` |  |  |
| `ARLAS_IAM_HIBERNATE_PASSWORD` | `"${POSTGRES_PASSWORD}"` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `ARLAS_IAM_HIBERNATE_URL` | `"${ARLAS_IAM_HIBERNATE_URL:-jdbc:postgresql://db:5 ...` | `` |  |  |
| `ARLAS_IAM_HIBERNATE_USER` | `"${POSTGRES_USER}"` | `` |  | `pg-user` in `conf/postgres.env` |
| `ARLAS_IAM_LOGGING_CONSOLE_LEVEL` | `"${ARLAS_IAM_LOGGING_CONSOLE_LEVEL}"` | `` |  | `INFO` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_IAM_LOGGING_LEVEL` | `"${ARLAS_IAM_LOGGING_LEVEL}"` | `` |  | `INFO` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_IAM_PORT` | `"${ARLAS_IAM_PORT:-9998}"` | `` |  |  |
| `ARLAS_IAM_VERIFY_EMAIL` | `"${ARLAS_IAM_VERIFY_EMAIL}"` | `` |  | `false` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_REFRESH_TOKEN_TTL` | `600000` | `` |  | None |
| `ARLAS_SERVER_URL` | `"http://arlas-server:9999/arlas/"` | `` |  | None |
| `ARLAS_SMTP_ACTIVATED` | `"${ARLAS_SMTP_ACTIVATED}"` | `` |  | `false` in `conf/aias.env`<br>`false` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_FROM` | `"${ARLAS_SMTP_FROM}"` | `` |  | `tobechanged@tobechanged.io` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_HOST` | `"${ARLAS_SMTP_HOST}"` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_PASSWORD` | `"${ARLAS_SMTP_PASSWORD}"` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_PORT` | `"${ARLAS_SMTP_PORT:-25}"` | `` |  | `25` in `conf/aias.env` |
| `ARLAS_SMTP_RESET_LINK` | `"http://${HOST}/hub/reset/%s/user/%s"` | `` |  | `localhost` in `conf/stack.env` |
| `ARLAS_SMTP_USERNAME` | `"${ARLAS_SMTP_USERNAME}"` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_SMTP_VERIFY_LINK` | `"http://${HOST}/hub/verify/%s/user/%s"` | `` |  | `localhost` in `conf/stack.env` |
| `JDK_JAVA_OPTIONS` | `${ARLAS_IAM_JDK_JAVA_OPTIONS}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `${ARLAS_AUTH_KEYCLOAK_REALM}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `${ARLAS_AUTH_KEYCLOAK_RESOURCE}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `${ARLAS_AUTH_KEYCLOAK_SECRET}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_URL` | `${ARLAS_AUTH_KEYCLOAK_URL}` | `` |  | empty value in `conf/arlas_keycloak.env` |
## File: dc/ref-dc-iam-wui.yaml
### Service: arlas-wui-iam
Image: `ARLAS_WUI_IAM_VERSION` with `docker.cloudsmith.io/gisaia/private/arlas-wui-iam: ...` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_MODE` | `${ARLAS_AUTHENT_MODE}` | `` |  | `iam` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_THRESHOLD` | `${ARLAS_AUTHENT_THRESHOLD}` | `` |  | `60000` in `conf/arlas_iam.env`<br>empty value in `conf/arlas_keycloak.env` |
| `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` | `` |  | None |
| `ARLAS_TAB_NAME` | `"ARLAS Wui IAM"` | `` |  | None |
| `ARLAS_USE_AUTHENT` | `${ARLAS_USE_AUTHENT}` | `` |  | `true` in `conf/arlas_iam.env`<br>`false` in `conf/arlas_keycloak.env` |
| `ARLAS_WUI_IAM_APP_PATH` | `/iam` | `` |  | None |
| `ARLAS_WUI_IAM_BASE_HREF` | `/iam` | `` |  | None |
## File: dc/ref-dc-keycloak.yaml
### Service: keycloak
Image: `KEYCLOAK_VERSION` with `quay.io/keycloak/keycloak:23.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `KC_HEALTH_ENABLED` | `true` | `` |  This is to enable kubernetes healthchecks | None |
| `KEYCLOAK_ADMIN_PASSWORD` | `${KEYCLOAK_ADMIN_PASSWORD}` | `` |  | empty value in `conf/arlas_keycloak.env` |
| `KEYCLOAK_ADMIN` | `${KEYCLOAK_ADMIN_LOGIN}` | `` |  | empty value in `conf/arlas_keycloak.env` |
## File: dc/ref-dc-logger.yaml
### Service: log-rotated

## File: dc/ref-dc-metricbeat.yaml
### Service: metricbeat
Image: `METRICBEAT_VERSION` with `docker.elastic.co/beats/metricbeat:8.9.2` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `CA_CERT` | `certs/ca/ca.crt` | `` |  | None |
| `ELASTIC_HOSTS_OUTPUT` | `https://elasticsearch-logs:9200` | `` |  | None |
| `ELASTIC_HOSTS` | `https://elasticsearch:9200` | `` |  | None |
| `ELASTIC_PASSWORD` | `${ELASTIC_PASSWORD}` | `` |  | `elastic` in `conf/elastic.env` |
| `ELASTIC_USER` | `elastic` | `` |  | None |
| `ES_CERT` | `certs/elasticsearch-logs/elasticsearch-logs.crt` | `` |  | None |
| `ES_KEY` | `certs/elasticsearch-logs/elasticsearch-logs.key` | `` |  | None |
## File: dc/ref-dc-net.yaml
## File: dc/ref-dc-pgadmin.yaml
### Service: pgadmin
Image: `PGADMIN4_VERSION` with `dpage/pgadmin4:7.8` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `PGADMIN_DEFAULT_EMAIL` | `${PGA_LOGIN}` | `` |  | `pga` in `conf/postgres.env` |
| `PGADMIN_DEFAULT_PASSWORD` | `${PGA_PASSWORD}` | `` |  | `secret` in `conf/postgres.env` |
| `PGADMIN_ENABLE_TLS` | `${PGADMIN_ENABLE_TLS:-true}` | `` |  |  |
| `PGADMIN_LISTEN_PORT` | `443` | `` |  | None |
## File: dc/ref-dc-postgres.yaml
### Service: db
Image: `POSTGRES_VERSION` with `postgres:16.1` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `DAY_OF_WEEK_TO_KEEP` | `${POSTGRES_DAY_OF_WEEK_TO_KEEP}` | `` |  | `6` in `conf/postgres.env` |
| `DAYS_TO_KEEP` | `${POSTGRES_DAYS_TO_KEEP}` | `` |  | `7` in `conf/postgres.env` |
| `WEEKS_TO_KEEP` | `${POSTGRES_WEEKS_TO_KEEP}` | `` |  | `5` in `conf/postgres.env` |
| `PG_BACKUP_DIR` | `/backup/` | `` |  | None |
| `PGPASSWORD` | `${POSTGRES_PASSWORD}` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `PGUSER` | `${POSTGRES_USER}` | `` |  | `pg-user` in `conf/postgres.env` |
| `POSTGRES_DB` | `arlas` | `` |  | None |
| `POSTGRES_HOST_AUTH_METHOD` | `trust` | `` |  | None |
| `POSTGRES_PASSWORD` | `${POSTGRES_PASSWORD}` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `POSTGRES_USER` | `${POSTGRES_USER}` | `` |  | `pg-user` in `conf/postgres.env` |
## File: dc/ref-dc-protomaps.yaml
### Service: protomaps
Image: `PROTOMAP_VERSION` with `protomaps/go-pmtiles:v1.19.0` in `conf/versions.env`

## File: dc/ref-dc-volumes.yaml
