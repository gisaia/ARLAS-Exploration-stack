## Services:
- [elasticsearch](#service-elasticsearch)
- [arlas-server](#service-arlas-server)
- [arlas-persistence-server](#service-arlas-persistence-server)
- [arlas-permissions-server](#service-arlas-permissions-server)
- [auth-server](#service-auth-server)
- [arlas-wui-iam](#service-arlas-wui-iam)
- [arlas-builder](#service-arlas-builder)
- [arlas-hub](#service-arlas-hub)
- [arlas-wui](#service-arlas-wui)
- [protomaps](#service-protomaps)
- [apisix](#service-apisix)
- [db](#service-db)
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

Image: `ARLAS_SERVER_VERSION` with `gisaia/arlas-server:25.1.0` in `conf/versions.env`

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

Image: `ARLAS_PERSISTENCE_VERSION` with `gisaia/arlas-persistence-server:25.0.0` in `conf/versions.env`

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
- ${ARLAS_PERSISTENCE_LOCAL_FOLDER_HOST:-/tmp/persist/}:/persist/:rw
## File dc/ref-dc-arlas-permissions-server.yaml
### Service arlas-permissions-server
Description: ARLAS Permissions is a service for listing user's permissions

Image: `ARLAS_PERMISSIONS_VERSION` with `gisaia/arlas-permissions-server:25.0.0` in `conf/versions.env`

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
### Service auth-server
Description: ARLAS IAM is the ARLAS Identity and Access Management service.

Image: `ARLAS_IAM_SERVER_VERSION` with `docker.cloudsmith.io/gisaia/private/arlas-iam-serv ...` in `conf/versions.env`

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
| `ARLAS_SMTP_ACTIVATED` | `ARLAS_SMTP_ACTIVATED` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_SMTP_FROM` | `ARLAS_SMTP_FROM` | `` |  | empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_HOST` | `ARLAS_SMTP_HOST` | `` |  | empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PASSWORD` | `ARLAS_SMTP_PASSWORD` | `` |  | empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PORT` | `ARLAS_SMTP_PORT` | `25` |  |  |
| `ARLAS_SMTP_RESET_LINK` | `HOST` | `` |  | `localhost` in `conf/stack.env` |
| `ARLAS_SMTP_USERNAME` | `ARLAS_SMTP_USERNAME` | `` |  | empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_VERIFY_LINK` | `HOST` | `` |  | `localhost` in `conf/stack.env` |
| `JDK_JAVA_OPTIONS` | `ARLAS_IAM_JDK_JAVA_OPTIONS` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  |  |
## File dc/ref-dc-iam-wui.yaml
### Service arlas-wui-iam
Description: ARLAS IAM is the ARLAS Identity and Access Management web interface.

Image: `ARLAS_WUI_IAM_VERSION` with `docker.cloudsmith.io/gisaia/private/arlas-wui-iam: ...` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_MODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` | `` |  |  |
| `ARLAS_TAB_NAME` | `"ARLAS Wui IAM"` | `` |  |  |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_IAM_APP_PATH` | `/iam` | `` |  |  |
| `ARLAS_WUI_IAM_BASE_HREF` | `/iam` | `` |  |  |
## File dc/ref-dc-arlas-builder.yaml
### Service arlas-builder
Description: ARLAS Builder is the interface for elaborating ARLAS Dashboards.

Image: `ARLAS_BUILDER_VERSION` with `gisaia/arlas-wui-builder:25.1.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_CLEAR_HASH` | `true` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_CLIENT_ID` | `` |  |  |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `true` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `true` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_FORCE_CONNECT` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_ISSUER` | `` |  |  |
| `ARLAS_AUTHENT_LOGIN_URL` | `ARLAS_AUTHENT_LOGIN_URL` | `` |  | `https://localhost/hub/login` in `conf/arlas_iam.env` |
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
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/arlas_persistence_server` |  | `/persist` in `conf/persistence-file.env`<br>`https://localhost/persist` in `conf/arlas_iam.env` |
| `ARLAS_SERVER_URL` | `ARLAS_SERVER_URL` | `/arlas` |  | `https://localhost/arlas` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_URL` | `ARLAS_WUI_URL` | `/wui/` |  | `https://localhost/wui/` in `conf/arlas_iam.env` |
## File dc/ref-dc-arlas-hub.yaml
### Service arlas-hub
Description: ARLAS Hub is the interface for discovering all the available ARLAS Dashboards

Image: `ARLAS_HUB_VERSION` with `gisaia/arlas-wui-hub:25.1.0` in `conf/versions.env`

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
| `ARLAS_BUILDER_URL` | `ARLAS_BUILDER_URL` | `/builder/` |  | `https://localhost/builder/` in `conf/arlas_iam.env` |
| `ARLAS_HUB_BASE_HREF` | `ARLAS_HUB_BASE_HREF` | `/hub` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERMISSIONS_URL` | `ARLAS_PERMISSIONS_URL` | `/arlas_permissions_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/persist` |  | `/persist` in `conf/persistence-file.env`<br>`https://localhost/persist` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_URL` | `ARLAS_WUI_URL` | `/wui/` |  | `https://localhost/wui/` in `conf/arlas_iam.env` |
## File dc/ref-dc-arlas-wui.yaml
### Service arlas-wui
Description: ARLAS WUI is ARLAS Web interface for visualising an analytic ARLAS Dashboard.

Image: `ARLAS_WUI_VERSION` with `gisaia/arlas-wui:25.1.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_CLEAR_HASH` | `true` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_CLIENT_ID` | `` |  |  |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `true` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `true` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_FORCE_CONNECT` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_ISSUER` | `` |  |  |
| `ARLAS_AUTHENT_LOGIN_URL` | `ARLAS_AUTHENT_LOGIN_URL` | `` |  | `https://localhost/hub/login` in `conf/arlas_iam.env` |
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
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/arlas_persistence_server` |  | `/persist` in `conf/persistence-file.env`<br>`https://localhost/persist` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_BASE_HREF` | `ARLAS_WUI_BASE_HREF` | `/wui` |  |  |
| `PUBLIC_HOST` | `HOST` | `` |  | `localhost` in `conf/stack.env` |
## File dc/ref-dc-protomaps.yaml
### Service protomaps
Image: `PROTOMAP_VERSION` with `protomaps/go-pmtiles:v1.19.0` in `conf/versions.env`


List of volumes:
- ${PROTOMAP_DATA_DIR}/world.pmtiles:/protomaps/basemaps/world.pmtiles:ro
## File dc/ref-dc-apisix.yaml
### Service apisix
Description: APISIX is ARLAS Stack gateway. It handles all the incoming trafic.

Image: `APISIX_VERSION` with `apache/apisix:3.8.0-debian` in `conf/versions.env`

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
- ${POSTGRES_BACKUP_DIR}/postgresql/:/backup/
- ${POSTGRES_CREATE_TABLE}:/docker-entrypoint-initdb.d/createTable.sql:ro
- ${POSTGRES_CRON}:/usr/local/bin/arlas/pg_backup_rotated.sh:ro
- ${POSTGRES_DATA_DIR}:/var/lib/postgresql/data
