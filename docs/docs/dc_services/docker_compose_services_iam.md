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
## File dc/ref-dc-elastic.yaml
### Service elasticsearch
Description: Elasticsearch is an indexing engine

Image: `ELASTIC_VERSION` with `docker.elastic.<br>co/elasticsearc<br>h/elasticsearch<br>:8.9. ...` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `discovery.type` | `single-node` | `` |  |  |
| `cluster.name` | `arlas-es-cluste<br><br>r` | `` |  |  |
| `node.name` | `arlas-data-node<br><br>-1` | `` |  |  |
| `ES_JAVA_OPTS` | `ES_JAVA_OPTS` | `` |  | `-Xms500m -Xmx50<br>0m` in `conf/elastic.env` |
| `xpack.security.enabled` | `false` | `` |  |  |
| `xpack.security.http.ssl.enabled` | `false` | `` |  |  |
| `xpack.security.transport.ssl.enabled` | `false` | `` |  |  |
| `tracing.apm.enabled` | `false` | `` |  |  |

List of volumes:

- `${ELASTIC_STORAGE:-arlas-data-es}:/usr/share/elasticsearch/data`
## File dc/ref-dc-arlas-server.yaml
### Service arlas-server
Description: ARLAS Server is the geo-analytic engine of the ARLAS Exploration Stack

Image: `ARLAS_SERVER_VERSION` with `gisaia/arlas-se<br>rver:27.1.0` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLI<br>CY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  Specify a PolicyEnforcer class to load in order to activate Authentication if needed | `io.arlas.filter<br>.impl.HTTPPolic<br>yEnforcer` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `ARLAS_AUTH_PUBL<br>IC_URIS` | `` |  | `"swagger.*:*,st<br>ac:GET,openapi.<br>json:GET,stac/.<br>*:GET ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERM<br>ISSION_URL` | `` |  | `http://arlas-ia<br>m-server:9998/a<br>rlas_iam_server<br>/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_APP_PATH` | `/` | `` |  |  |
| `ARLAS_BASE_URI` | `ARLAS_BASE_URI` | `http://arlas-server:9999/arlas/` |  Arlas base uri |  |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIM<br>EOUT` | `5` |  TTL in seconds of items in the cache |  |
| `ARLAS_CORS_ALLOWED_HEADERS` | `"arlas-user,arl<br><br>as-groups,a<br>rlas<br>-organi<br>zatio ...` | `` |  Comma-separated list of allowed headers |  |
| `ARLAS_CORS_ENABLED` | `ARLAS_CORS_ENAB<br>LED` | `true` |  Whether to configure cors or not |  |
| `ARLAS_ELASTIC_CLUSTER` | `ARLAS_ELASTIC_C<br>LUSTER` | `arlas-es-cluster` |  |  |
| `ARLAS_ELASTIC_ENABLE_SSL` | `false` | `` |  use SSL to connect to elasticsearch |  |
| `ARLAS_ELASTIC_INDEX` | `ARLAS_ELASTIC_I<br>NDEX` | `.arlas` |  name of the index that is used for storing ARLAS configuration |  |
| `ARLAS_ELASTIC_NODES` | `ARLAS_ELASTIC_N<br>ODES` | `elasticsearch:9200` |  comma separated list of elasticsearch nodes as host:port values |  |
| `ARLAS_ELASTIC_SKIP_MASTER` | `ARLAS_ELASTIC_S<br>KIP_MASTER` | `true` |  |  |
| `ARLAS_ELASTIC_SNIFFING` | `ES_SNIFFING` | `false` |  |  |
| `ARLAS_INSPIRE_ENABLED` | `ARLAS_INSPIRE_E<br>NABLED` | `false` |  Whether to activate INSPIRE compliant response elements |  |
| `ARLAS_LOGGING_CONSOLE_LEVEL` | `ARLAS_LOGGING_C<br>ONSOLE_LEVEL` | `` |  | `INFO` in `conf/arlas.env` |
| `ARLAS_LOGGING_LEVEL` | `ARLAS_LOGGING_L<br>EVEL` | `` |  | `INFO` in `conf/arlas.env` |
| `ARLAS_PREFIX` | `/arlas` | `` |  |  |
| `ARLAS_SERVICE_CSW_ENABLE` | `ARLAS_SERVICE_C<br>SW_ENABLE` | `false` |  Whether the CSW service is enabled or not |  |
| `ARLAS_SERVICE_RASTER_TILES_ENABLE` | `ARLAS_SERVICE_R<br>ASTER_TILES_ENA<br>BLE` | `false` |  Whether the RASTER tile service is enabled or not |  |
| `ARLAS_SERVICE_WFS_ENABLE` | `ARLAS_SERVICE_W<br>FS_ENABLE` | `false` |  Whether the WFS service is enabled or not |  |
| `JDK_JAVA_OPTIONS` | `ARLAS_SERVER_JD<br>K_JAVA_OPTIONS` | `` |  | `"-Xmx1g -XX:+Ex<br>itOnOutOfMemory<br>Error"` in `conf/arlas.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYC<br>LOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYC<br>LOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYC<br>LOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYC<br>LOAK_URL` | `` |  |  |
| `ARLAS_CHECK_ORGANISATIONS` | `ARLAS_CHECK_ORG<br>ANISATIONS` | `true` |  | `false` in `conf/arlas.env`<br>`true` in `conf/arlas_iam.env` |

