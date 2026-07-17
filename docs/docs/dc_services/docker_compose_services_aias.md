## Services:
- [elasticsearch](#service-elasticsearch)
- [arlas-server](#service-arlas-server)
- [init-arlas-persistence-server-volume](#service-init-arlas-persistence-server-volume)
- [arlas-persistence-server](#service-arlas-persistence-server)
- [arlas-permissions-server](#service-arlas-permissions-server)
- [arlas-iam-server](#service-arlas-iam-server)
- [arlas-wui-iam](#service-arlas-wui-iam)
- [arlas-builder](#service-arlas-builder)
- [arlas-hub](#service-arlas-hub)
- [arlas-wui](#service-arlas-wui)
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

Image: `ARLAS_SERVER_VERSION` with `gisaia/arlas-server:28.0.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLICY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  Specify a PolicyEnforcer class to load in order to activate Authentication if needed | `io.arlas.filter.impl.HTTPPolicyEnforcer` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `ARLAS_AUTH_PUBLIC_URIS` | `` |  | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERMISSION_URL` | `` |  | `http://arlas-iam-server:9998/arlas_iam_server/perm ...` in `conf/arlas_iam.env` |
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
| `JDK_JAVA_OPTIONS` | `ARLAS_SERVER_JDK_JAVA_OPTIONS` | `` |  | `"-Xmx1g -XX:+ExitOnOutOfMemoryError"` in `conf/arlas.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  |  |
| `ARLAS_CHECK_ORGANISATIONS` | `ARLAS_CHECK_ORGANISATIONS` | `true` |  | `false` in `conf/arlas.env`<br>`true` in `conf/arlas_iam.env` |

List of volumes:

- `${PWD}/conf/arlas-ks.jks:/opt/app/arlas-ks.jks`
## File dc/ref-dc-arlas-persistence-server.yaml
### Service init-arlas-persistence-server-volume
Image: `alpine`


List of volumes:

- `${ARLAS_PERSISTENCE_STORAGE}:/data`
### Service arlas-persistence-server
Description: ARLAS Persistence is a service for storing and retrieving small ojects, such as JSON documents or image previews.

Image: `ARLAS_PERSISTENCE_VERSION` with `gisaia/arlas-persistence-server:28.0.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLICY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  | `io.arlas.filter.impl.HTTPPolicyEnforcer` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `ARLAS_AUTH_PUBLIC_URIS` | `` |  | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERMISSION_URL` | `` |  | `http://arlas-iam-server:9998/arlas_iam_server/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_ENABLED` | `ARLAS_AUTH_ENABLED` | `false` |  | `true` in `conf/permissions.env`<br>`true` in `conf/arlas_iam.env` |
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
| `JDK_JAVA_OPTIONS` | `ARLAS_PERSISTENCE_JDK_JAVA_OPTIONS` | `` |  | `"-Xmx1g -XX:+ExitOnOutOfMemoryError -Djavax.net.ss ...` in `conf/persistence-file.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  |  |

List of volumes:

- `${ARLAS_PERSISTENCE_STORAGE}:/persist/`
- `${PWD}/conf/arlas-ks.jks:/opt/app/arlas-ks.jks`
## File dc/ref-dc-arlas-permissions-server.yaml
### Service arlas-permissions-server
Description: ARLAS Permissions is a service for listing user's permissions

Image: `ARLAS_PERMISSIONS_VERSION` with `gisaia/arlas-permissions-server:28.0.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLICY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  | `io.arlas.filter.impl.HTTPPolicyEnforcer` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERMISSION_URL` | `` |  | `http://arlas-iam-server:9998/arlas_iam_server/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_ENABLED` | `ARLAS_AUTH_ENABLED` | `false` |  | `true` in `conf/permissions.env`<br>`true` in `conf/arlas_iam.env` |
| `ARLAS_PERMISSIONS_APP_PATH` | `/` | `` |  |  |
| `ARLAS_PERMISSIONS_PREFIX` | `/arlas_permissions_server` | `` |  |  |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIMEOUT` | `5` |  |  |
| `ARLAS_PERMISSIONS_LOGGING_CONSOLE_LEVEL` | `ARLAS_PERMISSIONS_LOGGING_CONSOLE_LEVEL` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_PERMISSIONS_LOGGING_LEVEL` | `ARLAS_PERMISSIONS_LOGGING_LEVEL` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `ARLAS_AUTH_PUBLIC_URIS` | `` |  | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET ...` in `conf/arlas_iam.env` |
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
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  |  |

List of volumes:

- `${PWD}/conf/arlas-ks.jks:/opt/app/arlas-ks.jks`
## File dc/ref-dc-iam-server.yaml
### Service arlas-iam-server
Description: ARLAS IAM is the ARLAS Identity and Access Management service.

Image: `ARLAS_IAM_SERVER_VERSION` with `gisaia/arlas-iam-server:28.0.2` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_ACCESS_TOKEN_TTL` | `600000` | `` |  |  |
| `ARLAS_ANONYMOUS_VALUE` | `ARLAS_ANONYMOUS_VALUE` | `anonymous` |  |  |
| `ARLAS_AUTH_INIT_ADMIN` | `ARLAS_AUTH_INIT_ADMIN` | `` |  | `tech@gisaia.com` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_INIT_PASSWORD` | `ARLAS_AUTH_INIT_PASSWORD` | `` |  | `admin` in `conf/arlas_iam.env` |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIMEOUT` | `5` |  |  |
| `ARLAS_IAM_CACHE_FACTORY_CLASS` | `ARLAS_IAM_CACHE_FACTORY_CLASS` | `io.arlas.commons.cache.NoCacheFactory` |  |  |
| `ARLAS_IAM_HIBERNATE_HBM2DDL` | `ARLAS_IAM_HIBERNATE_HBM2DDL` | `create-only` |  | `create-only` in `conf/arlas_iam.env` |
| `ARLAS_IAM_HIBERNATE_PASSWORD` | `POSTGRES_PASSWORD` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `ARLAS_IAM_HIBERNATE_URL` | `ARLAS_IAM_HIBERNATE_URL` | `jdbc:postgresql://db:5432/arlas` |  |  |
| `ARLAS_IAM_HIBERNATE_USER` | `POSTGRES_USER` | `` |  | `pg-user` in `conf/postgres.env` |
| `ARLAS_IAM_LOGGING_CONSOLE_LEVEL` | `ARLAS_IAM_LOGGING_CONSOLE_LEVEL` | `` |  | `INFO` in `conf/arlas_iam.env` |
| `ARLAS_IAM_LOGGING_LEVEL` | `ARLAS_IAM_LOGGING_LEVEL` | `` |  | `INFO` in `conf/arlas_iam.env` |
| `ARLAS_IAM_PORT` | `ARLAS_IAM_PORT` | `9998` |  |  |
| `ARLAS_IAM_VERIFY_EMAIL` | `ARLAS_IAM_VERIFY_EMAIL` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_REFRESH_TOKEN_TTL` | `600000` | `` |  |  |
| `ARLAS_SERVER_URL` | `"http://arlas-server:9999/arlas"` | `` |  |  |
| `ARLAS_SMTP_ACTIVATED` | `ARLAS_SMTP_ACTIVATED` | `` |  | `false` in `conf/aias.env`<br>`false` in `conf/arlas_iam.env` |
| `ARLAS_SMTP_FROM` | `ARLAS_SMTP_FROM` | `` |  | `tobechanged@tobechanged.io` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_HOST` | `ARLAS_SMTP_HOST` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PASSWORD` | `ARLAS_SMTP_PASSWORD` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PORT` | `ARLAS_SMTP_PORT` | `25` |  | `25` in `conf/aias.env` |
| `ARLAS_SMTP_RESET_LINK` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `ARLAS_SMTP_USERNAME` | `ARLAS_SMTP_USERNAME` | `` |  | `tobechanged` in `conf/aias.env`<br>empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_VERIFY_LINK` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `JDK_JAVA_OPTIONS` | `ARLAS_IAM_JDK_JAVA_OPTIONS` | `` |  | `"-Xmx1g -XX:+ExitOnOutOfMemoryError -Djavax.net.ss ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYCLOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYCLOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYCLOAK_URL` | `` |  |  |

List of volumes:

- `${PWD}/conf/truststore.p12:/opt/app/truststore.p12:ro`
## File dc/ref-dc-iam-wui.yaml
### Service arlas-wui-iam
Description: ARLAS IAM is the ARLAS Identity and Access Management web interface.

Image: `ARLAS_WUI_IAM_VERSION` with `gisaia/arlas-wui-iam:28.0.0` in `conf/versions.env`

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

Image: `ARLAS_BUILDER_VERSION` with `gisaia/arlas-wui-builder:28.0.1` in `conf/versions.env`

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
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_REDIRECT_URI` | `/builder/callback` |  |  |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_REQUIRE_HTTPS` | `false` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_RESPONSE_TYPE` | `code` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_SCOPE` | `profile` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_SHOW_DEBUG` | `false` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI-/builder ...` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `10000` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_STORAGE` | `memorystorage` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `0.75` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_USE_DISCOVERY` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_BASEMAPS` | `ARLAS_BASEMAPS` | `[{"name":"Streets-light","url":"https://api.maptiler.com/maps/208a41eb-368f-4003-8e3c-2dba0d90b3cb/style.json?key=xIhbu1RwgdbxfZNmoXn4","image":"https://api.maptiler.com/maps/208a41eb-368f-4003-8e3c-2dba0d90b3cb/0/0/0.png?key=xIhbu1RwgdbxfZNmoXn4"}]` |  | `'[` in `conf/arlas.env` |
| `ARLAS_BUILDER_BASE_HREF` | `ARLAS_BUILDER_BASE_HREF` | `/builder` |  |  |
| `ARLAS_EXTERNAL_NODE_PAGE` | `ARLAS_EXTERNAL_NODE_PAGE` | `true` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVER_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERMISSIONS_URL` | `ARLAS_PERMISSIONS_URL` | `/arlas_permissions_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTENCE_URL` | `/arlas_persistence_server` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS_HOST}/persist` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHENT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_URL` | `ARLAS_WUI_URL` | `/wui/` |  | `https://${ARLAS_HOST}/wui/` in `conf/arlas_iam.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_BUILDER_LINKS` | `` |  | `'` in `conf/arlas.env` |
| `ARLAS_TERRAIN` | `ARLAS_TERRAIN` | `` |  | `'{` in `conf/arlas.env` |
| `ARLAS_ENABLE_ADVANCED_FEATURES` | `ARLAS_ENABLE_ADVANCED_FEATURES` | `false` |  |  |
| `ARLAS_SERVER_URL` | `ARLAS_SERVER_URL` | `/arlas` |  | `/arlas` in `conf/arlas.env` |

## File dc/ref-dc-arlas-hub.yaml
### Service arlas-hub
Description: ARLAS Hub is the interface for discovering all the available ARLAS Dashboards

Image: `ARLAS_HUB_VERSION` with `gisaia/arlas-wui-hub:28.0.2` in `conf/versions.env`

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
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_REDIRECT_URI` | `/hub/callback` |  |  |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_REQUIRE_HTTPS` | `false` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_RESPONSE_TYPE` | `` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_SCOPE` | `` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_SHOW_DEBUG` | `false` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI-/hub/sil ...` | `` |  |  |
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
| `ARLAS_SERVER_URL` | `ARLAS_SERVER_URL` | `/arlas` |  | `/arlas` in `conf/arlas.env` |

## File dc/ref-dc-arlas-wui.yaml
### Service arlas-wui
Description: ARLAS WUI is ARLAS Web interface for visualising an analytic ARLAS Dashboard.

Image: `ARLAS_WUI_VERSION` with `gisaia/arlas-wui:28.0.3` in `conf/versions.env`

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
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI-/wui/sil ...` | `` |  |  |
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
| `ARLAS_SERVER_URL` | `ARLAS_SERVER_URL` | `/arlas` |  | `/arlas` in `conf/arlas.env` |

List of volumes:

- `${PWD}/conf/wui/custom-style.css:/usr/share/nginx/html/assets/styles/custom-style.css`
- `${PWD}/conf/wui/custom/:/usr/share/nginx/html/assets/i18n/custom/:ro`
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
## File dc/ref-dc-postgres.yaml
### Service db
Image: `POSTGRES_VERSION` with `postgres:16.8` in `conf/versions.env`

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

- `${POSTGRES_BACKUP_STORAGE}:/backup/`
- `${POSTGRES_CREATE_TABLE}:/docker-entrypoint-initdb.d/createTable.sql:ro`
- `${POSTGRES_CRON}:/usr/local/bin/arlas/pg_backup_rotated.sh:ro`
- `${POSTGRES_STORAGE}:/var/lib/postgresql/data`
## File dc/ref-dc-aias-airs.yaml
### Service airs-server
Description: AIRS Server is ARLAS Item registration service. It exposes a STAC-T interface for registering item and assets in ARLAS, such as Earth Observation products.

Image: `ARLAS_VERSION_AIRS` with `gisaia/airs:0.16.3` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `AIRS_COLLECTION_URL` | `AIRS_COLLECTION_URL` | `https://raw.githubusercontent.com/gisaia/ARLAS-EO/v0.0.6/collection.json` |  |  |
| `AIRS_CORS_HEADERS` | `AIRS_CORS_HEADERS` | `*` |  |  |
| `AIRS_CORS_METHODS` | `AIRS_CORS_METHODS` | `*` |  |  |
| `AIRS_CORS_ORIGINS` | `AIRS_CORS_ORIGINS` | `*` |  |  |
| `AIRS_HOST` | `AIRS_HOST` | `0.0.0.0` |  |  |
| `AIRS_INDEX_COLLECTION_PREFIX` | `AIRS_INDEX_COLLECTION_PREFIX` | `airs` |  | `org.com@airs` in `conf/aias.env` |
| `AIRS_INDEX_ENDPOINT_URL` | `AIRS_INDEX_ENDPOINT_URL` | `` |  | `https://elasticsearch:9200` in `conf/aias.env` |
| `AIRS_INDEX_LOGIN` | `ELASTIC_USER` | `` |  | `elastic` in `conf/elastic.env` |
| `AIRS_INDEX_PWD` | `ELASTIC_PASSWORD` | `` |  | `elastic` in `conf/elastic.env` |
| `AIRS_LOGGER_LEVEL` | `AIRS_LOGGER_LEVEL` | `` |  | `INFO` in `conf/aias.env` |
| `ACCESS_LOGGER_LEVEL` | `ACCESS_LOGGER_LEVEL` | `INFO` |  |  |
| `ARLASEO_MAPPING_URL` | `ARLASEO_MAPPING_URL` | `/app/conf/mapping.json` |  | `https://raw.githubusercontent.com/gisaia/ARLAS-EO/ ...` in `conf/aias.env` |
| `AIRS_PORT` | `AIRS_PORT` | `8000` |  |  |
| `AIRS_PREFIX` | `AIRS_PREFIX` | `/airs` |  |  |
| `AIRS_S3_ACCESS_KEY_ID` | `AIRS_S3_ACCESS_KEY_ID` | `` |  | `airs` in `conf/aias.env` |
| `AIRS_S3_ASSET_HTTP_ENDPOINT_URL` | `AIRS_S3_ASSET_HTTP_ENDPOINT_URL` | `` |  | `http://minio:9000/{}/{}` in `conf/aias.env` |
| `AIRS_S3_BUCKET` | `AIRS_S3_BUCKET` | `airs-storage` |  | `airs-storage` in `conf/aias.env` |
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

List of volumes:

- `${PWD}/conf/aias/airs.yaml:/app/conf/airs.yaml:ro`
## File dc/ref-dc-aias-aproc-proc.yaml
### Service aproc-proc
Description: ARLAS PROC is a worker, based on celery. Used for ingesting and downloading EO products.

Image: `ARLAS_VERSION_APROC_PROC` with `gisaia/aproc-proc:0.16.3` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APROC_LOGGER_LEVEL` | `APROC_LOGGER_LEVEL` | `INFO` |  | `INFO` in `conf/aias.env` |
| `ACCESS_LOGGER_LEVEL` | `ACCESS_LOGGER_LEVEL` | `INFO` |  |  |
| `APROC_CONFIGURATION_FILE` | `/app/conf/aproc.yaml` | `` |  |  |
| `CELERY_BROKER_URL` | `pyamqp://guest:guest@rabbitmq:5672//` | `` |  |  |
| `CELERY_RESULT_BACKEND` | `redis://redis:6379/0` | `` |  |  |
| `AIRS_ENDPOINT` | `http://airs-server:8000/airs` | `` |  |  |
| `APROC_ENDPOINT_FROM_APROC` | `http://aproc-service:8001/aproc` | `` |  |  |
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
| `QUEUE_NAMES` | `QUEUE_NAMES` | `` |  | `small_task_queue,medium_task_queue,large_task_queu ...` in `conf/aias.env` |
| `ARLAS_URL_SEARCH` | `ARLAS_URL_SEARCH` | `` |  | `"http://arlas-server:9999/arlas/explore/{collectio ...` in `conf/aias.env` |
| `AIRS_INDEX_COLLECTION_PREFIX` | `AIRS_INDEX_COLLECTION_PREFIX` | `` |  | `org.com@airs` in `conf/aias.env` |
| `APROC_INDEX_ENDPOINT_URL` | `AIRS_INDEX_ENDPOINT_URL` | `` |  | `https://elasticsearch:9200` in `conf/aias.env` |
| `APROC_INDEX_NAME` | `APROC_INDEX_NAME` | `` |  | `aproc_downloads` in `conf/aias.env` |
| `APROC_INDEX_LOGIN` | `ELASTIC_USER` | `` |  | `elastic` in `conf/elastic.env` |
| `APROC_INDEX_PWD` | `ELASTIC_PASSWORD` | `` |  | `elastic` in `conf/elastic.env` |
| `APROC_RESOURCE_ID_HASH_STARTS_AT` | `3` | `` |  |  |
| `TMP_FOLDER` | `"/tmp"` | `` |  |  |
| `DOWNLOAD_S3_ENDPOINT_URL` | `DOWNLOAD_S3_ENDPOINT_URL` | `http://minio:9000` |  |  |
| `DOWNLOAD_S3_BUCKET` | `DOWNLOAD_S3_BUCKET` | `` |  | `downloads` in `conf/aias.env` |
| `DOWNLOAD_S3_ACCESS_KEY_ID` | `DOWNLOAD_S3_ACCESS_KEY_ID` | `airs` |  |  |
| `DOWNLOAD_S3_SECRET_ACCESS_KEY` | `DOWNLOAD_S3_SECRET_ACCESS_KEY` | `airssecret` |  |  |
| `DOWNLOAD_S3_ASSET_HTTP_ENDPOINT_URL` | `DOWNLOAD_S3_ASSET_HTTP_ENDPOINT_URL` | `http://minio:9000/{}/{}` |  |  |
| `CLEAN_DOWNLOAD_OUTBOX_DIR` | `CLEAN_DOWNLOAD_OUTBOX_DIR` | `True` |  |  |
| `INGESTED_FOLDER` | `INGESTED_FOLDER` | `/inputs` |  | `https://storage.googleapis.com/gisaia-public/OPEND ...` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_TYPE` | `APROC_INPUT_STORAGE_TYPE` | `` |  | `"https"` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_BUCKET` | `APROC_INPUT_STORAGE_BUCKET` | `` |  | `""` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_API_KEY_PROJECT` | `APROC_INPUT_STORAGE_API_KEY_PROJECT` | `` |  | `""` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_API_KEY_PRIVATE_KEY_ID` | `APROC_INPUT_STORAGE_API_KEY_PRIVATE_KEY_ID` | `` |  | `""` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_API_KEY_PRIVATE_KEY` | `APROC_INPUT_STORAGE_API_KEY_PRIVATE_KEY` | `` |  | `""` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_DOMAIN` | `APROC_INPUT_STORAGE_DOMAIN` | `` |  | `geodes-portal.cnes.fr` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_FORCE_DOWNLOAD` | `APROC_INPUT_STORAGE_FORCE_DOWNLOAD` | `True` |  | `True` in `conf/aias.env` |
| `APROC_TASK_TIME_LIMIT` | `APROC_TASK_TIME_LIMIT` | `1200` |  | `1200` in `conf/aias.env` |
| `APROC_TASK_SOFT_TIME_LIMIT` | `APROC_TASK_SOFT_TIME_LIMIT` | `1190` |  | `1190` in `conf/aias.env` |

List of volumes:

- `${APROC_INPUT_DIR}:/inputs:ro`
- `${APROC_DOWNLOAD_DIR}:/outbox`
- `${PWD}/conf/aias/drivers.yaml:/app/conf/drivers.yaml:ro`
- `${PWD}/conf/aias/aproc.yaml:/app/conf/aproc.yaml:ro`
- `${PWD}/conf/aias/download_drivers.yaml:/app/conf/download_drivers.yaml:ro`
- `${PWD}/conf/aias/enrich_drivers.yaml:/app/conf/enrich_drivers.yaml:ro`
## File dc/ref-dc-aias-aproc-service.yaml
### Service aproc-service
Description: ARLAS PROC is the OGC API Processes service. Used for ingesting and downloading EO products.

Image: `ARLAS_VERSION_APROC_SERVICE` with `gisaia/aproc-service:0.16.3` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APROC_LOGGER_LEVEL` | `APROC_LOGGER_LEVEL` | `INFO` |  | `INFO` in `conf/aias.env` |
| `ACCESS_LOGGER_LEVEL` | `ACCESS_LOGGER_LEVEL` | `INFO` |  |  |
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
| `AIRS_INDEX_COLLECTION_PREFIX` | `AIRS_INDEX_COLLECTION_PREFIX` | `` |  | `org.com@airs` in `conf/aias.env` |
| `APROC_INDEX_ENDPOINT_URL` | `AIRS_INDEX_ENDPOINT_URL` | `` |  | `https://elasticsearch:9200` in `conf/aias.env` |
| `APROC_INDEX_NAME` | `APROC_INDEX_NAME` | `` |  | `aproc_downloads` in `conf/aias.env` |
| `APROC_INDEX_LOGIN` | `ELASTIC_USER` | `` |  | `elastic` in `conf/elastic.env` |
| `APROC_INDEX_PWD` | `ELASTIC_PASSWORD` | `` |  | `elastic` in `conf/elastic.env` |
| `APROC_RESOURCE_ID_HASH_STARTS_AT` | `3` | `` |  |  |
| `DOWNLOAD_S3_ENDPOINT_URL` | `DOWNLOAD_S3_ENDPOINT_URL` | `http://minio:9000` |  |  |
| `DOWNLOAD_S3_BUCKET` | `DOWNLOAD_S3_BUCKET` | `` |  | `downloads` in `conf/aias.env` |
| `DOWNLOAD_S3_ACCESS_KEY_ID` | `DOWNLOAD_S3_ACCESS_KEY_ID` | `airs` |  |  |
| `DOWNLOAD_S3_SECRET_ACCESS_KEY` | `DOWNLOAD_S3_SECRET_ACCESS_KEY` | `airssecret` |  |  |
| `DOWNLOAD_S3_ASSET_HTTP_ENDPOINT_URL` | `DOWNLOAD_S3_ASSET_HTTP_ENDPOINT_URL` | `http://minio:9000/{}/{}` |  |  |
| `CLEAN_DOWNLOAD_OUTBOX_DIR` | `CLEAN_DOWNLOAD_OUTBOX_DIR` | `True` |  |  |
| `INGESTED_FOLDER` | `INGESTED_FOLDER` | `/inputs` |  | `https://storage.googleapis.com/gisaia-public/OPEND ...` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_TYPE` | `APROC_INPUT_STORAGE_TYPE` | `` |  | `"https"` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_BUCKET` | `APROC_INPUT_STORAGE_BUCKET` | `` |  | `""` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_API_KEY_PROJECT` | `APROC_INPUT_STORAGE_API_KEY_PROJECT` | `` |  | `""` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_API_KEY_PRIVATE_KEY_ID` | `APROC_INPUT_STORAGE_API_KEY_PRIVATE_KEY_ID` | `` |  | `""` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_API_KEY_PRIVATE_KEY` | `APROC_INPUT_STORAGE_API_KEY_PRIVATE_KEY` | `` |  | `""` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_DOMAIN` | `APROC_INPUT_STORAGE_DOMAIN` | `` |  | `geodes-portal.cnes.fr` in `conf/aias.env` |
| `APROC_INPUT_STORAGE_FORCE_DOWNLOAD` | `APROC_INPUT_STORAGE_FORCE_DOWNLOAD` | `True` |  | `True` in `conf/aias.env` |

List of volumes:

- `${APROC_INPUT_DIR}:/inputs:ro`
- `${PWD}/conf/aias/drivers.yaml:/app/conf/drivers.yaml:ro`
- `${PWD}/conf/aias/aproc.yaml:/app/conf/aproc.yaml:ro`
- `${PWD}/conf/aias/download_drivers.yaml:/app/conf/download_drivers.yaml:ro`
- `${PWD}/conf/aias/enrich_drivers.yaml:/app/conf/enrich_drivers.yaml:ro`
## File dc/ref-dc-aias-fam-wui.yaml
### Service arlas-fam-wui
Description: ARLAS FAM is the ARLAS File and Archive Management interface. It allows exploration and registration of archives found in a directory.

Image: `ARLAS_VERSION_FAM_WUI` with `gisaia/arlas-fam-wui:0.16.3` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `FAM_WUI_BASE_HREF` | `/fam-wui` | `` |  |  |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_CLEAR_HASH` | `true` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_CLIENT_ID` | `` |  |  |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `true` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `true` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `true` | `` |  |  |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_ISSUER` | `` |  |  |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_LOGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_MODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_REQUIRE_HTTPS` | `false` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_RESPONSE_TYPE` | `` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_SCOPE` | `` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_SHOW_DEBUG` | `false` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `/fam-wui/silent-refresh.html` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `10000` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_STORAGE` | `memorystorage` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_THRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `0.75` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_USE_DISCOVERY` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `true` | `` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
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

Image: `ARLAS_VERSION_FAM` with `gisaia/fam:0.16.3` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `FAM_LOGGER_LEVEL` | `FAM_LOGGER_LEVEL` | `INFO` |  | `INFO` in `conf/aias.env` |
| `ACCESS_LOGGER_LEVEL` | `ACCESS_LOGGER_LEVEL` | `INFO` |  |  |
| `FAM_PREFIX` | `/fam` | `` |  |  |
| `INGESTED_FOLDER` | `INGESTED_FOLDER` | `/inputs` |  | `https://storage.googleapis.com/gisaia-public/OPEND ...` in `conf/aias.env` |
| `APROC_RESOURCE_ID_HASH_STARTS_AT` | `3` | `` |  |  |

List of volumes:

- `${APROC_INPUT_DIR}:/inputs:ro`
- `${PWD}/conf/aias/drivers.yaml:/app/conf/drivers.yaml:ro`
- `${PWD}/conf/aias/aproc.yaml:/app/conf/aproc.yaml:ro`
## File dc/ref-dc-aias-minio.yaml
### Service minio
Description: Minio is an object store

Image: `ARLAS_VERSION_MINIO` with `minio/minio:RELEASE.2025-04-22T22-12-26Z` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `MINIO_BROWSER` | `off` | `` |  |  |
| `MINIO_ROOT_PASSWORD` | `MINIO_ROOT_PASSWORD` | `` |  | `airssecret` in `conf/minio.env` |
| `MINIO_ROOT_USER` | `MINIO_ROOT_USER` | `` |  | `airs` in `conf/minio.env` |

List of volumes:

- `${AIRS_STORAGE_DIRECTORY:-arlas-data-minio}:/data`
## File dc/ref-dc-aias-rabbitmq.yaml
### Service rabbitmq
Image: `ARLAS_VERSION_RABBITMQ` with `rabbitmq:3.13.7-management-alpine` in `conf/versions.env`


List of volumes:

- `arlas-data-rabbimq:/var/lib/rabbitmq/mnesia`
## File dc/ref-dc-aias-redis.yaml
### Service redis
Image: `ARLAS_VERSION_REDIS` with `redis/redis-stack:7.4.0-v3` in `conf/versions.env`


List of volumes:

- `arlas-data-redis:/data`
## File dc/ref-dc-aias-volumes.yaml
## File dc/ref-dc-aias-agate.yaml
### Service agate
Description: AGATE is a forward authorization service for accessing resources such as images

Image: `ARLAS_VERSION_AGATE` with `gisaia/agate:0.16.3` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `AGATE_LOGGER_LEVEL` | `AGATE_LOGGER_LEVEL` | `INFO` |  | `INFO` in `conf/aias.env` |
| `ARLAS_URL_SEARCH` | `ARLAS_URL_SEARCH` | `` |  | `"http://arlas-server:9999/arlas/explore/{collectio ...` in `conf/aias.env` |
| `AGATE_PREFIX` | `/agate` | `` |  |  |
| `AGATE_HOST` | `AGATE_HOST` | `0.0.0.0` |  |  |
| `AGATE_PORT` | `AGATE_PORT` | `8004` |  |  |
| `AGATE_URL_HEADER` | `X-Forwarded-Uri` | `` |  |  |
| `AGATE_URL_HEADER_PREFIX` | `AIRS_S3_BUCKET` | `` |  | `airs-storage` in `conf/aias.env` |
| `VERIFY_JWT` | `VERIFY_JWT` | `true` |  | `true` in `conf/arlas_iam.env` |
| `VERIFY_SSL` | `VERIFY_SSL` | `true` |  | `false` in `conf/arlas_iam.env` |
| `JWKS_URI` | `JWKS_URI` | `` |   | `https://${ARLAS_HOST}/arlas_iam_server/.well-known ...` in `conf/arlas_iam.env` |

List of volumes:

- `${PWD}/conf/aias/agate.yaml:/app/conf/agate.yaml:ro`
- `${PWD}/conf/aias/roles.yaml:/app/conf/roles.yaml:ro`
