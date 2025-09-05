## Services:
- [elasticsearch](#service-elasticsearch)
- [arlas-server](#service-arlas-server)
- [arlas-persistence-server](#service-arlas-persistence-server)
- [arlas-permissions-server](#service-arlas-permissions-server)
- [keycloak](#service-keycloak)
- [arlas-builder](#service-arlas-builder)
- [arlas-hub](#service-arlas-hub)
- [arlas-wui](#service-arlas-wui)
- [protomaps](#service-protomaps)
- [apisix](#service-apisix)
## File dc/ref-dc-elastic.yaml
### Service elasticsearch
Description: Elasticsearch is an indexing engine

Image: `ELASTIC_VERSION` with `docker.elastic.co/elasticsearch/elasticsearch:8.9. ...` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `discovery.type` | `single-node` | `` |  |  |
| `cluster.name` | `arlas-es-cluster` | `` |  |  |
| `node.name` | `arlas-data-node-1` | `` |  |  |
| `ES_JAVA_OPTS` | `ES_JAVA_OPTS` | `` |  | `"-Xms500m -Xmx500m"` in `conf/elastic.env` |
| `xpack.security.enabled` | `false` | `` |  |  |
| `xpack.security.http.ssl.enabled` | `false` | `` |  |  |
| `xpack.security.transport.ssl.enabled` | `false` | `` |  |  |
| `tracing.apm.enabled` | `false` | `` |  |  |

List of volumes:

- `${ELASTIC_STORAGE:-arlas-data-es}:/usr/share/elasticsearch/data`
## File dc/ref-dc-arlas-server.yaml
### Service arlas-server
Description: ARLAS Server is the geo-analytic engine of the ARLAS Exploration Stack

Image: `ARLAS_SERVER_VERSION` with `gisaia/arlas-server:27.1.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLICY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  Specify a PolicyEnforcer class to load in order to activate Authentication if needed | `io.arlas.filter.impl.KeycloakPolicyEnforcer` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `ARLAS_AUTH_PUBLIC_URIS` | `` |  | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET ...` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERMISSION_URL` | `` |  |  |
| `ARLAS_APP_PATH` | `/` | `` |  |  |
| `ARLAS_BASE_URI` | `ARLAS_BASE_URI` | `http://arlas-server:9999/arlas/` |  Arlas base uri |  |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIMEOUT` | `5` |  TTL in seconds of items in the cache |  |
| `ARLAS_CORS_ALLOWED_HEADERS` | `"arlas-user,arlas-groups,arlas-organization,X-Requ ...` | `` |  Comma-separated list of allowed headers |  |
| `ARLAS_CORS_ENABLED` | `ARLAS_CORS_ENABLED` | `true` |  Whether to configure cors or not |  |
| `ARLAS_ELASTIC_CLUSTER` | `ARLAS_ELASTIC_CLUSTER` | `arlas-es-cluster` |  |  |
| `ARLAS_ELASTIC_CREDENTIALS` | `ELASTIC_USER}:${ELASTIC_PASSWORD` | `` |  |  |
| `ARLAS_ELASTIC_ENABLE_SSL` | `ARLAS_ELASTIC_ENABLE_SSL` | `true` |  use SSL to connect to elasticsearch |  |
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
| `JDK_JAVA_OPTIONS` | `ARLAS_SERVER_JDK_JAVA_OPTIONS` | `` |  | `"-Xmx1g -XX:+ExitOnOutOfMemoryError"` in `conf/arlas.env`<br>`${ARLAS_SERVER_JDK_JAVA_OPTIONS} -Djavax.net.ssl.t ...` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  | `arlas` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  | `arlas-backend` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  | `"rha14c4202RB0Dxlke6ZNCCTw9gkvLJ8"` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  | `https://${ARLAS_HOST}:9443/auth` in `conf/arlas_keycloak.env` |
| `ARLAS_CHECK_ORGANISATIONS` | `ARLAS_CHECK_ORGANISATIONS` | `true` |  | `false` in `conf/arlas.env`<br>`false` in `conf/arlas_keycloak.env` |

List of volumes:

- `${PWD}/conf/arlas-ks.jks:/opt/app/arlas-ks.jks`
## File dc/ref-dc-arlas-persistence-server.yaml
### Service arlas-persistence-server
Description: ARLAS Persistence is a service for storing and retrieving small ojects, such as JSON documents or image previews.

Image: `ARLAS_PERSISTENCE_VERSION` with `gisaia/arlas-persistence-server:27.0.1` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLICY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  | `io.arlas.filter.impl.KeycloakPolicyEnforcer` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `ARLAS_AUTH_PUBLIC_URIS` | `` |  | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET ...` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERMISSION_URL` | `` |  |  |
| `ARLAS_AUTH_ENABLED` | `ARLAS_AUTH_ENABLED` | `false` |  | `true` in `conf/permissions.env` |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIMEOUT` | `5` |  |  |
| `ARLAS_PERSISTENCE_APP_PATH` | `ARLAS_PERSISTENCE_APP_PATH` | `/` |  |  |
| `ARLAS_PERSISTENCE_ENGINE` | `ARLAS_PERSISTENCE_ENGINE` | `hibernate` |  | `file` in `conf/persistence-file.env` |
| `ARLAS_PERSISTENCE_HIBERNATE_PASSWORD` | `POSTGRES_PASSWORD` | `` |  |  |
| `ARLAS_PERSISTENCE_HIBERNATE_URL` | `ARLAS_PERSISTENCE_HIBERNATE_URL` | `jdbc:postgresql://db:5432/arlas` |  |  |
| `ARLAS_PERSISTENCE_HIBERNATE_USER` | `POSTGRES_USER` | `` |  |  |
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
| `JDK_JAVA_OPTIONS` | `ARLAS_PERSISTENCE_JDK_JAVA_OPTIONS` | `` |  | `"-Xmx1g -XX:+ExitOnOutOfMemoryError -Djavax.net.ss ...` in `conf/persistence-file.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  | `arlas` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  | `arlas-backend` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  | `"rha14c4202RB0Dxlke6ZNCCTw9gkvLJ8"` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  | `https://${ARLAS_HOST}:9443/auth` in `conf/arlas_keycloak.env` |

List of volumes:

- `${ARLAS_PERSISTENCE_STORAGE}:/persist/`
- `${PWD}/conf/arlas-ks.jks:/opt/app/arlas-ks.jks`
## File dc/ref-dc-arlas-permissions-server.yaml
### Service arlas-permissions-server
Description: ARLAS Permissions is a service for listing user's permissions

Image: `ARLAS_PERMISSIONS_VERSION` with `gisaia/arlas-permissions-server:27.0.1` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLICY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  | `io.arlas.filter.impl.KeycloakPolicyEnforcer` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERMISSION_URL` | `` |  |  |
| `ARLAS_AUTH_ENABLED` | `ARLAS_AUTH_ENABLED` | `false` |  | `true` in `conf/permissions.env` |
| `ARLAS_PERMISSIONS_APP_PATH` | `/` | `` |  |  |
| `ARLAS_PERMISSIONS_PREFIX` | `/arlas_permissions_server` | `` |  |  |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIMEOUT` | `5` |  |  |
| `ARLAS_PERMISSIONS_LOGGING_CONSOLE_LEVEL` | `ARLAS_PERMISSIONS_LOGGING_CONSOLE_LEVEL` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_PERMISSIONS_LOGGING_LEVEL` | `ARLAS_PERMISSIONS_LOGGING_LEVEL` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `ARLAS_AUTH_PUBLIC_URIS` | `` |  | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET ...` in `conf/arlas_keycloak.env` |
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
| `JDK_JAVA_OPTIONS` | `ARLAS_PERMISSIONS_JDK_JAVA_OPTIONS` | `` |  | `"-Xmx1g -XX:+ExitOnOutOfMemoryError -Djavax.net.ss ...` in `conf/permissions.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  | `arlas` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  | `arlas-backend` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  | `"rha14c4202RB0Dxlke6ZNCCTw9gkvLJ8"` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  | `https://${ARLAS_HOST}:9443/auth` in `conf/arlas_keycloak.env` |

List of volumes:

- `${PWD}/conf/arlas-ks.jks:/opt/app/arlas-ks.jks`
## File dc/ref-dc-keycloak.yaml
### Service keycloak
Image: `KEYCLOAK_VERSION` with `quay.io/keycloak/keycloak:23.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `KC_HEALTH_ENABLED` | `true` | `` |  This is to enable kubernetes healthchecks |  |
| `KEYCLOAK_ADMIN_PASSWORD` | `KEYCLOAK_ADMIN_PASSWORD` | `` |  | `admin` in `conf/arlas_keycloak.env` |
| `KEYCLOAK_ADMIN` | `KEYCLOAK_ADMIN_LOGIN` | `` |  | `admin` in `conf/arlas_keycloak.env` |
| `KC_HTTPS_KEYSTORE_PATH` | `/opt/keycloak/conf/keycloak.jks` | `` |  |  |
| `KC_HTTPS_KEYSTORE_PASSWORD` | `arlaspassword` | `` |  |  |
| `KC_HTTP_ENABLED` | `true` | `` |  |  |
| `KC_HEALTH_ENABLED` | `true` | `` |  |  |

List of volumes:

- `${KEYCLOAK_CONF_DIRECTORY}/keycloak.realm.json:/opt/keycloak/data/import/realm.json:ro`
- `${PWD}/conf/arlas-ks.jks:/opt/keycloak/conf/keycloak.jks:ro`
- `${PWD}/conf/server.crt:/opt/keycloak/conf/server.crt:ro`
- `${PWD}/conf/server.key:/opt/keycloak/conf/server.key:ro`
## File dc/ref-dc-arlas-builder.yaml
### Service arlas-builder
Description: ARLAS Builder is the interface for elaborating ARLAS Dashboards.

Image: `ARLAS_BUILDER_VERSION` with `gisaia/arlas-wui-builder:27.1.0-rc.2` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_CLEAR_HASH` | `true` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_CLIENT_ID` | `` |  | `arlas-front` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `true` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `true` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_FORCE_CONNECT` | `` |  | `false` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_ISSUER` | `` |  | `https://${ARLAS_HOST}:9443/auth/realms/arlas` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_LOGIN_URL` | `ARLAS_AUTHENT_LOGIN_URL` | `` |  |  |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_LOGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_MODE` | `` |  | `openid` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_REDIRECT_URI` | `/builder/callback` |  | `https://${ARLAS_HOST}:443/hub/callback` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_REQUIRE_HTTPS` | `false` |  | `false` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_RESPONSE_TYPE` | `code` |  | `code` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_SCOPE` | `profile` |  | `profile` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_SHOW_DEBUG` | `false` |  | `false` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI-/builder ...` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `10000` |  | `1000` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_STORAGE` | `memorystorage` |  | `memorystorage` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  |  |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `0.75` |  | `0.75` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_USE_DISCOVERY` | `` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_BASEMAPS` | `ARLAS_BASEMAPS` | `[{"name":"Streets-light","url":"https://api.maptiler.com/maps/208a41eb-368f-4003-8e3c-2dba0d90b3cb/style.json?key=xIhbu1RwgdbxfZNmoXn4","image":"https://api.maptiler.com/maps/208a41eb-368f-4003-8e3c-2dba0d90b3cb/0/0/0.png?key=xIhbu1RwgdbxfZNmoXn4"}]` |  | `'[` in `conf/arlas.env` |
| `ARLAS_BUILDER_BASE_HREF` | `ARLAS_BUILDER_BASE_HREF` | `/builder` |  |  |
| `ARLAS_EXTERNAL_NODE_PAGE` | `ARLAS_EXTERNAL_NODE_PAGE` | `true` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERMISSIONS_URL` | `ARLAS_PERMISSIONS_URL` | `/arlas_permissions_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/arlas_persistence_server` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS_HOST}/persist` in `conf/arlas_keycloak.env` |
| `ARLAS_SERVER_URL` | `ARLAS_SERVER_URL` | `/arlas` |  | `https://${ARLAS_HOST}/arlas` in `conf/arlas_keycloak.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_WUI_URL` | `ARLAS_WUI_URL` | `/wui/` |  | `https://${ARLAS_HOST}/wui/` in `conf/arlas_keycloak.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_BUILDER_LINKS` | `` |  | `'` in `conf/arlas.env`<br>`'` in `conf/arlas_keycloak.env` |
| `ARLAS_ENABLE_ADVANCED_FEATURES` | `ARLAS_ENABLE_ADVANCED_FEATURES` | `false` |  |  |

## File dc/ref-dc-arlas-hub.yaml
### Service arlas-hub
Description: ARLAS Hub is the interface for discovering all the available ARLAS Dashboards

Image: `ARLAS_HUB_VERSION` with `gisaia/arlas-wui-hub:27.1.0-rc.2` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_CLEAR_HASH` | `true` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_CLIENT_ID` | `` |  | `arlas-front` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `true` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `true` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_FORCE_CONNECT` | `` |  | `false` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_ISSUER` | `` |  | `https://${ARLAS_HOST}:9443/auth/realms/arlas` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_LOGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_MODE` | `` |  | `openid` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_REDIRECT_URI` | `/hub/callback` |  | `https://${ARLAS_HOST}:443/hub/callback` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_REQUIRE_HTTPS` | `false` |  | `false` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_RESPONSE_TYPE` | `` |  | `code` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_SCOPE` | `` |  | `profile` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_SHOW_DEBUG` | `false` |  | `false` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI-/hub/sil ...` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `10000` |  | `1000` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_STORAGE` | `memorystorage` |  | `memorystorage` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  |  |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `0.75` |  | `0.75` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_USE_DISCOVERY` | `` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_BUILDER_URL` | `ARLAS_BUILDER_URL` | `/builder/` |  | `https://${ARLAS_HOST}/builder/` in `conf/arlas_keycloak.env` |
| `ARLAS_HUB_BASE_HREF` | `ARLAS_HUB_BASE_HREF` | `/hub` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERMISSIONS_URL` | `ARLAS_PERMISSIONS_URL` | `/arlas_permissions_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/persist` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS_HOST}/persist` in `conf/arlas_keycloak.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_WUI_URL` | `ARLAS_WUI_URL` | `/wui/` |  | `https://${ARLAS_HOST}/wui/` in `conf/arlas_keycloak.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_HUB_LINKS` | `` |  | `'` in `conf/arlas.env`<br>`'` in `conf/arlas_keycloak.env` |

## File dc/ref-dc-arlas-wui.yaml
### Service arlas-wui
Description: ARLAS WUI is ARLAS Web interface for visualising an analytic ARLAS Dashboard.

Image: `ARLAS_WUI_VERSION` with `gisaia/arlas-wui:27.1.0-rc.2` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_CLEAR_HASH` | `true` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_CLIENT_ID` | `` |  | `arlas-front` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `true` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `true` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_FORCE_CONNECT` | `` |  | `false` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_ISSUER` | `` |  | `https://${ARLAS_HOST}:9443/auth/realms/arlas` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_LOGIN_URL` | `ARLAS_AUTHENT_LOGIN_URL` | `` |  |  |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_LOGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_MODE` | `` |  | `openid` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_REDIRECT_URI` | `/wui/callback` |  | `https://${ARLAS_HOST}:443/hub/callback` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_REQUIRE_HTTPS` | `false` |  | `false` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_RESPONSE_TYPE` | `code` |  | `code` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_SCOPE` | `profile` |  | `profile` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_SHOW_DEBUG` | `false` |  | `false` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI-/wui/sil ...` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `10000` |  | `1000` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_STORAGE` | `memorystorage` |  | `memorystorage` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  |  |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `0.75` |  | `0.75` in `conf/arlas_keycloak.env` |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_USE_DISCOVERY` | `` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_GEOCODING_FIND_PLACE_URL` | `ARLAS_GEOCODING_FIND_PLACE_URL` | `` |  | empty value in `conf/arlas.env` |
| `ARLAS_GEOCODING_FIND_PLACE_ZOOM_TO` | `ARLAS_GEOCODING_FIND_PLACE_ZOOM_TO` | `10` |  |  |
| `ARLAS_HUB_URL` | `ARLAS_HUB_URL` | `/hub/` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/arlas_persistence_server` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS_HOST}/persist` in `conf/arlas_keycloak.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_keycloak.env` |
| `ARLAS_WUI_BASE_HREF` | `ARLAS_WUI_BASE_HREF` | `/wui` |  |  |
| `PUBLIC_HOST` | `ARLAS_HOST` | `` |  | `issarbe` in `conf/stack.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_WUI_LINKS` | `` |  | `'` in `conf/arlas.env`<br>`'` in `conf/arlas_keycloak.env` |
| `ARLAS_DOWNLOAD_PROCESS_URL` | `ARLAS_DOWNLOAD_PROCESS_URL` | `` |  | `/aproc/processes/download/execution` in `conf/arlas.env` |
| `ARLAS_DOWNLOAD_PROCESS_CHECK_URL` | `ARLAS_DOWNLOAD_PROCESS_CHECK_URL` | `` |  | `/aproc/processes/download` in `conf/arlas.env` |
| `ARLAS_DOWNLOAD_PROCESS_MAX_ITEMS` | `ARLAS_DOWNLOAD_PROCESS_MAX_ITEMS` | `` |  |  |
| `ARLAS_DOWNLOAD_PROCESS_SETTINGS_URL` | `ARLAS_DOWNLOAD_PROCESS_SETTINGS_URL` | `` |  |  |
| `ARLAS_DOWNLOAD_PROCESS_STATUS_URL` | `ARLAS_DOWNLOAD_PROCESS_STATUS_URL` | `` |  | `/aproc/jobs` in `conf/arlas.env` |
| `ARLAS_ENRICH_PROCESS_URL` | `ARLAS_ENRICH_PROCESS_URL` | `` |  | `/aproc/processes/enrich/execution` in `conf/arlas.env` |
| `ARLAS_ENRICH_PROCESS_CHECK_URL` | `ARLAS_ENRICH_PROCESS_CHECK_URL` | `` |  | `/aproc/processes/enrich` in `conf/arlas.env` |
| `ARLAS_ENRICH_PROCESS_MAX_ITEMS` | `ARLAS_ENRICH_PROCESS_MAX_ITEMS` | `` |  |  |
| `ARLAS_ENRICH_PROCESS_SETTINGS_URL` | `ARLAS_ENRICH_PROCESS_SETTINGS_URL` | `` |  |  |
| `ARLAS_ENRICH_PROCESS_STATUS_URL` | `ARLAS_ENRICH_PROCESS_STATUS_URL` | `` |  | `/aproc/jobs` in `conf/arlas.env` |

List of volumes:

- `${PWD}/conf/protomaps/styles:/usr/share/nginx/html/assets/basemap/styles`
- `${PWD}/conf/protomaps/glyphs:/usr/share/nginx/html/assets/basemap/glyphs`
- `${PWD}/conf/protomaps/quicklook:/usr/share/nginx/html/assets/basemap/quicklook`
- `${PWD}/conf/protomaps/world.pmtiles:/usr/share/nginx/html/assets/basemap/world.pmtiles`
- `${PWD}/conf/wui/custom-style.css:/usr/share/nginx/html/assets/styles/custom-style.css`
## File dc/ref-dc-protomaps.yaml
### Service protomaps
Image: `PROTOMAP_VERSION` with `protomaps/go-pmtiles:v1.28.0` in `conf/versions.env`


List of volumes:

- `${PWD}/conf/protomaps/world.pmtiles:/protomaps/basemaps/world.pmtiles:ro`
## File dc/ref-dc-apisix.yaml
### Service apisix
Description: APISIX is ARLAS Stack gateway. It handles all the incoming trafic.

Image: `APISIX_VERSION` with `apache/apisix:3.12.0-debian` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APISIX_STAND_ALONE` | `APISIX_STAND_ALONE` | `true` |  | `true` in `conf/apisix.env` |

List of volumes:

- `${PWD}/conf/apisix/config.yaml:/usr/local/apisix/conf/config.yaml`
- `${PWD}/conf/apisix/apisix.yaml:/usr/local/apisix/conf/apisix.yaml`