List of volumes:

- `${PWD}/conf/arlas-ks.jks:/opt/app/arlas-ks.jks`
## File dc/ref-dc-arlas-persistence-server.yaml
### Service arlas-persistence-server
Description: ARLAS Persistence is a service for storing and retrieving small ojects, such as JSON documents or image previews.

Image: `ARLAS_PERSISTENCE_VERSION` with `gisaia/arlas-pe<br>rsistence-serve<br>r:27.0.1` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLI<br>CY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  | `io.arlas.filter<br>.impl.HTTPPolic<br>yEnforcer` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `ARLAS_AUTH_PUBL<br>IC_URIS` | `` |  | `"swagger.*:*,st<br>ac:GET,openapi.<br>json:GET,stac/.<br>*:GET ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERM<br>ISSION_URL` | `` |  | `http://arlas-ia<br>m-server:9998/a<br>rlas_iam_server<br>/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_ENABLED` | `ARLAS_AUTH_ENAB<br>LED` | `false` |  | `true` in `conf/permissions.env`<br>`true` in `conf/arlas_iam.env` |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIM<br>EOUT` | `5` |  |  |
| `ARLAS_PERSISTENCE_APP_PATH` | `ARLAS_PERSISTEN<br>CE_APP_PATH` | `/` |  |  |
| `ARLAS_PERSISTENCE_ENGINE` | `ARLAS_PERSISTEN<br>CE_ENGINE` | `hibernate` |  | `file` in `conf/persistence-file.env` |
| `ARLAS_PERSISTENCE_HIBERNATE_PASSWORD` | `POSTGRES_PASSWO<br>RD` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `ARLAS_PERSISTENCE_HIBERNATE_URL` | `ARLAS_PERSISTEN<br>CE_HIBERNATE_UR<br>L` | `jdbc:postgresql://db:5432/arlas` |  |  |
| `ARLAS_PERSISTENCE_HIBERNATE_USER` | `POSTGRES_USER` | `` |  | `pg-user` in `conf/postgres.env` |
| `ARLAS_PERSISTENCE_LOCAL_FOLDER` | `/persist/` | `` |  |  |
| `ARLAS_PERSISTENCE_LOGGING_CONSOLE_LEVEL` | `ARLAS_PERSISTEN<br>CE_LOGGING_CONS<br>OLE_LEVEL` | `` |  | `INFO` in `conf/persistence-file.env` |
| `ARLAS_PERSISTENCE_LOGGING_LEVEL` | `ARLAS_PERSISTEN<br>CE_LOGGING_LEVE<br>L` | `` |  | `INFO` in `conf/persistence-file.env` |
| `ARLAS_PERSISTENCE_PORT` | `ARLAS_PERSISTEN<br>CE_PORT` | `9997` |  |  |
| `ARLAS_PERSISTENCE_PREFIX` | `ARLAS_PERSISTEN<br>CE_PREFIX` | `/arlas-persistence-server` |  | `/persist` in `conf/persistence-file.env` |
| `ELASTIC_APM_APPLICATION_PACKAGES` | `io.arlas` | `` |  |  |
| `ELASTIC_APM_ENVIRONMENT` | `ELASTIC_APM_ENV<br>IRONMENT` | `` |  | `ARLAS` in `conf/elastic.env` |
| `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `ELASTIC_APM_LOG<br>_ECS_FORMATTER_<br>ALLOW_LIST` | `*` |  |  |
| `ELASTIC_APM_LOG_ECS_REFORMATTING` | `ELASTIC_APM_LOG<br>_ECS_REFORMATTI<br>NG` | `OVERRIDE` |  |  |
| `ELASTIC_APM_SECRET_TOKEN` | `ELASTIC_APM_SEC<br>RET_TOKEN` | `` |  | `not_a_secret` in `conf/elastic.env` |
| `ELASTIC_APM_SERVER_URLS` | `ELASTIC_APM_SER<br>VER_URLS` | `http://apm-server:8200` |  |  |
| `ELASTIC_APM_SERVICE_NAME` | `arlas-persisten<br><br>ce-server` | `` |  |  |
| `ELASTIC_APM_TRANSACTION_IGNORE_USER_AGENTS` | `GoogleHC/*, kub<br><br>e-probe/*, <br>curl<br>*, Goog<br>leSta ...` | `` |  |  |
| `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `ELASTIC_APM_USE<br>_JAXRS_PATH_AS_<br>TRANSACTION_NAM<br>E` | `true` |  |  |
| `JDK_JAVA_OPTIONS` | `ARLAS_PERSISTEN<br>CE_JDK_JAVA_OPT<br>IONS` | `` |  | `"-Xmx1g -XX:+Ex<br>itOnOutOfMemory<br>Error -Djavax.n<br>et.ss ...` in `conf/persistence-file.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYC<br>LOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYC<br>LOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYC<br>LOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYC<br>LOAK_URL` | `` |  |  |

