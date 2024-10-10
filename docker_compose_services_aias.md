## Services:
- [elasticsearch](#service-elasticsearch)
- [arlas-server](#service-arlas-server)
- [arlas-persistence-server](#service-arlas-persistence-server)
- [arlas-permissions-server](#service-arlas-permissions-server)
- [arlas-iam-server](#service-arlas-iam-server)
- [arlas-wui-iam](#service-arlas-wui-iam)
- [arlas-builder](#service-arlas-builder)
- [arlas-hub](#service-arlas-hub)
- [arlas-wui](#service-arlas-wui)
- [protomaps](#service-protomaps)
- [apisix](#service-apisix)
- [db](#service-db)
- [airs-server](#service-airs-server)
- [aproc-proc](#service-aproc-proc)
- [aproc-service](#service-aproc-service)
- [arlas-fam-wui](#service-arlas-fam-wui)
- [fam-service](#service-fam-service)
- [minio](#service-minio)
- [rabbitmq](#service-rabbitmq)
- [redis](#service-redis)
- [agate](#service-agate)
## File dc/ref-dc-elastic.yaml
### Service elasticsearch
Description: Elasticsearch is an indexing engine

Image: `ELASTIC_VERSION` with `docker.elastic.co/elasticsearch/elasticsearch:8.9. ...` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `discovery.type` | `single-node` | `` |  |  |
| `cluster.name` | `arlas-es-cluster` | `` |  |  |
| `node.name` | `arlas-data-node-1` | `` |  |  |
| `ES_JAVA_OPTS` | `ES_JAVA_OPTS` | `` |  | `-Xms1g -Xmx1g` in `conf/elastic.env` |
| `xpack.security.enabled` | `false` | `` |  |  |
| `xpack.security.http.ssl.enabled` | `false` | `` |  |  |
| `xpack.security.transport.ssl.enabled` | `false` | `` |  |  |
| `tracing.apm.enabled` | `false` | `` |  |  |

List of volumes:
- ${ELASTIC_STORAGE:-arlas-data-es}:/usr/share/elasticsearch/data
## File dc/ref-dc-arlas-server.yaml
### Service arlas-server
Description: ARLAS Server is the geo-analytic engine of the ARLAS Exploration Stack

Image: `ARLAS_SERVER_VERSION` with `gisaia/arlas-server:26.0.2` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLICY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  Specify a PolicyEnforcer class to load in order to activate Authentication if needed | `io.arlas.filter.impl.HTTPPolicyEnforcer` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET/ ...` | `` |  |  |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERMISSION_URL` | `` |  | `http://arlas-iam-server:9998/arlas_iam_server/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_APP_PATH` | `/` | `` |  |  |
| `ARLAS_BASE_URI` | `ARLAS_BASE_URI` | `http://arlas-server:9999/arlas/` |  Arlas base uri |  |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIMEOUT` | `5` |  TTL in seconds of items in the cache |  |
| `ARLAS_CORS_ALLOWED_HEADERS` | `"arlas-user,arlas-groups,arlas-organization,X-Requ ...` | `` |  Comma-separated list of allowed headers |  |
| `ARLAS_CORS_ENABLED` | `ARLAS_CORS_ENABLED` | `true` |  Whether to configure cors or not |  |
| `ARLAS_ELASTIC_CLUSTER` | `ARLAS_ELASTIC_CLUSTER` | `arlas-es-cluster` |  |  |
| `ARLAS_ELASTIC_ENABLE_SSL` | `false` | `` |  use SSL to connect to elasticsearch |  |
| `ARLAS_ELASTIC_INDEX` | `ARLAS_ELASTIC_INDEX` | `.arlas` |  name of the index that is used for storing ARLAS configuration |  |
| `ARLAS_ELASTIC_NODES` | `ARLAS_ELASTIC_NODES` | `elasticsearch:9200` |  comma separated list of elasticsearch nodes as host:port values |  |
| `ARLAS_ELASTIC_SKIP_MASTER` | `ARLAS_ELASTIC_SKIP_MASTER` | `true` |  |  |
| `ARLAS_ELASTIC_SNIFFING` | `ES_SNIFFING` | `false` |  |  |
| `ARLAS_INSPIRE_ENABLED` | `ARLAS_INSPIRE_ENABLED` | `false` |  Whether to activate INSPIRE compliant response elements |  |
| `ARLAS_LOGGING_CONSOLE_LEVEL` | `ARLAS_LOGGING_CONSOLE_LEVEL` | `` |  | `INFO` in `conf/arlas.env` |
| `ARLAS_LOGGING_LEVEL` | `ARLAS_LOGGING_LEVEL` | `` |  | `INFO` in `conf/arlas.env` |
| `ARLAS_PREFIX` | `/arlas` | `` |  |  |
| `ARLAS_SERVICE_CSW_ENABLE` | `ARLAS_SERVICE_CSW_ENABLE` | `false` |  Whether the CSW service is enabled or not |  |
| `ARLAS_SERVICE_RASTER_TILES_ENABLE` | `ARLAS_SERVICE_RASTER_TILES_ENABLE` | `false` |  Whether the RASTER tile service is enabled or not |  |
| `ARLAS_SERVICE_WFS_ENABLE` | `ARLAS_SERVICE_WFS_ENABLE` | `false` |  Whether the WFS service is enabled or not |  |
| `JDK_JAVA_OPTIONS` | `ARLAS_SERVER_JDK_JAVA_OPTIONS` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  |  |
## File dc/ref-dc-arlas-persistence-server.yaml
### Service arlas-persistence-server
Description: ARLAS Persistence is a service for storing and retrieving small ojects, such as JSON documents or image previews.

Image: `ARLAS_PERSISTENCE_VERSION` with `gisaia/arlas-persistence-server:26.0.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLICY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  | `io.arlas.filter.impl.HTTPPolicyEnforcer` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET/ ...` | `` |  |  |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERMISSION_URL` | `` |  | `http://arlas-iam-server:9998/arlas_iam_server/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_ENABLED` | `ARLAS_AUTH_ENABLED` | `false` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIMEOUT` | `5` |  |  |
| `ARLAS_PERSISTENCE_APP_PATH` | `ARLAS_PERSISTENCE_APP_PATH` | `/` |  |  |
| `ARLAS_PERSISTENCE_ENGINE` | `ARLAS_PERSISTENCE_ENGINE` | `hibernate` |  | `file` in `conf/persistence-file.env` |
| `ARLAS_PERSISTENCE_HIBERNATE_PASSWORD` | `POSTGRES_PASSWORD` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `ARLAS_PERSISTENCE_HIBERNATE_URL` | `ARLAS_PERSISTENCE_HIBERNATE_URL` | `jdbc:postgresql://db:5432/arlas` |  |  |
| `ARLAS_PERSISTENCE_HIBERNATE_USER` | `POSTGRES_USER` | `` |  | `pg-user` in `conf/postgres.env` |
| `ARLAS_PERSISTENCE_LOCAL_FOLDER` | `/persist/` | `` |  |  |
| `ARLAS_PERSISTENCE_LOGGING_CONSOLE_LEVEL` | `ARLAS_PERSISTENCE_LOGGING_CONSOLE_LEVEL` | `` |  | `INFO` in `conf/persistence-file.env` |
| `ARLAS_PERSISTENCE_LOGGING_LEVEL` | `ARLAS_PERSISTENCE_LOGGING_LEVEL` | `` |  | `INFO` in `conf/persistence-file.env` |
| `ARLAS_PERSISTENCE_PORT` | `ARLAS_PERSISTENCE_PORT` | `9997` |  |  |
| `ARLAS_PERSISTENCE_PREFIX` | `ARLAS_PERSISTENCE_PREFIX` | `/arlas-persistence-server` |  | `/persist` in `conf/persistence-file.env` |
| `ELASTIC_APM_APPLICATION_PACKAGES` | `io.arlas` | `` |  |  |
| `ELASTIC_APM_ENVIRONMENT` | `ELASTIC_APM_ENVIRONMENT` | `` |  | `ARLAS` in `conf/elastic.env` |
| `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `*` |  |  |
| `ELASTIC_APM_LOG_ECS_REFORMATTING` | `ELASTIC_APM_LOG_ECS_REFORMATTING` | `OVERRIDE` |  |  |
| `ELASTIC_APM_SECRET_TOKEN` | `ELASTIC_APM_SECRET_TOKEN` | `` |  | `not_a_secret` in `conf/elastic.env` |
| `ELASTIC_APM_SERVER_URLS` | `ELASTIC_APM_SERVER_URLS` | `http://apm-server:8200` |  |  |
| `ELASTIC_APM_SERVICE_NAME` | `arlas-persistence-server` | `` |  |  |
| `ELASTIC_APM_TRANSACTION_IGNORE_USER_AGENTS` | `GoogleHC/*, kube-probe/*, curl*, GoogleStackdriver ...` | `` |  |  |
| `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `true` |  |  |
| `JDK_JAVA_OPTIONS` | `ARLAS_PERSISTENCE_JDK_JAVA_OPTIONS` | `` |  |  |

List of volumes:
- ${ARLAS_PERSISTENCE_STORAGE}:/persist/
## File dc/ref-dc-arlas-permissions-server.yaml
### Service arlas-permissions-server
Description: ARLAS Permissions is a service for listing user's permissions

Image: `ARLAS_PERMISSIONS_VERSION` with `gisaia/arlas-permissions-server:26.0.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLICY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  | `io.arlas.filter.impl.HTTPPolicyEnforcer` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERMISSION_URL` | `` |  | `http://arlas-iam-server:9998/arlas_iam_server/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_ENABLED` | `ARLAS_AUTH_ENABLED` | `false` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_PERMISSIONS_APP_PATH` | `/` | `` |  |  |
| `ARLAS_PERMISSIONS_PREFIX` | `/arlas_permissions_server` | `` |  |  |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIMEOUT` | `5` |  |  |
| `ARLAS_PERMISSIONS_LOGGING_CONSOLE_LEVEL` | `ARLAS_PERMISSIONS_LOGGING_CONSOLE_LEVEL` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_PERMISSIONS_LOGGING_LEVEL` | `ARLAS_PERMISSIONS_LOGGING_LEVEL` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET/ ...` | `` |  |  |
| `ARLAS_PERMISSIONS_PORT` | `ARLAS_PERMISSIONS_PORT` | `9996` |  |  |
| `ELASTIC_APM_APPLICATION_PACKAGES` | `io.arlas` | `` |  |  |
| `ELASTIC_APM_ENVIRONMENT` | `ELASTIC_APM_ENVIRONMENT` | `` |  | `ARLAS` in `conf/elastic.env` |
| `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `*` |  |  |
| `ELASTIC_APM_LOG_ECS_REFORMATTING` | `ELASTIC_APM_LOG_ECS_REFORMATTING` | `OVERRIDE` |  |  |
| `ELASTIC_APM_SECRET_TOKEN` | `ELASTIC_APM_SECRET_TOKEN` | `` |  | `not_a_secret` in `conf/elastic.env` |
| `ELASTIC_APM_SERVER_URLS` | `ELASTIC_APM_SERVER_URLS` | `http://apm-server:8200` |  |  |
| `ELASTIC_APM_SERVICE_NAME` | `arlas-permission-server` | `` |  |  |
| `ELASTIC_APM_TRANSACTION_IGNORE_USER_AGENTS` | `GoogleHC/*, kube-probe/*, curl*, GoogleStackdriver ...` | `` |  |  |
| `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `true` |  |  |
| `JDK_JAVA_OPTIONS` | `ARLAS_PERMISSIONS_JDK_JAVA_OPTIONS` | `` |  | empty value in `conf/permissions.env` |
## File dc/ref-dc-iam-server.yaml
### Service arlas-iam-server
Description: ARLAS IAM is the ARLAS Identity and Access Management service.

Image: `ARLAS_IAM_SERVER_VERSION` with `gisaia/arlas-iam-server:26.0.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_ACCESS_TOKEN_TTL` | `600000` | `` |  |  |
| `ARLAS_ANONYMOUS_VALUE` | `ARLAS_ANONYMOUS_VALUE` | `anonymous` |  |  |
| `ARLAS_AUTH_INIT_ADMIN` | `ARLAS_AUTH_INIT_ADMIN` | `` |  | `tech@gisaia.com` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_INIT_PASSWORD` | `ARLAS_AUTH_INIT_PASSWORD` | `` |  | `admin` in `conf/arlas_iam.env` |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIMEOUT` | `5` |  |  |
| `ARLAS_IAM_CACHE_FACTORY_CLASS` | `ARLAS_IAM_CACHE_FACTORY_CLASS` | `io.arlas.commons.cache.NoCacheFactory` |  |  |
| `ARLAS_IAM_HIBERNATE_PASSWORD` | `POSTGRES_PASSWORD` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `ARLAS_IAM_HIBERNATE_URL` | `ARLAS_IAM_HIBERNATE_URL` | `jdbc:postgresql://db:5432/arlas` |  |  |
| `ARLAS_IAM_HIBERNATE_USER` | `POSTGRES_USER` | `` |  | `pg-user` in `conf/postgres.env` |
| `ARLAS_IAM_LOGGING_CONSOLE_LEVEL` | `ARLAS_IAM_LOGGING_CONSOLE_LEVEL` | `` |  | `INFO` in `conf/arlas_iam.env` |
| `ARLAS_IAM_LOGGING_LEVEL` | `ARLAS_IAM_LOGGING_LEVEL` | `` |  | `INFO` in `conf/arlas_iam.env` |
| `ARLAS_IAM_PORT` | `ARLAS_IAM_PORT` | `9998` |  |  |
| `ARLAS_IAM_VERIFY_EMAIL` | `ARLAS_IAM_VERIFY_EMAIL` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_REFRESH_TOKEN_TTL` | `600000` | `` |  |  |
| `ARLAS_SERVER_URL` | `"http://arlas-server:9999/arlas/"` | `` |  |  |
| `ARLAS_SMTP_ACTIVATED` | `ARLAS_SMTP_ACTIVATED` | `` |  | `false` in `conf/aias.env`<br>`false` in `conf/arlas_iam.env` |
| `ARLAS_SMTP_FROM` | `ARLAS_SMTP_FROM` | `` |  | `tobechanged@tobechanged.io` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_HOST` | `ARLAS_SMTP_HOST` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PASSWORD` | `ARLAS_SMTP_PASSWORD` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PORT` | `ARLAS_SMTP_PORT` | `25` |  | `25` in `conf/aias.env` |
| `ARLAS_SMTP_RESET_LINK` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `ARLAS_SMTP_USERNAME` | `ARLAS_SMTP_USERNAME` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_VERIFY_LINK` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `JDK_JAVA_OPTIONS` | `ARLAS_IAM_JDK_JAVA_OPTIONS` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  |  |
## File dc/ref-dc-iam-wui.yaml
### Service arlas-wui-iam
Description: ARLAS IAM is the ARLAS Identity and Access Management web interface.

Image: `ARLAS_WUI_IAM_VERSION` with `gisaia/arlas-wui-iam:26.0.1` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_MODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` | `` |  |  |
| `ARLAS_TAB_NAME` | `"ARLAS Wui IAM"` | `` |  |  |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_IAM_APP_PATH` | `/iam` | `` |  |  |
| `ARLAS_WUI_IAM_BASE_HREF` | `/iam` | `` |  |  |
| `ARLAS_STATIC_LINKS` | `ARLAS_IAM_LINKS` | `` |  | `'` in `conf/arlas_iam.env` |
## File dc/ref-dc-arlas-builder.yaml
### Service arlas-builder
Description: ARLAS Builder is the interface for elaborating ARLAS Dashboards.

Image: `ARLAS_BUILDER_VERSION` with `gisaia/arlas-wui-builder:26.0.4` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_CLEAR_HASH` | `true` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_CLIENT_ID` | `` |  |  |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `true` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `true` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_FORCE_CONNECT` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_ISSUER` | `` |  |  |
| `ARLAS_AUTHENT_LOGIN_URL` | `ARLAS_AUTHENT_LOGIN_URL` | `` |  | `https://${ARLAS_HOST}/hub/login` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_LOGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_MODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_REDIRECT_URI` | `/wui/callback` |  |  |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_REQUIRE_HTTPS` | `false` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_RESPONSE_TYPE` | `code` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_SCOPE` | `profile` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_SHOW_DEBUG` | `false` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `10000` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_STORAGE` | `memorystorage` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `0.75` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_USE_DISCOVERY` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_BASEMAPS` | `ARLAS_BASEMAPS` | `[{"name":"Empty","url":"/styles/empty/style.json","image":null}]` |  | `'[` in `conf/arlas.env` |
| `ARLAS_BASEMAPS` | `[{"name":"Streets-light","url":"https://api.maptil ...` | `` |  |  |
| `ARLAS_BUILDER_BASE_HREF` | `ARLAS_BUILDER_BASE_HREF` | `/builder` |  |  |
| `ARLAS_EXTERNAL_NODE_PAGE` | `ARLAS_EXTERNAL_NODE_PAGE` | `true` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERMISSIONS_URL` | `ARLAS_PERMISSIONS_URL` | `/arlas_permissions_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/arlas_persistence_server` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS_HOST}/persist` in `conf/arlas_iam.env` |
| `ARLAS_SERVER_URL` | `ARLAS_SERVER_URL` | `/arlas` |  | `https://${ARLAS_HOST}/arlas` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_URL` | `ARLAS_WUI_URL` | `/wui/` |  | `https://${ARLAS_HOST}/wui/` in `conf/arlas_iam.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_BUILDER_LINKS` | `` |  | `'` in `conf/arlas.env` |
## File dc/ref-dc-arlas-hub.yaml
### Service arlas-hub
Description: ARLAS Hub is the interface for discovering all the available ARLAS Dashboards

Image: `ARLAS_HUB_VERSION` with `gisaia/arlas-wui-hub:26.0.1` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_CLEAR_HASH` | `true` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_CLIENT_ID` | `` |  |  |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `true` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `true` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_FORCE_CONNECT` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_ISSUER` | `` |  |  |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_LOGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_MODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_REDIRECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_REQUIRE_HTTPS` | `false` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_RESPONSE_TYPE` | `` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_SCOPE` | `` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_SHOW_DEBUG` | `false` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `10000` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_STORAGE` | `memorystorage` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `0.75` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_USE_DISCOVERY` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_BUILDER_URL` | `ARLAS_BUILDER_URL` | `/builder/` |  | `https://${ARLAS_HOST}/builder/` in `conf/arlas_iam.env` |
| `ARLAS_HUB_BASE_HREF` | `ARLAS_HUB_BASE_HREF` | `/hub` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERMISSIONS_URL` | `ARLAS_PERMISSIONS_URL` | `/arlas_permissions_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/persist` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS_HOST}/persist` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_URL` | `ARLAS_WUI_URL` | `/wui/` |  | `https://${ARLAS_HOST}/wui/` in `conf/arlas_iam.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_HUB_LINKS` | `` |  | `'` in `conf/arlas.env` |
## File dc/ref-dc-arlas-wui.yaml
### Service arlas-wui
Description: ARLAS WUI is ARLAS Web interface for visualising an analytic ARLAS Dashboard.

Image: `ARLAS_WUI_VERSION` with `gisaia/arlas-wui:26.0.6-no-analytics` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_CLEAR_HASH` | `true` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_CLIENT_ID` | `` |  |  |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `true` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `true` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_FORCE_CONNECT` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_ISSUER` | `` |  |  |
| `ARLAS_AUTHENT_LOGIN_URL` | `ARLAS_AUTHENT_LOGIN_URL` | `` |  | `https://${ARLAS_HOST}/hub/login` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_LOGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_MODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_REDIRECT_URI` | `/wui/callback` |  |  |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_REQUIRE_HTTPS` | `false` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_RESPONSE_TYPE` | `code` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_SCOPE` | `profile` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_SHOW_DEBUG` | `false` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `10000` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_STORAGE` | `memorystorage` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `0.75` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_USE_DISCOVERY` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_GEOCODING_FIND_PLACE_URL` | `ARLAS_GEOCODING_FIND_PLACE_URL` | `` |  | empty value in `conf/arlas.env` |
| `ARLAS_GEOCODING_FIND_PLACE_ZOOM_TO` | `ARLAS_GEOCODING_FIND_PLACE_ZOOM_TO` | `10` |  |  |
| `ARLAS_HUB_URL` | `ARLAS_HUB_URL` | `/hub/` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/arlas_persistence_server` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS_HOST}/persist` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_BASE_HREF` | `ARLAS_WUI_BASE_HREF` | `/wui` |  |  |
| `PUBLIC_HOST` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_WUI_LINKS` | `` |  | `'` in `conf/arlas.env` |

List of volumes:
- ${PWD}/conf/protomaps/styles:/usr/share/nginx/html/assets/basemap/styles
- ${PWD}/conf/protomaps/glyphs:/usr/share/nginx/html/assets/basemap/glyphs
- ${PWD}/conf/protomaps/quicklook:/usr/share/nginx/html/assets/basemap/quicklook
- ${PWD}/conf/protomaps/world.pmtiles:/usr/share/nginx/html/assets/basemap/world.pmtiles
## File dc/ref-dc-protomaps.yaml
### Service protomaps
Image: `PROTOMAP_VERSION` with `protomaps/go-pmtiles:v1.19.0` in `conf/versions.env`


List of volumes:
- ${PWD}/conf/protomaps/world.pmtiles:/protomaps/basemaps/world.pmtiles:ro
## File dc/ref-dc-apisix.yaml
### Service apisix
Description: APISIX is ARLAS Stack gateway. It handles all the incoming trafic.

Image: `APISIX_VERSION` with `apache/apisix:3.9.1-debian` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APISIX_STAND_ALONE` | `APISIX_STAND_ALONE` | `true` |  | `true` in `conf/apisix.env` |

List of volumes:
- ${APISIX_CONF_FILE}:/usr/local/apisix/conf/apisix.yaml:ro
## File dc/ref-dc-postgres.yaml
### Service db
Image: `POSTGRES_VERSION` with `postgres:16.1` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `DAY_OF_WEEK_TO_KEEP` | `POSTGRES_DAY_OF_WEEK_TO_KEEP` | `` |  | `6` in `conf/postgres.env` |
| `DAYS_TO_KEEP` | `POSTGRES_DAYS_TO_KEEP` | `` |  | `7` in `conf/postgres.env` |
| `WEEKS_TO_KEEP` | `POSTGRES_WEEKS_TO_KEEP` | `` |  | `5` in `conf/postgres.env` |
| `PG_BACKUP_DIR` | `/backup/` | `` |  |  |
| `PGPASSWORD` | `POSTGRES_PASSWORD` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `PGUSER` | `POSTGRES_USER` | `` |  | `pg-user` in `conf/postgres.env` |
| `POSTGRES_DB` | `arlas` | `` |  |  |
| `POSTGRES_HOST_AUTH_METHOD` | `trust` | `` |  |  |
| `POSTGRES_PASSWORD` | `POSTGRES_PASSWORD` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `POSTGRES_USER` | `POSTGRES_USER` | `` |  | `pg-user` in `conf/postgres.env` |

List of volumes:
- ${POSTGRES_BACKUP_STORAGE}:/backup/
- ${POSTGRES_CREATE_TABLE}:/docker-entrypoint-initdb.d/createTable.sql:ro
- ${POSTGRES_CRON}:/usr/local/bin/arlas/pg_backup_rotated.sh:ro
- ${POSTGRES_STORAGE}:/var/lib/postgresql/data
## File dc/ref-dc-aias-airs.yaml
### Service airs-server
Description: AIRS Server is ARLAS Item registration service. It exposes a STAC-T interface for registering item and assets in ARLAS, such as Earth Observation products.

Image: `ARLAS_VERSION_AIRS` with `gisaia/airs:0.4.17` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `AIRS_COLLECTION_URL` | `AIRS_COLLECTION_URL` | `https://raw.githubusercontent.com/gisaia/ARLAS-EO/v0.0.6/collection.json` |  |  |
| `AIRS_CORS_HEADERS` | `AIRS_CORS_HEADERS` | `*` |  |  |
| `AIRS_CORS_METHODS` | `AIRS_CORS_METHODS` | `*` |  |  |
| `AIRS_CORS_ORIGINS` | `AIRS_CORS_ORIGINS` | `*` |  |  |
| `AIRS_HOST` | `AIRS_HOST` | `0.0.0.0` |  |  |
| `AIRS_INDEX_COLLECTION_PREFIX` | `AIRS_INDEX_COLLECTION_PREFIX` | `airs` |  |  |
| `AIRS_INDEX_ENDPOINT_URL` | `AIRS_INDEX_ENDPOINT_URL` | `` |  | `http://elasticsearch:9200` in `conf/aias.env` |
| `AIRS_INDEX_LOGIN` | `ELASTIC_USER` | `` |  | `elastic` in `conf/elastic.env` |
| `AIRS_INDEX_PWD` | `ELASTIC_PASSWORD` | `` |  | `elastic` in `conf/elastic.env` |
| `AIRS_LOGGER_LEVEL` | `AIRS_LOGGER_LEVEL` | `` |  | `INFO` in `conf/aias.env` |
| `AIRS_MAPPING_URL` | `AIRS_MAPPING_URL` | `/app/conf/mapping.json` |  |  |
| `AIRS_PORT` | `AIRS_PORT` | `8000` |  |  |
| `AIRS_PREFIX` | `AIRS_PREFIX` | `/airs` |  |  |
| `AIRS_S3_ACCESS_KEY_ID` | `AIRS_S3_ACCESS_KEY_ID` | `` |  | `airs` in `conf/aias.env` |
| `AIRS_S3_ASSET_HTTP_ENDPOINT_URL` | `AIRS_S3_ASSET_HTTP_ENDPOINT_URL` | `` |  | `http://minio:9000/{}/{}` in `conf/aias.env` |
| `AIRS_S3_BUCKET` | `AIRS_S3_BUCKET` | `airs-storage` |  | `airs` in `conf/aias.env` |
| `AIRS_S3_ENDPOINT_URL` | `AIRS_S3_ENDPOINT_URL` | `http://minio:9000` |  | `http://minio:9000` in `conf/aias.env` |
| `AIRS_S3_PLATFORM` | `AIRS_S3_PLATFORM` | `MINIO` |  |  |
| `AIRS_S3_REGION` | `AIRS_S3_REGION` | `Standart` |  |  |
| `AIRS_S3_SECRET_ACCESS_KEY` | `AIRS_S3_SECRET_ACCESS_KEY` | `` |  | `airssecret` in `conf/aias.env` |
| `AIRS_S3_TIER` | `AIRS_S3_TIER` | `Standard` |  |  |
| `ELASTIC_APM_APPLICATION_PACKAGES` | `io.arlas` | `` |  |  |
| `ELASTIC_APM_ENVIRONMENT` | `ELASTIC_APM_ENVIRONMENT` | `` |  | `ARLAS` in `conf/elastic.env` |
| `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `*` |  |  |
| `ELASTIC_APM_LOG_ECS_REFORMATTING` | `ELASTIC_APM_LOG_ECS_REFORMATTING` | `OVERRIDE` |  |  |
| `ELASTIC_APM_SECRET_TOKEN` | `ELASTIC_APM_SECRET_TOKEN` | `` |  | `not_a_secret` in `conf/elastic.env` |
| `ELASTIC_APM_SERVER_URLS` | `ELASTIC_APM_SERVER_URLS` | `http://apm-server:8200` |  |  |
| `ELASTIC_APM_SERVICE_NAME` | `airs-server` | `` |  |  |
| `ELASTIC_APM_TRANSACTION_IGNORE_USER_AGENTS` | `GoogleHC/*, kube-probe/*, curl*, GoogleStackdriver ...` | `` |  |  |
| `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `true` |  |  |
## File dc/ref-dc-aias-aproc-proc.yaml
### Service aproc-proc
Description: ARLAS PROC is a worker, based on celery. Used for ingesting and downloading EO products.

Image: `ARLAS_VERSION_APROC_PROC` with `gisaia/aproc-proc:0.4.17` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APROC_LOGGER_LEVEL` | `APROC_LOGGER_LEVEL` | `INFO` |  | `INFO` in `conf/aias.env` |
| `APROC_CONFIGURATION_FILE` | `/home/app/worker/conf/aproc.yaml` | `` |  |  |
| `CELERY_BROKER_URL` | `pyamqp://guest:guest@rabbitmq:5672//` | `` |  |  |
| `CELERY_RESULT_BACKEND` | `redis://redis:6379/0` | `` |  |  |
| `AIRS_ENDPOINT` | `http://airs-server:8000/airs` | `` |  |  |
| `APROC_ENDPOINT_FROM_APROC` | `http://aproc-service:8001/aproc` | `` |  |  |
| `ROOT_DIRECTORY` | `/inputs` | `` |  |  |
| `ARLAS_SMTP_ACTIVATED` | `ARLAS_SMTP_ACTIVATED` | `false` |  | `false` in `conf/aias.env`<br>`false` in `conf/arlas_iam.env` |
| `ARLAS_SMTP_HOST` | `ARLAS_SMTP_HOST` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PORT` | `ARLAS_SMTP_PORT` | `25` |  | `25` in `conf/aias.env` |
| `ARLAS_SMTP_USERNAME` | `ARLAS_SMTP_USERNAME` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PASSWORD` | `ARLAS_SMTP_PASSWORD` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_FROM` | `ARLAS_SMTP_FROM` | `` |  | `tobechanged@tobechanged.io` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `APROC_DOWNLOAD_ADMIN_EMAILS` | `APROC_DOWNLOAD_ADMIN_EMAILS` | `` |  | `"admin@the.boss,someone.else@the.boss"` in `conf/aias.env` |
| `APROC_DOWNLOAD_OUTBOX_DIR` | `"/outbox"` | `` |  |  |
| `APROC_DOWNLOAD_CONTENT_USER` | `APROC_DOWNLOAD_CONTENT_USER` | `` |  | `"\"ARLAS Services: Dear {arlas-user-email}. <br>Yo ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_USER` | `APROC_DOWNLOAD_SUBJECT_USER` | `` |  | `"\"ARLAS Services: Your download of {collection}/{ ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_CONTENT_ERROR` | `APROC_DOWNLOAD_CONTENT_ERROR` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_ERROR` | `APROC_DOWNLOAD_SUBJECT_ERROR` | `` |  | `"\"ARLAS Services: ERROR: The download of {collect ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_CONTENT_ADMIN` | `APROC_DOWNLOAD_CONTENT_ADMIN` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_ADMIN` | `APROC_DOWNLOAD_SUBJECT_ADMIN` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_SUBJECT_USER` | `APROC_DOWNLOAD_REQUEST_SUBJECT_USER` | `` |  | `"\"ARLAS Services: Thank you for your download req ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_CONTENT_USER` | `APROC_DOWNLOAD_REQUEST_CONTENT_USER` | `` |  | `"\"ARLAS Services: Dear {arlas-user-email}. <br>Yo ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_SUBJECT_ADMIN` | `APROC_DOWNLOAD_REQUEST_SUBJECT_ADMIN` | `` |  | `"\"ARLAS Services: {arlas-user-email} requested th ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_CONTENT_ADMIN` | `APROC_DOWNLOAD_REQUEST_CONTENT_ADMIN` | `` |  | `"\"ARLAS Services: {arlas-user-email} requested th ...` in `conf/aias.env` |
| `APROC_EMAIL_PATH_PREFIX_ADD` | `APROC_EMAIL_PATH_PREFIX_ADD` | `` |  | `"/tmp/"` in `conf/aias.env` |
| `APROC_PATH_TO_WINDOWS` | `APROC_PATH_TO_WINDOWS` | `` |  | `false` in `conf/aias.env` |
| `ARLAS_URL_SEARCH` | `ARLAS_URL_SEARCH` | `` |  | `"http://arlas-server:9999/arlas/explore/{collectio ...` in `conf/aias.env` |
| `AIRS_INDEX_COLLECTION_PREFIX` | `AIRS_INDEX_COLLECTION_PREFIX` | `` |  |  |
| `APROC_INDEX_ENDPOINT_URL` | `http://elasticsearch:9200` | `` |  |  |
| `APROC_INDEX_NAME` | `APROC_INDEX_NAME` | `` |  | `aproc_downloads` in `conf/aias.env` |
| `APROC_RESOURCE_ID_HASH_STARTS_AT` | `3` | `` |  |  |
| `TMP_FOLDER` | `"/outbox"` | `` |  |  |

List of volumes:
- ${APROC_INPUT_DIR}:/inputs:ro
- ${APROC_DOWNLOAD_DIR}:/outbox
- ${PWD}/conf/aias/drivers.yaml:/home/app/worker/conf/drivers.yaml:ro
## File dc/ref-dc-aias-aproc-service.yaml
### Service aproc-service
Description: ARLAS PROC is the OGC API Processes service. Used for ingesting and downloading EO products.

Image: `ARLAS_VERSION_APROC_SERVICE` with `gisaia/aproc-service:0.4.17` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APROC_LOGGER_LEVEL` | `APROC_LOGGER_LEVEL` | `INFO` |  | `INFO` in `conf/aias.env` |
| `APROC_HOST` | `0.0.0.0` | `` |  |  |
| `APROC_PORT` | `8001` | `` |  |  |
| `APROC_PREFIX` | `/aproc` | `` |  |  |
| `APROC_CONFIGURATION_FILE` | `/app/conf/aproc.yaml` | `` |  |  |
| `CELERY_BROKER_URL` | `pyamqp://guest:guest@rabbitmq:5672//` | `` |  |  |
| `CELERY_RESULT_BACKEND` | `redis://redis:6379/0` | `` |  |  |
| `AIRS_ENDPOINT` | `http://airs-server:8000/airs` | `` |  |  |
| `ARLAS_SMTP_ACTIVATED` | `ARLAS_SMTP_ACTIVATED` | `false` |  | `false` in `conf/aias.env`<br>`false` in `conf/arlas_iam.env` |
| `ARLAS_SMTP_HOST` | `ARLAS_SMTP_HOST` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PORT` | `ARLAS_SMTP_PORT` | `25` |  | `25` in `conf/aias.env` |
| `ARLAS_SMTP_USERNAME` | `ARLAS_SMTP_USERNAME` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PASSWORD` | `ARLAS_SMTP_PASSWORD` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_FROM` | `ARLAS_SMTP_FROM` | `` |  | `tobechanged@tobechanged.io` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `APROC_DOWNLOAD_ADMIN_EMAILS` | `APROC_DOWNLOAD_ADMIN_EMAILS` | `` |  | `"admin@the.boss,someone.else@the.boss"` in `conf/aias.env` |
| `APROC_DOWNLOAD_OUTBOX_DIR` | `"/outbox"` | `` |  |  |
| `APROC_DOWNLOAD_CONTENT_USER` | `APROC_DOWNLOAD_CONTENT_USER` | `` |  | `"\"ARLAS Services: Dear {arlas-user-email}. <br>Yo ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_USER` | `APROC_DOWNLOAD_SUBJECT_USER` | `` |  | `"\"ARLAS Services: Your download of {collection}/{ ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_CONTENT_ERROR` | `APROC_DOWNLOAD_CONTENT_ERROR` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_ERROR` | `APROC_DOWNLOAD_SUBJECT_ERROR` | `` |  | `"\"ARLAS Services: ERROR: The download of {collect ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_CONTENT_ADMIN` | `APROC_DOWNLOAD_CONTENT_ADMIN` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_SUBJECT_ADMIN` | `APROC_DOWNLOAD_SUBJECT_ADMIN` | `` |  | `"\"ARLAS Services: The download of {collection}/{i ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_SUBJECT_USER` | `APROC_DOWNLOAD_REQUEST_SUBJECT_USER` | `` |  | `"\"ARLAS Services: Thank you for your download req ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_CONTENT_USER` | `APROC_DOWNLOAD_REQUEST_CONTENT_USER` | `` |  | `"\"ARLAS Services: Dear {arlas-user-email}. <br>Yo ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_SUBJECT_ADMIN` | `APROC_DOWNLOAD_REQUEST_SUBJECT_ADMIN` | `` |  | `"\"ARLAS Services: {arlas-user-email} requested th ...` in `conf/aias.env` |
| `APROC_DOWNLOAD_REQUEST_CONTENT_ADMIN` | `APROC_DOWNLOAD_REQUEST_CONTENT_ADMIN` | `` |  | `"\"ARLAS Services: {arlas-user-email} requested th ...` in `conf/aias.env` |
| `APROC_EMAIL_PATH_PREFIX_ADD` | `APROC_EMAIL_PATH_PREFIX_ADD` | `` |  | `"/tmp/"` in `conf/aias.env` |
| `APROC_PATH_TO_WINDOWS` | `APROC_PATH_TO_WINDOWS` | `` |  | `false` in `conf/aias.env` |
| `ARLAS_URL_SEARCH` | `ARLAS_URL_SEARCH` | `` |  | `"http://arlas-server:9999/arlas/explore/{collectio ...` in `conf/aias.env` |
| `AIRS_INDEX_COLLECTION_PREFIX` | `AIRS_INDEX_COLLECTION_PREFIX` | `` |  |  |
| `APROC_INDEX_ENDPOINT_URL` | `http://elasticsearch:9200` | `` |  |  |
| `APROC_INDEX_NAME` | `APROC_INDEX_NAME` | `` |  | `aproc_downloads` in `conf/aias.env` |
| `APROC_RESOURCE_ID_HASH_STARTS_AT` | `3` | `` |  |  |

List of volumes:
- ${APROC_INPUT_DIR}:/inputs:ro
- ${PWD}/conf/aias/drivers.yaml:/app/conf/drivers.yaml:ro
## File dc/ref-dc-aias-fam-wui.yaml
### Service arlas-fam-wui
Description: ARLAS FAM is the ARLAS File and Archive Management interface. It allows exploration and registration of archives found in a directory.

Image: `ARLAS_VERSION_FAM_WUI` with `gisaia/arlas-fam-wui:0.4.17` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `FAM_WUI_BASE_HREF` | `/fam-wui` | `` |  |  |
| `ARLAS_USE_AUTHENT` | `true` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `iam` | `` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `ARLAS_AUTHENT_THRESHOLD` | `60000` | `` |  |  |
| `ARLAS_AUTHENT_SIGN_UP_ENABLED` | `false` | `` |  |  |
| `ARLAS_TAB_NAME` | `"ARLAS FAM Wui"` | `` |  |  |
| `FAM_SERVER_URL` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `FAM_DEFAULT_PATH` | `''` | `` |  |  |
| `FAM_COLLECTION` | `AIRS_COLLECTION` | `` |  | `main` in `conf/aias.env` |
| `FAM_ARCHIVES_PAGES_SIZE` | `FAM_ARCHIVES_PAGES_SIZE` | `` |  |  |
| `FAM_FILES_PAGES_SIZE` | `FAM_FILES_PAGES_SIZE` | `` |  |  |
| `APROC_SERVER_URL` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `APROC_COLLECTION` | `AIRS_COLLECTION` | `` |  | `main` in `conf/aias.env` |
| `APROC_CATALOG` | `AIAS_CATALOG_NAME` | `` |  |  |
| `AIRS_SERVER_URL` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `AIRS_COLLECTION` | `AIRS_COLLECTION` | `` |  | `main` in `conf/aias.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_FAM_LINKS` | `` |  | `'` in `conf/aias.env` |
## File dc/ref-dc-aias-fam.yaml
### Service fam-service
Description: ARLAS FAM is the ARLAS File and Archive Management service. It allows exploration and registration of archives found in a directory.

Image: `ARLAS_VERSION_FAM` with `gisaia/fam:0.4.17` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `FAM_LOGGER_LEVEL` | `FAM_LOGGER_LEVEL` | `INFO` |  |  |
| `FAM_PREFIX` | `/fam` | `` |  |  |
| `INGESTED_FOLDER` | `/inputs` | `` |  |  |
| `APROC_RESOURCE_ID_HASH_STARTS_AT` | `3` | `` |  |  |

List of volumes:
- ${APROC_INPUT_DIR}:/inputs:ro
- ${PWD}/conf/aias/drivers.yaml:/app/conf/drivers.yaml:ro
## File dc/ref-dc-aias-minio.yaml
### Service minio
Description: Minio is an object store

Image: `ARLAS_VERSION_MINIO` with `minio/minio:RELEASE.2024-10-02T17-50-41Z` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `MINIO_BROWSER` | `off` | `` |  |  |
| `MINIO_ROOT_PASSWORD` | `MINIO_ROOT_PASSWORD` | `` |  | `airssecret` in `conf/minio.env` |
| `MINIO_ROOT_USER` | `MINIO_ROOT_USER` | `` |  | `airs` in `conf/minio.env` |

List of volumes:
- ${AIRS_STORAGE_DIRECTORY:-arlas-data-minio}:/data
## File dc/ref-dc-aias-rabbitmq.yaml
### Service rabbitmq
Image: `ARLAS_VERSION_RABBITMQ` with `rabbitmq:3.13.2-management-alpine` in `conf/versions.env`


List of volumes:
- arlas-data-rabbimq:/var/lib/rabbitmq/mnesia
## File dc/ref-dc-aias-redis.yaml
### Service redis
Image: `ARLAS_VERSION_REDIS` with `redis/redis-stack:7.2.0-v10` in `conf/versions.env`


List of volumes:
- arlas-data-redis:/data
## File dc/ref-dc-aias-volumes.yaml
## File dc/ref-dc-aias-agate.yaml
### Service agate
Description: AGATE is a forward authorization service for accessing resources such as images

Image: `ARLAS_VERSION_AGATE` with `gisaia/agate:0.4.17` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `AGATE_LOGGER_LEVEL` | `AGATE_LOGGER_LEVEL` | `INFO` |  |  |
| `ARLAS_URL_SEARCH` | `ARLAS_URL_SEARCH` | `` |  | `"http://arlas-server:9999/arlas/explore/{collectio ...` in `conf/aias.env` |
| `AGATE_PREFIX` | `/agate` | `` |  |  |
| `AGATE_HOST` | `AGATE_HOST` | `0.0.0.0` |  |  |
| `AGATE_PORT` | `AGATE_PORT` | `8004` |  |  |
| `AGATE_URL_HEADER` | `X-Forwarded-Uri` | `` |  |  |
| `AGATE_URL_HEADER_PREFIX` | `AIRS_S3_BUCKET` | `` |  | `airs` in `conf/aias.env` |
| `ASSET_MINIO_PATTERN` | `"/(?P<collection>[^/]+)/items/(?P<item>[^/]+)/asse ...` | `` |  |  |
| `ASSET_MINIO_PUBLIC_PATTERN` | `"/(?P<collection>[^/]+)/items/(?P<item>[^/]+)/asse ...` | `` |  |  |
