# arlas-services

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square)

A Helm Chart to deploy ARLAS Server

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| auth.checkOrganizations | bool | `false` |  |
| cacheFactoryClass | string | `"io.arlas.server.core.impl.cache.LocalCacheFactory"` | The factory class for the cache (io.arlas.server.core.impl.cache.HazelcastCacheFactory, io.arlas.server.core.impl.cache.LocalCacheFactory or io.arlas.server.core.impl.cache.NoCacheFactory) |
| cacheTimeout | int | `60` | Cache TTL for items in cache (seconds), used for all deployments to ensure consistency |
| cors.allowedCredentials | bool | `true` | CORS Allowed Credentials or not |
| cors.allowedHeaders | string | `"arlas-user,arlas-groups,arlas-organization,arlas-org-filter,X-Requested-With,Content-Type,Accept,Origin,Authorization,X-Forwarded-User"` | CORS Allowed Headers |
| cors.allowedMethods | string | `"OPTIONS,GET,PUT,POST,DELETE,HEAD"` | CORS Allowed Methods |
| cors.allowedOrigins | string | `"\"*\""` | CORS Allowed Origins |
| cors.enabled | bool | `false` | Enable CORS or not |
| cors.exposedHeaders | string | `"Content-Type,Authorization,X-Requested-With,Content-Length,Accept,Origin,Location,WWW-Authenticate"` | CORS Exposed Headers |
| dnsDomain | string | `"localhost"` | DNS domain hosting ARLAS |
| elastic.apm.secret | string | `nil` |  |
| elastic.apm.url | string | `nil` |  |
| elastic.cluster | string | `"elastic"` |  |
| elastic.login | string | `"elastic"` |  |
| elastic.password | string | `"password4elastic"` |  |
| elastic.skipMaster | bool | `true` |  |
| elastic.sniffing | bool | `false` |  |
| elastic.ssl.enabled | bool | `true` |  |
| keycloak.client | string | `"arlas-backend"` |  |
| keycloak.enabled | bool | `true` |  |
| keycloak.realm | string | `"arlas"` |  |
| keycloak.secret | string | `"rha14c4202RB0Dxlke6ZNCCTw9gkvLJ8"` |  |
| keycloak.url | string | `"http://172.18.0.2/auth"` |  |
| logger.loggingConsoleLevel | string | `"DEBUG"` | Default console logging level |
| logger.loggingLevel | string | `"DEBUG"` | Default logging level |
| persistence | object | `{"engine":"file","hibernate":{"dialect":"org.hibernate.dialect.PostgreSQLDialect","driver":"org.postgresql.Driver","password":null,"url":"jdbc:postgresql://db:5432/arlas","user":null},"localFolder":"/tmp/","storageSize":"100Mi"}` | Configuration of the persistence engine |
| persistence.engine | string | `"file"` | Storage engine to use: either `file` or `hibernate` |
| persistence.hibernate | object | `{"dialect":"org.hibernate.dialect.PostgreSQLDialect","driver":"org.postgresql.Driver","password":null,"url":"jdbc:postgresql://db:5432/arlas","user":null}` | Configuration node if `engine=hibernate`, ignored otherwise |
| persistence.hibernate.dialect | string | `"org.hibernate.dialect.PostgreSQLDialect"` | SQL Dialect |
| persistence.hibernate.driver | string | `"org.postgresql.Driver"` | JDBC Driver |
| persistence.hibernate.password | string | `nil` | Database user password |
| persistence.hibernate.url | string | `"jdbc:postgresql://db:5432/arlas"` | JDBC URL |
| persistence.hibernate.user | string | `nil` | Database user login |
| persistence.localFolder | string | `"/tmp/"` | Storage engine to use: either `file` or `hibernate` |
| persistence.storageSize | string | `"100Mi"` | Storage size in case of file persistence |
| services.permissions.affinity | object | `{}` |  |
| services.permissions.apm | bool | `false` |  |
| services.permissions.image | string | `"gisaia/arlas-permissions-server:27.0.1"` |  |
| services.permissions.jvmXmx | string | `"512m"` |  |
| services.permissions.nodeSelector | object | `{}` |  |
| services.permissions.publicUris | string | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET/POST,explore/.*:GET/POST,persist/.*:GET,authorize/resources:GET"` |  |
| services.permissions.replicaCount | int | `1` |  |
| services.permissions.resources.limits.cpu | float | `0.5` |  |
| services.permissions.resources.limits.memory | string | `"512Mi"` |  |
| services.permissions.resources.requests.cpu | float | `0.1` |  |
| services.permissions.resources.requests.memory | string | `"128Mi"` |  |
| services.permissions.serviceName | string | `"arlas-permissions-server"` |  |
| services.permissions.tolerations | list | `[]` |  |
| services.permissions.urlPrefix | string | `"/permissions"` |  |
| services.persistence.affinity | object | `{}` |  |
| services.persistence.apm | bool | `false` | Whether ES APM should be activated or not |
| services.persistence.image | string | `"gisaia/arlas-persistence-server:27.0.1"` |  |
| services.persistence.jvmXmx | string | `"512m"` |  |
| services.persistence.nodeSelector | object | `{}` |  |
| services.persistence.publicUris | string | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET/POST,explore/.*:GET/POST,persist/.*:GET,authorize/resources:GET"` |  |
| services.persistence.replicaCount | int | `1` |  |
| services.persistence.resources.limits.cpu | float | `0.5` |  |
| services.persistence.resources.limits.memory | string | `"512Mi"` |  |
| services.persistence.resources.requests.cpu | float | `0.1` |  |
| services.persistence.resources.requests.memory | string | `"128Mi"` |  |
| services.persistence.serviceName | string | `"arlas-persistence-server"` |  |
| services.persistence.tolerations | list | `[]` |  |
| services.persistence.urlPrefix | string | `"/persist"` |  |
| services.server.affinity | object | `{}` |  |
| services.server.apm | bool | `false` |  |
| services.server.image | string | `"gisaia/arlas-server:27.1.0"` |  |
| services.server.jvmXmx | string | `"1800m"` |  |
| services.server.nodeSelector | object | `{}` |  |
| services.server.publicUris | string | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET/POST,explore/.*:GET/POST,persist/.*:GET,authorize/resources:GET"` |  |
| services.server.replicaCount | int | `1` |  |
| services.server.resources.limits.cpu | int | `1` |  |
| services.server.resources.limits.memory | string | `"1000Mi"` |  |
| services.server.resources.requests.cpu | float | `0.1` |  |
| services.server.resources.requests.memory | string | `"256Mi"` |  |
| services.server.serviceName | string | `"arlas-server"` |  |
| services.server.tolerations | list | `[]` |  |
| services.server.urlPrefix | string | `"/arlas"` |  |
| services.servicePort | int | `8000` |  |
| services.serviceType | string | `"ClusterIP"` |  |
| subServices.cswActivated | string | `"\"false\""` | Whether CSW Service is activated or not |
| subServices.inspireActivated | string | `"\"false\""` | Whether INSPIRE Service is activated or not |
| subServices.rasterTileActivated | string | `"\"false\""` | Whether Raster Tile Service is activated or not |
| subServices.wfsActivated | string | `"\"false\""` | Whether WFS Service is activated or not |
| swaggerResource | string | `"io.arlas.server.rest,io.arlas.server.stac"` | The java package to process for extracting the APIs displayed in Swagger |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