List of volumes:

- `${ARLAS_PERSISTENCE_STORAGE}:/persist/`
- `${PWD}/conf/arlas-ks.jks:/opt/app/arlas-ks.jks`
## File dc/ref-dc-arlas-permissions-server.yaml
### Service arlas-permissions-server
Description: ARLAS Permissions is a service for listing user's permissions

Image: `ARLAS_PERMISSIONS_VERSION` with `gisaia/arlas-pe<br>rmissions-serve<br>r:27.0.1` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTH_POLICY_CLASS` | `ARLAS_AUTH_POLI<br>CY_CLASS` | `io.arlas.filter.impl.NoPolicyEnforcer` |  | `io.arlas.filter<br>.impl.HTTPPolic<br>yEnforcer` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_PERMISSION_URL` | `ARLAS_AUTH_PERM<br>ISSION_URL` | `` |  | `http://arlas-ia<br>m-server:9998/a<br>rlas_iam_server<br>/perm ...` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_ENABLED` | `ARLAS_AUTH_ENAB<br>LED` | `false` |  | `true` in `conf/permissions.env`<br>`true` in `conf/arlas_iam.env` |
| `ARLAS_PERMISSIONS_APP_PATH` | `/` | `` |  |  |
| `ARLAS_PERMISSIONS_PREFIX` | `/arlas_permissi<br><br>ons_server` | `` |  |  |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIM<br>EOUT` | `5` |  |  |
| `ARLAS_PERMISSIONS_LOGGING_CONSOLE_LEVEL` | `ARLAS_PERMISSIO<br>NS_LOGGING_CONS<br>OLE_LEVEL` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_PERMISSIONS_LOGGING_LEVEL` | `ARLAS_PERMISSIO<br>NS_LOGGING_LEVE<br>L` | `` |  | `INFO` in `conf/permissions.env` |
| `ARLAS_AUTH_PUBLIC_URIS` | `ARLAS_AUTH_PUBL<br>IC_URIS` | `` |  | `"swagger.*:*,st<br>ac:GET,openapi.<br>json:GET,stac/.<br>*:GET ...` in `conf/arlas_iam.env` |
| `ARLAS_PERMISSIONS_PORT` | `ARLAS_PERMISSIO<br>NS_PORT` | `9996` |  |  |
| `ELASTIC_APM_APPLICATION_PACKAGES` | `io.arlas` | `` |  |  |
| `ELASTIC_APM_ENVIRONMENT` | `ELASTIC_APM_ENV<br>IRONMENT` | `` |  | `ARLAS` in `conf/elastic.env` |
| `ELASTIC_APM_LOG_ECS_FORMATTER_ALLOW_LIST` | `ELASTIC_APM_LOG<br>_ECS_FORMATTER_<br>ALLOW_LIST` | `*` |  |  |
| `ELASTIC_APM_LOG_ECS_REFORMATTING` | `ELASTIC_APM_LOG<br>_ECS_REFORMATTI<br>NG` | `OVERRIDE` |  |  |
| `ELASTIC_APM_SECRET_TOKEN` | `ELASTIC_APM_SEC<br>RET_TOKEN` | `` |  | `not_a_secret` in `conf/elastic.env` |
| `ELASTIC_APM_SERVER_URLS` | `ELASTIC_APM_SER<br>VER_URLS` | `http://apm-server:8200` |  |  |
| `ELASTIC_APM_SERVICE_NAME` | `arlas-permissio<br><br>n-server` | `` |  |  |
| `ELASTIC_APM_TRANSACTION_IGNORE_USER_AGENTS` | `GoogleHC/*, kub<br><br>e-probe/*, <br>curl<br>*, Goog<br>leSta ...` | `` |  |  |
| `ELASTIC_APM_USE_JAXRS_PATH_AS_TRANSACTION_NAME` | `ELASTIC_APM_USE<br>_JAXRS_PATH_AS_<br>TRANSACTION_NAM<br>E` | `true` |  |  |
| `JDK_JAVA_OPTIONS` | `ARLAS_PERMISSIO<br>NS_JDK_JAVA_OPT<br>IONS` | `` |  | `"-Xmx1g -XX:+Ex<br>itOnOutOfMemory<br>Error -Djavax.n<br>et.ss ...` in `conf/permissions.env` |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYC<br>LOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYC<br>LOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYC<br>LOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYC<br>LOAK_URL` | `` |  |  |

List of volumes:

- `${PWD}/conf/arlas-ks.jks:/opt/app/arlas-ks.jks`
## File dc/ref-dc-iam-server.yaml
### Service arlas-iam-server
Description: ARLAS IAM is the ARLAS Identity and Access Management service.

Image: `ARLAS_IAM_SERVER_VERSION` with `gisaia/arlas-ia<br>m-server:27.0.1` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_ACCESS_TOKEN_TTL` | `600000` | `` |  |  |
| `ARLAS_ANONYMOUS_VALUE` | `ARLAS_ANONYMOUS<br>_VALUE` | `anonymous` |  |  |
| `ARLAS_AUTH_INIT_ADMIN` | `ARLAS_AUTH_INIT<br>_ADMIN` | `` |  | `tech@gisaia.com` in `conf/arlas_iam.env` |
| `ARLAS_AUTH_INIT_PASSWORD` | `ARLAS_AUTH_INIT<br>_PASSWORD` | `` |  | `admin` in `conf/arlas_iam.env` |
| `ARLAS_CACHE_TIMEOUT` | `ARLAS_CACHE_TIM<br>EOUT` | `5` |  |  |
| `ARLAS_IAM_CACHE_FACTORY_CLASS` | `ARLAS_IAM_CACHE<br>_FACTORY_CLASS` | `io.arlas.commons.cache.NoCacheFactory` |  |  |
| `ARLAS_IAM_HIBERNATE_PASSWORD` | `POSTGRES_PASSWO<br>RD` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `ARLAS_IAM_HIBERNATE_URL` | `ARLAS_IAM_HIBER<br>NATE_URL` | `jdbc:postgresql://db:5432/arlas` |  |  |
| `ARLAS_IAM_HIBERNATE_USER` | `POSTGRES_USER` | `` |  | `pg-user` in `conf/postgres.env` |
| `ARLAS_IAM_LOGGING_CONSOLE_LEVEL` | `ARLAS_IAM_LOGGI<br>NG_CONSOLE_LEVE<br>L` | `` |  | `INFO` in `conf/arlas_iam.env` |
| `ARLAS_IAM_LOGGING_LEVEL` | `ARLAS_IAM_LOGGI<br>NG_LEVEL` | `` |  | `INFO` in `conf/arlas_iam.env` |
| `ARLAS_IAM_PORT` | `ARLAS_IAM_PORT` | `9998` |  |  |
| `ARLAS_IAM_VERIFY_EMAIL` | `ARLAS_IAM_VERIF<br>Y_EMAIL` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_REFRESH_TOKEN_TTL` | `600000` | `` |  |  |
| `ARLAS_SERVER_URL` | `"http://arlas-s<br><br>erver:9999/<br>arla<br>s"` | `` |  |  |
| `ARLAS_SMTP_ACTIVATED` | `ARLAS_SMTP_ACTI<br>VATED` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_SMTP_FROM` | `ARLAS_SMTP_FROM` | `` |  | empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_HOST` | `ARLAS_SMTP_HOST` | `` |  | empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PASSWORD` | `ARLAS_SMTP_PASS<br>WORD` | `` |  | empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_PORT` | `ARLAS_SMTP_PORT` | `25` |  |  |
| `ARLAS_SMTP_RESET_LINK` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `ARLAS_SMTP_USERNAME` | `ARLAS_SMTP_USER<br>NAME` | `` |  | empty value in `conf/arlas_iam.env` |
| `ARLAS_SMTP_VERIFY_LINK` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `JDK_JAVA_OPTIONS` | `ARLAS_IAM_JDK_J<br>AVA_OPTIONS` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_REALM` | `ARLAS_AUTH_KEYC<br>LOAK_REALM` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_RESOURCE` | `ARLAS_AUTH_KEYC<br>LOAK_RESOURCE` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_SECRET` | `ARLAS_AUTH_KEYC<br>LOAK_SECRET` | `` |  |  |
| `ARLAS_AUTH_KEYCLOAK_URL` | `ARLAS_AUTH_KEYC<br>LOAK_URL` | `` |  |  |

