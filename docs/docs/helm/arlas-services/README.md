# arlas-services

![Version: 28.8.0](https://img.shields.io/badge/Version-28.8.0-informational?style=flat-square) ![AppVersion: 28.0.0](https://img.shields.io/badge/AppVersion-28.0.0-informational?style=flat-square)

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
| defaultStorageClass | string | `"standard"` |  |
| dnsDomain | string | `"localhost"` | DNS domain hosting ARLAS |
| elastic.cluster | string | `"elastic"` |  |
| elastic.login | string | `"elastic"` |  |
| elastic.nodes | string | `"elasticsearch:9200"` |  |
| elastic.password | string | `"password4elastic"` |  |
| elastic.skipMaster | bool | `true` |  |
| elastic.sniffing | bool | `false` |  |
| elastic.ssl.enabled | bool | `true` |  |
| keycloak.client | string | `"arlas-backend"` |  |
| keycloak.enabled | bool | `true` |  |
| keycloak.realm | string | `"arlas"` |  |
| keycloak.secret | string | `"rha14c4202RB0Dxlke6ZNCCTw9gkvLJ8"` |  |
| keycloak.url | string | `"http://172.18.0.2/auth"` |  |
| logger.loggingConsoleLevel | string | `"INFO"` | Default console logging level |
| logger.loggingFile | string | `"/tmp/arlas.log"` | Default logging file |
| logger.loggingLevel | string | `"INFO"` | Default logging level |
| persistence.engine | string | `"file"` | Storage engine to use: either `file` or `hibernate` |
| persistence.hibernate | object | `{"dialect":"org.hibernate.dialect.PostgreSQLDialect","driver":"org.postgresql.Driver","password":null,"url":"jdbc:postgresql://db:5432/arlas","user":null}` | Configuration node if `engine=hibernate`, ignored otherwise |
| persistence.hibernate.dialect | string | `"org.hibernate.dialect.PostgreSQLDialect"` | SQL Dialect |
| persistence.hibernate.driver | string | `"org.postgresql.Driver"` | JDBC Driver |
| persistence.hibernate.password | string | `nil` | Database user password |
| persistence.hibernate.url | string | `"jdbc:postgresql://db:5432/arlas"` | JDBC URL |
| persistence.hibernate.user | string | `nil` | Database user login |
| persistence.localFolder | string | `"/persistence/"` | Path to use for file persistence |
| persistence.storageSize | string | `"100Mi"` | Storage size in case of file persistence |
| services.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| services.mountCertificate | bool | `false` |  |
| services.permissions.affinity | object | `{}` |  |
| services.permissions.apm | bool | `false` |  |
| services.permissions.extraContainers | list | `[]` |  |
| services.permissions.extraEnv | string | `nil` |  |
| services.permissions.extraInitContainers | string | `nil` |  |
| services.permissions.extraVolumeMounts | string | `nil` |  |
| services.permissions.extraVolumes | string | `nil` |  |
| services.permissions.image | string | `"gisaia/arlas-permissions-server:28.0.0"` |  |
| services.permissions.imagePullSecrets | list | `[]` |  |
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
| services.persistence.extraContainers | list | `[]` |  |
| services.persistence.extraEnv | string | `nil` |  |
| services.persistence.extraInitContainers | string | `nil` |  |
| services.persistence.extraVolumeMounts | string | `nil` |  |
| services.persistence.extraVolumes | string | `nil` |  |
| services.persistence.image | string | `"gisaia/arlas-persistence-server:28.0.0"` |  |
| services.persistence.imagePullSecrets | list | `[]` |  |
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
| services.podSecurityContext.fsGroup | int | `65532` |  |
| services.podSecurityContext.runAsNonRoot | bool | `true` |  |
| services.podSecurityContext.runAsUser | int | `65532` |  |
| services.server.affinity | object | `{}` |  |
| services.server.apm | bool | `false` |  |
| services.server.extraContainers | list | `[]` |  |
| services.server.extraEnv | string | `nil` |  |
| services.server.extraInitContainers | string | `nil` |  |
| services.server.extraVolumeMounts | string | `nil` |  |
| services.server.extraVolumes | string | `nil` |  |
| services.server.image | string | `"gisaia/arlas-server:28.0.0"` |  |
| services.server.imagePullSecrets | list | `[]` |  |
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
| services.server.trustStoreOptions | string | `"-Djavax.net.ssl.trustStore=/opt/app/store/arlas-ks.jks -Djavax.net.ssl.trustStorePassword=arlaspassword"` |  |
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