## File dc/ref-dc-iam-wui.yaml
### Service arlas-wui-iam
Description: ARLAS IAM is the ARLAS Identity and Access Management web interface.

Image: `ARLAS_WUI_IAM_VERSION` with `gisaia/arlas-wu<br>i-iam:27.0.2` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_M<br>ODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_T<br>HRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_IAM_SERVER_URL` | `/arlas_iam_serv<br><br>er` | `` |  |  |
| `ARLAS_TAB_NAME` | `"ARLAS Wui IAM"` | `` |  |  |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHE<br>NT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_IAM_APP_PATH` | `/iam` | `` |  |  |
| `ARLAS_WUI_IAM_BASE_HREF` | `/iam` | `` |  |  |
| `ARLAS_STATIC_LINKS` | `ARLAS_IAM_LINKS` | `` |  | `'` in `conf/arlas_iam.env` |

## File dc/ref-dc-arlas-builder.yaml
### Service arlas-builder
Description: ARLAS Builder is the interface for elaborating ARLAS Dashboards.

Image: `ARLAS_BUILDER_VERSION` with `gisaia/arlas-wu<br>i-builder:27.0.<br>3` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_C<br>LEAR_HASH` | `true` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_C<br>LIENT_ID` | `` |  |  |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_D<br>ISABLE_AT_HASH_<br>CHECK` | `true` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_E<br>NABLE_SESSION_C<br>HECKS` | `true` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_F<br>ORCE_CONNECT` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_I<br>SSUER` | `` |  |  |
| `ARLAS_AUTHENT_LOGIN_URL` | `ARLAS_AUTHENT_L<br>OGIN_URL` | `` |  | `https://${ARLAS<br>_HOST}/hub/logi<br>n` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_L<br>OGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_M<br>ODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `ARLAS_AUTHENT_P<br>OST_LOGOUT_REDI<br>RECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_R<br>EDIRECT_URI` | `/builder/callback` |  |  |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_R<br>EQUIRE_HTTPS` | `false` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_R<br>ESPONSE_TYPE` | `code` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_S<br>COPE` | `profile` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_S<br>HOW_DEBUG` | `false` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_S<br>ILENT_REFRESH_R<br>EDIRECT_URI-/bu<br>ilder ...` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_S<br>ILENT_REFRESH_T<br>IMEOUT` | `10000` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_S<br>TORAGE` | `memorystorage` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_T<br>HRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_T<br>IMEOUT_FACTOR` | `0.75` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_U<br>SE_DISCOVERY` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_BASEMAPS` | `ARLAS_BASEMAPS` | `[{"name":"Empty","url":"/styles/empty/style.json","image":null}]` |  | `'[` in `conf/arlas.env` |
| `ARLAS_BASEMAPS` | `[{"name":"Stree<br><br>ts-light","<br>url"<br>:"https<br>://ap ...` | `` |  |  |
| `ARLAS_BUILDER_BASE_HREF` | `ARLAS_BUILDER_B<br>ASE_HREF` | `/builder` |  |  |
| `ARLAS_EXTERNAL_NODE_PAGE` | `ARLAS_EXTERNAL_<br>NODE_PAGE` | `true` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVE<br>R_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERMISSIONS_URL` | `ARLAS_PERMISSIO<br>NS_URL` | `/arlas_permissions_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTEN<br>CE_URL` | `/arlas_persistence_server` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS<br>_HOST}/persist` in `conf/arlas_iam.env` |
| `ARLAS_SERVER_URL` | `ARLAS_SERVER_UR<br>L` | `/arlas` |  |  |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHE<br>NT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_URL` | `ARLAS_WUI_URL` | `/wui/` |  | `https://${ARLAS<br>_HOST}/wui/` in `conf/arlas_iam.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_BUILDER_L<br>INKS` | `` |  | `'` in `conf/arlas.env` |

## File dc/ref-dc-arlas-hub.yaml
### Service arlas-hub
Description: ARLAS Hub is the interface for discovering all the available ARLAS Dashboards

Image: `ARLAS_HUB_VERSION` with `gisaia/arlas-wu<br>i-hub:27.0.2` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_C<br>LEAR_HASH` | `true` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_C<br>LIENT_ID` | `` |  |  |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_D<br>ISABLE_AT_HASH_<br>CHECK` | `true` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_E<br>NABLE_SESSION_C<br>HECKS` | `true` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_F<br>ORCE_CONNECT` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_I<br>SSUER` | `` |  |  |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_L<br>OGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_M<br>ODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_R<br>EDIRECT_URI` | `/hub/callback` |  |  |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_R<br>EQUIRE_HTTPS` | `false` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_R<br>ESPONSE_TYPE` | `` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_S<br>COPE` | `` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_S<br>HOW_DEBUG` | `false` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_S<br>ILENT_REFRESH_R<br>EDIRECT_URI-/hu<br>b/sil ...` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_S<br>ILENT_REFRESH_T<br>IMEOUT` | `10000` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_S<br>TORAGE` | `memorystorage` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_T<br>HRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_T<br>IMEOUT_FACTOR` | `0.75` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_U<br>SE_DISCOVERY` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_BUILDER_URL` | `ARLAS_BUILDER_U<br>RL` | `/builder/` |  | `https://${ARLAS<br>_HOST}/builder/` in `conf/arlas_iam.env` |
| `ARLAS_HUB_BASE_HREF` | `ARLAS_HUB_BASE_<br>HREF` | `/hub` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVE<br>R_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERMISSIONS_URL` | `ARLAS_PERMISSIO<br>NS_URL` | `/arlas_permissions_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTEN<br>CE_URL` | `/persist` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS<br>_HOST}/persist` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHE<br>NT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_URL` | `ARLAS_WUI_URL` | `/wui/` |  | `https://${ARLAS<br>_HOST}/wui/` in `conf/arlas_iam.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_HUB_LINKS` | `` |  | `'` in `conf/arlas.env` |

## File dc/ref-dc-arlas-wui.yaml
### Service arlas-wui
Description: ARLAS WUI is ARLAS Web interface for visualising an analytic ARLAS Dashboard.

Image: `ARLAS_WUI_VERSION` with `gisaia/arlas-wu<br>i:27.0.5` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `ARLAS_AUTHENT_CLEAR_HASH` | `ARLAS_AUTHENT_C<br>LEAR_HASH` | `true` |  |  |
| `ARLAS_AUTHENT_CLIENT_ID` | `ARLAS_AUTHENT_C<br>LIENT_ID` | `` |  |  |
| `ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK` | `ARLAS_AUTHENT_D<br>ISABLE_AT_HASH_<br>CHECK` | `true` |  |  |
| `ARLAS_AUTHENT_ENABLE_SESSION_CHECKS` | `ARLAS_AUTHENT_E<br>NABLE_SESSION_C<br>HECKS` | `true` |  |  |
| `ARLAS_AUTHENT_FORCE_CONNECT` | `ARLAS_AUTHENT_F<br>ORCE_CONNECT` | `` |  | `false` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_ISSUER` | `ARLAS_AUTHENT_I<br>SSUER` | `` |  |  |
| `ARLAS_AUTHENT_LOGIN_URL` | `ARLAS_AUTHENT_L<br>OGIN_URL` | `` |  | `https://${ARLAS<br>_HOST}/hub/logi<br>n` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_LOGOUT_URL` | `ARLAS_AUTHENT_L<br>OGOUT_URL` | `` |  |  |
| `ARLAS_AUTHENT_MODE` | `ARLAS_AUTHENT_M<br>ODE` | `` |  | `iam` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_POST_LOGOUT_REDIRECT_URI` | `ARLAS_AUTHENT_P<br>OST_LOGOUT_REDI<br>RECT_URI` | `` |  |  |
| `ARLAS_AUTHENT_REDIRECT_URI` | `ARLAS_AUTHENT_R<br>EDIRECT_URI` | `/wui/callback` |  |  |
| `ARLAS_AUTHENT_REQUIRE_HTTPS` | `ARLAS_AUTHENT_R<br>EQUIRE_HTTPS` | `false` |  |  |
| `ARLAS_AUTHENT_RESPONSE_TYPE` | `ARLAS_AUTHENT_R<br>ESPONSE_TYPE` | `code` |  |  |
| `ARLAS_AUTHENT_SCOPE` | `ARLAS_AUTHENT_S<br>COPE` | `profile` |  |  |
| `ARLAS_AUTHENT_SHOW_DEBUG` | `ARLAS_AUTHENT_S<br>HOW_DEBUG` | `false` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_REDIRECT_URI` | `ARLAS_AUTHENT_S<br>ILENT_REFRESH_R<br>EDIRECT_URI-/wu<br>i/sil ...` | `` |  |  |
| `ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT` | `ARLAS_AUTHENT_S<br>ILENT_REFRESH_T<br>IMEOUT` | `10000` |  |  |
| `ARLAS_AUTHENT_STORAGE` | `ARLAS_AUTHENT_S<br>TORAGE` | `memorystorage` |  |  |
| `ARLAS_AUTHENT_THRESHOLD` | `ARLAS_AUTHENT_T<br>HRESHOLD` | `` |  | `60000` in `conf/arlas_iam.env` |
| `ARLAS_AUTHENT_TIMEOUT_FACTOR` | `ARLAS_AUTHENT_T<br>IMEOUT_FACTOR` | `0.75` |  |  |
| `ARLAS_AUTHENT_USE_DISCOVERY` | `ARLAS_AUTHENT_U<br>SE_DISCOVERY` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_GEOCODING_FIND_PLACE_URL` | `ARLAS_GEOCODING<br>_FIND_PLACE_URL` | `` |  | empty value in `conf/arlas.env` |
| `ARLAS_GEOCODING_FIND_PLACE_ZOOM_TO` | `ARLAS_GEOCODING<br>_FIND_PLACE_ZOO<br>M_TO` | `10` |  |  |
| `ARLAS_HUB_URL` | `ARLAS_HUB_URL` | `/hub/` |  |  |
| `ARLAS_IAM_SERVER_URL` | `ARLAS_IAM_SERVE<br>R_URL` | `/arlas_iam_server` |  |  |
| `ARLAS_PERSISTENCE_URL` | `ARLAS_PERSISTEN<br>CE_URL` | `/arlas_persistence_server` |  | `/persist` in `conf/persistence-file.env`<br>`https://${ARLAS<br>_HOST}/persist` in `conf/arlas_iam.env` |
| `ARLAS_USE_AUTHENT` | `ARLAS_USE_AUTHE<br>NT` | `` |  | `true` in `conf/arlas_iam.env` |
| `ARLAS_WUI_BASE_HREF` | `ARLAS_WUI_BASE_<br>HREF` | `/wui` |  |  |
| `PUBLIC_HOST` | `ARLAS_HOST` | `` |  | `localhost` in `conf/stack.env` |
| `ARLAS_STATIC_LINKS` | `ARLAS_WUI_LINKS` | `` |  | `'` in `conf/arlas.env` |
| `ARLAS_DOWNLOAD_PROCESS_URL` | `ARLAS_DOWNLOAD_<br>PROCESS_URL` | `` |  | `/aproc/processe<br>s/download/exec<br>ution` in `conf/arlas.env` |
| `ARLAS_DOWNLOAD_PROCESS_CHECK_URL` | `ARLAS_DOWNLOAD_<br>PROCESS_CHECK_U<br>RL` | `` |  | `/aproc/processe<br>s/download` in `conf/arlas.env` |
| `ARLAS_DOWNLOAD_PROCESS_MAX_ITEMS` | `ARLAS_DOWNLOAD_<br>PROCESS_MAX_ITE<br>MS` | `` |  |  |
| `ARLAS_DOWNLOAD_PROCESS_SETTINGS_URL` | `ARLAS_DOWNLOAD_<br>PROCESS_SETTING<br>S_URL` | `` |  |  |
| `ARLAS_DOWNLOAD_PROCESS_STATUS_URL` | `ARLAS_DOWNLOAD_<br>PROCESS_STATUS_<br>URL` | `` |  | `/aproc/jobs` in `conf/arlas.env` |
| `ARLAS_ENRICH_PROCESS_URL` | `ARLAS_ENRICH_PR<br>OCESS_URL` | `` |  | `/aproc/processe<br>s/enrich/execut<br>ion` in `conf/arlas.env` |
| `ARLAS_ENRICH_PROCESS_CHECK_URL` | `ARLAS_ENRICH_PR<br>OCESS_CHECK_URL` | `` |  | `/aproc/processe<br>s/enrich` in `conf/arlas.env` |
| `ARLAS_ENRICH_PROCESS_MAX_ITEMS` | `ARLAS_ENRICH_PR<br>OCESS_MAX_ITEMS` | `` |  |  |
| `ARLAS_ENRICH_PROCESS_SETTINGS_URL` | `ARLAS_ENRICH_PR<br>OCESS_SETTINGS_<br>URL` | `` |  |  |
| `ARLAS_ENRICH_PROCESS_STATUS_URL` | `ARLAS_ENRICH_PR<br>OCESS_STATUS_UR<br>L` | `` |  | `/aproc/jobs` in `conf/arlas.env` |

List of volumes:

- `${PWD}/conf/protomaps/styles:/usr/share/nginx/html/assets/basemap/styles`
- `${PWD}/conf/protomaps/glyphs:/usr/share/nginx/html/assets/basemap/glyphs`
- `${PWD}/conf/protomaps/quicklook:/usr/share/nginx/html/assets/basemap/quicklook`
- `${PWD}/conf/protomaps/world.pmtiles:/usr/share/nginx/html/assets/basemap/world.pmtiles`
## File dc/ref-dc-protomaps.yaml
### Service protomaps
Image: `PROTOMAP_VERSION` with `protomaps/go-pm<br>tiles:v1.28.0` in `conf/versions.env`


List of volumes:

- `${PWD}/conf/protomaps/world.pmtiles:/protomaps/basemaps/world.pmtiles:ro`
## File dc/ref-dc-apisix.yaml
### Service apisix
Description: APISIX is ARLAS Stack gateway. It handles all the incoming trafic.

Image: `APISIX_VERSION` with `apache/apisix:3<br>.12.0-debian` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `APISIX_STAND_ALONE` | `APISIX_STAND_AL<br>ONE` | `true` |  | `true` in `conf/apisix.env` |

List of volumes:

- `${PWD}/conf/apisix/config.yaml:/usr/local/apisix/conf/config.yaml`
- `${PWD}/conf/apisix/apisix.yaml:/usr/local/apisix/conf/apisix.yaml`
## File dc/ref-dc-postgres.yaml
### Service db
Image: `POSTGRES_VERSION` with `postgres:16.8` in `conf/versions.env`

| Container variable | Value or environment variable | Default | Description | Env file setting |
| --- | --- | --- | --- | --- |
| `DAY_OF_WEEK_TO_KEEP` | `POSTGRES_DAY_OF<br>_WEEK_TO_KEEP` | `` |  | `6` in `conf/postgres.env` |
| `DAYS_TO_KEEP` | `POSTGRES_DAYS_T<br>O_KEEP` | `` |  | `7` in `conf/postgres.env` |
| `WEEKS_TO_KEEP` | `POSTGRES_WEEKS_<br>TO_KEEP` | `` |  | `5` in `conf/postgres.env` |
| `PG_BACKUP_DIR` | `/backup/` | `` |  |  |
| `PGPASSWORD` | `POSTGRES_PASSWO<br>RD` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `PGUSER` | `POSTGRES_USER` | `` |  | `pg-user` in `conf/postgres.env` |
| `POSTGRES_DB` | `arlas` | `` |  |  |
| `POSTGRES_HOST_AUTH_METHOD` | `trust` | `` |  |  |
| `POSTGRES_PASSWORD` | `POSTGRES_PASSWO<br>RD` | `` |  | `not_a_secret` in `conf/postgres.env` |
| `POSTGRES_USER` | `POSTGRES_USER` | `` |  | `pg-user` in `conf/postgres.env` |

List of volumes:

- `${POSTGRES_BACKUP_STORAGE}:/backup/`
- `${POSTGRES_CREATE_TABLE}:/docker-entrypoint-initdb.d/createTable.sql:ro`
- `${POSTGRES_CRON}:/usr/local/bin/arlas/pg_backup_rotated.sh:ro`
- `${POSTGRES_STORAGE}:/var/lib/postgresql/data`
