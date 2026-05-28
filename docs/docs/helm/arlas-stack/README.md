# arlas-aias

![Version: 27.72.0](https://img.shields.io/badge/Version-27.72.0-informational?style=flat-square) ![AppVersion: 27.72.0](https://img.shields.io/badge/AppVersion-27.72.0-informational?style=flat-square)

A Helm Chart to deploy the ARLAS Exploration Stack with AIAS services

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../aias-services | aias-services | 27.72.0 |
| file://../arlas-services | arlas-services | 27.72.0 |
| file://../arlas-uis | arlas-uis | 27.72.0 |
| file://../titiler | titiler | 27.72.0 |
| https://charts.bitnami.com/bitnami | elasticsearch | 22.0.4 |
| https://charts.bitnami.com/bitnami | keycloak | 25.2.0 |
| https://charts.bitnami.com/bitnami | minio | 14.10.5 |
| https://charts.bitnami.com/bitnami | rabbitmq | 16.0.11 |
| https://charts.bitnami.com/bitnami | redis | 21.2.13 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aias-services.dnsDomain | string | `"site.arlas.k8s"` | __Do not change:__ value defined in global section |
| aias-services.elastic.endpoint | string | `"https://arlas-stack-elasticsearch:9200"` | Elasticsearch endpoint for aias-services |
| aias-services.elastic.login | string | `"elastic"` | Do not change: value defined in global section |
| aias-services.elastic.password | string | `"secret4elastic"` | Do not change: value defined in global section |
| aias-services.initBuckets | bool | `true` | Init the AIAS minio buckets   |
| aias-services.logger.loggingConsoleLevel | string | `"DEBUG"` | Console logging level for aias-services |
| aias-services.logger.loggingLevel | string | `"DEBUG"` | Logging level for aias-services |
| aias-services.protocol | string | `"https"` | __Do not change:__ value defined in global section |
| aias-services.services.agate.configuration.arlasUrlSearch | string | `"http://arlas-server:8000/arlas/explore/{collection}/_search?f=id:eq:{item}"` | ARLAS search URL used by Agate to check whether an item exists |
| aias-services.services.agate.configuration.methodHeader | string | `"x-original-method"` | Headers used by the ingress controller to pass the original method information to Agate |
| aias-services.services.agate.configuration.urbac.jwks_uri | string | `"https://keycloak.arlas.k8s/realms/arlas/protocol/openid-connect/certs"` | __MUST BE CONFIGURED:__ Change to the URI of the JWKS endpoint of your deployment. |
| aias-services.services.agate.configuration.urbac.jwtAudience | string | `"arlas-backend"` | Name of the token audience |
| aias-services.services.agate.configuration.urbac.verifySsl | bool | `false` | __MUST BE CONFIGURED:__ Change to true in production or if certificate can be verified |
| aias-services.services.agate.configuration.urlHeader | string | `"x-auth-request-redirect"` | Headers used by the ingress controller to pass the original request information to Agate |
| aias-services.services.agate.serviceName | string | `"arlas-agate"` | Agate service configuration for AIAS |
| aias-services.services.airs.configuration.indexCollectionPrefix | string | `"org.com@airs"` | __MUST BE CONFIGURED:__ Prefix for elasticsearch indices created for AIRS collections. This MUST contain the organization name followed by '@' followed by a custom suffix, e.g. org.com@airs |
| aias-services.services.airs.configuration.s3.accessKeyId | string | `"minioadmin"` | __Do not change:__ value defined in global section |
| aias-services.services.airs.configuration.s3.assetHttpEndpointUrl | string | `"https://site.arlas.k8s/{}/{}"` | __MUST BE CONFIGURED:__ Change with the domain of your deployment |
| aias-services.services.airs.configuration.s3.bucket | string | `"airs-storage"` | __IMPORTANT:__ If you change the bucket name here, make sure to overwrite the patterns in agate.configuration.services (k8s/charts/aias-services/values.yaml). |
| aias-services.services.airs.configuration.s3.endpoint | string | `"http://arlas-stack-minio:9000"` | Minio endpoint |
| aias-services.services.airs.configuration.s3.secretAccessKey | string | `"secret4minio"` | __Do not change:__ value defined in global section |
| aias-services.services.airs.configuration.s3.writablePaths | list | `["/"]` | Paths that can be written by AIRS to store assets |
| aias-services.services.airs.serviceName | string | `"airs-server"` | AIRS service configuration for AIAS |
| aias-services.services.aproc.configuration.accessManager.storages | list | `[{"readable_paths":["/inputs"],"type":"file","writable_paths":["/tmp","/outbox"]},{"bucket":"gisaia-public","readable_paths":["/"],"type":"gs"},{"api_key":{"access_key":"minioadmin","secret_key":"secret4minio"},"bucket":"archives","endpoint":"$APROC_ARCHIVE_ENDPOINT|http://arlas-stack-minio:9000\"","readable_paths":["/inputs"],"type":"s3"},{"bucket":"gisaia-public","endpoint":"https://storage.googleapis.com","readable_paths":["/"],"type":"s3"},{"api_key":{"access_key":"minioadmin","secret_key":"secret4minio"},"bucket":"downloads","endpoint":"http://arlas-stack-minio:9000","readable_paths":["/"],"type":"s3","writable_paths":["/"]},{"api_key":{"access_key":"minioadmin","secret_key":"secret4minio"},"bucket":"inputs","endpoint":"http://arlas-stack-minio:9000","readable_paths":["/"],"type":"s3"}]` | Configuration of the storages used by the access manager to provide access to various storage backends. See https://docs.arlas.io/external_docs/aias/aproc/configuration/#storage-access-configuration |
| aias-services.services.aproc.configuration.accessManager.tmpDir | string | `"/tmp/"` | Temporary directory used by the access manager |
| aias-services.services.aproc.configuration.airsEndpoint | string | `"http://airs-server:8000/airs"` | AIRS service endpoint URL accessed by APROC |
| aias-services.services.aproc.configuration.arlasUrlSearch | string | `"http://arlas-server:8000/arlas/explore/{collection}/_search?f=id:eq:{item}"` | ARLAS search URL used by APROC to check whether an item exists |
| aias-services.services.aproc.configuration.celeryBrokerUrl | string | `"pyamqp://admin:secret4rabbitmq@arlas-stack-rabbitmq:5672//"` | __MUST BE CONFIGURED:__ RabbitMQ broker URL for APROC tasks |
| aias-services.services.aproc.configuration.celeryResultBackend | string | `"redis://:secret4redis@arlas-stack-redis-master:6379/0"` | __MUST BE CONFIGURED:__ Redis backend URL for APROC task results |
| aias-services.services.aproc.configuration.celeryResultBackendTransportOptions | string | `nil` |  |
| aias-services.services.aproc.configuration.extensions.download.index.name | string | `"org.com@aproc_downloads"` | __MUST BE CONFIGURED:__ Change with the domain (org.com) with your own organization name |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.accessKeyId | string | `"minioadmin"` | Do not change: value defined in global section |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.assetHttpEndpointUrl | string | `"https://site.arlas.k8s/{}/{}"` | __MUST BE CONFIGURED:__ Change with the domain of your deployment |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.bucket | string | `"downloads"` | Bucket where downloads are stored |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.endpointUrl | string | `"http://arlas-stack-minio:9000"` | Minio endpoint |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.secretAccessKey | string | `"secret4minio"` | Do not change: value defined in global section |
| aias-services.services.aproc.configuration.extensions.ingest.aprocEndpoint | string | `"http://aproc-service:8001"` | APROC endpoint URL accessed by ingest processes |
| aias-services.services.aproc.configuration.extensions.ingest.inputsDirectory | string | `"https://storage.googleapis.com/gisaia-public/test-aias"` | Directory where archives to ingest are stored. Must be in sync with the accessManager readable_paths configuration below. Examples: /inputs, https://storage.googleapis.com/gisaia-public/OPENDATA/eo inputsDirectory: http://arlas-stack-minio:9000/inputs |
| aias-services.services.aproc.service.serviceName | string | `"aproc-service"` | APROC service name |
| aias-services.services.aproc.worker | object | `{"affinity":{},"nodeSelector":{},"replicaCount":1,"resources":{"limits":{"cpu":2,"memory":"10Gi"}},"tolerations":[]}` | APROC worker configuration |
| aias-services.services.fam.serviceName | string | `"arlas-fam"` | FAM service name |
| arlas-services.defaultStorageClass | string | `"standard-retain"` | Do not change: value defined in global section |
| arlas-services.dnsDomain | string | `"site.arlas.k8s"` | Do not change: value defined in global section |
| arlas-services.elastic.login | string | `"elastic"` | Do not change: value defined in global section |
| arlas-services.elastic.nodes | string | `"arlas-stack-elasticsearch:9200"` | Elasticsearch endpoint for arlas-services |
| arlas-services.elastic.password | string | `"secret4elastic"` | Do not change: value defined in global section |
| arlas-services.logger.loggingConsoleLevel | string | `"INFO"` | Console logging level |
| arlas-services.logger.loggingLevel | string | `"INFO"` | Logging level |
| arlas-services.protocol | string | `"https"` | Do not change: value defined in global section |
| arlas-services.services.mountCertificate | bool | `true` | __MUST BE CONFIGURED:__ Set to true if you want the services to use the certificate contained in the k8s/charts/arlas-stack/templates/keycloak-certificate-configmap.yaml file and enable the keycloak.ingress.extraTls bloc. False otherwise and disable the keycloak.ingress.extraTls bloc. |
| arlas-uis.authent.issuer | string | `"https://keycloak.arlas.k8s/realms/arlas"` | Do not change: value defined in global section |
| arlas-uis.authent.logoutUrl | string | `nil` | Do not change: value defined in global section |
| arlas-uis.basemap | object | `{"storageSize":"50Mi"}` | __MUST BE CONFIGURED:__ Set to 120 Gi if you copy the full basemap |
| arlas-uis.defaultStorageClass | string | `"standard-retain"` | Do not change: value defined in global section |
| arlas-uis.dnsDomain | string | `"site.arlas.k8s"` | Do not change: value defined in global section |
| arlas-uis.logger.loggingConsoleLevel | string | `"INFO"` | Console logging level |
| arlas-uis.logger.loggingLevel | string | `"INFO"` | Logging level |
| arlas-uis.protocol | string | `"https"` | Do not change: value defined in global section |
| arlas-uis.uis.colors.arlas.bg | string | `"#182e6f"` | Primary color for ARLAS UI |
| arlas-uis.uis.colors.handle.color | string | `"#182e6f"` | Primary color for ARLAS handle |
| arlas-uis.uis.wui.basemapUrl | string | `nil` | Extra environment variables for the basemap url to download at init container startup (no download if already present). If none specified, a small basemap is used. See for instance https://build.protomaps.com/20231225.pmtiles for a full basemap or https://storage.googleapis.com/gisaia-public/protomaps/world-20231225-0-9.pmtiles for zoom 0 to 9. |
| arlas-uis.uis.wui.customi18nConfigMap | string | `"arlas-wui-custom-i18n"` | Configuration for the ARLAS Web User Interface (WUI) translation with a custom configmap. If you want to add custom translations, create a configmap with the same structure as the one in k8s/charts/arlas-stack/templates/arlas_i18n_custom_configmap.yaml file and set the name of this configmap here. If you don't want to add custom translations, set this value to null or empty string and do not create the configmap. Keys can be found in the ARLAS WUI codebase, in the i18n folder: https://github.com/gisaia/ARLAS-wui/tree/develop/src/assets/i18n. |
| deployment.aias.enabled | bool | `true` | Should the chart deploy aias-services |
| deployment.aias.services.airs.ingress.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` | Annotations for AIRS ingress |
| deployment.aias.services.airs.ingress.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/url-role-based-authorization"` | Annotations for AIRS ingress |
| deployment.aias.services.airs.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffering" | string | `"off"` | Annotations for AIRS ingress |
| deployment.aias.services.airs.ingress.enabled | bool | `true` | Should the chart deploy airs ingress |
| deployment.aias.services.aproc.ingress.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` | Annotations for APROC ingress |
| deployment.aias.services.aproc.ingress.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/url-role-based-authorization"` | Annotations for APROC ingress |
| deployment.aias.services.aproc.ingress.enabled | bool | `true` | Should the chart deploy aproc ingress |
| deployment.aias.services.fam.ingress.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` | Annotations for FAM ingress |
| deployment.aias.services.fam.ingress.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/url-role-based-authorization"` | Annotations for FAM ingress |
| deployment.aias.services.fam.ingress.enabled | bool | `true` | Should the chart deploy fam ingress |
| deployment.aias.services.minio.ingress.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` | Annotations for Minio ingress |
| deployment.aias.services.minio.ingress.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/authorization/airs-storage"` | Annotations for Minio ingress |
| deployment.aias.services.minio.ingress.enabled | bool | `true` | Should the chart deploy minio ingress |
| deployment.aias.services.minio.port | int | `9000` | Minio service port for AIAS |
| deployment.aias.services.minio.serviceName | string | `"arlas-stack-minio"` | Minio service configuration for AIAS |
| deployment.aias.services.titiler.ingress.enabled | bool | `true` | Should the chart deploy titiler ingress |
| deployment.aias.services.titiler.ingress.private.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` | Annotations for Titiler ingress |
| deployment.aias.services.titiler.ingress.private.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/authorization/cog"` | Annotations for Titiler ingress |
| deployment.aias.services.titiler.ingress.public.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` | Annotations for Titiler ingress |
| deployment.aias.services.titiler.ingress.public.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/authorization/titiler_public"` | Annotations for Titiler ingress |
| deployment.aias.services.titiler.port | int | `8000` | Titiler service port for AIAS |
| deployment.aias.services.titiler.serviceName | string | `"arlas-stack-titiler"` | Titiler service configuration for AIAS |
| deployment.aias.uis.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$1"` |  |
| deployment.aias.uis.ingress.annotations."nginx.ingress.kubernetes.io/use-regex" | string | `"true"` |  |
| deployment.aias.uis.ingress.enabled | bool | `true` | Should the chart deploy aias-uis ingress |
| deployment.arlas.services.enabled | bool | `true` | Should the chart deploy arlas-services |
| deployment.arlas.services.ingress.annotations | string | `nil` | Annotations for arlas-services ingress |
| deployment.arlas.services.ingress.enabled | bool | `true` | Should the chart deploy arlas-services ingress |
| deployment.arlas.uis.enabled | bool | `true` |  |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/force-ssl-redirect" | string | `"true"` | Annotation for ARLAS UI ingress |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffering" | string | `"off"` | Annotation for ARLAS UI ingress |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$1"` | Annotation for ARLAS UI ingress |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/use-regex" | string | `"true"` | Annotation for ARLAS UI ingress |
| deployment.arlas.uis.ingress.enabled | bool | `true` |  |
| deployment.elasticsearch.enabled | bool | `true` | Should the chart deploy elasticsearch |
| deployment.elasticsearch.ingress.enabled | bool | `true` | Should the chart deploy elasticsearch ingress |
| deployment.keycloak.enabled | bool | `true` | __MUST BE CONFIGURED:__ Should the chart deploy keycloak. __Enable for tests only__ or configure carefully the chart for your production needs. |
| deployment.minio.enabled | bool | `true` | Should the chart deploy minio |
| deployment.minio.ingress.enabled | bool | `true` | Should the chart deploy minio ingress |
| deployment.rabbitmq.enabled | bool | `true` | Should the chart deploy rabbitmq |
| deployment.redis.enabled | bool | `true` | Should the chart deploy redis |
| deployment.titiler.enabled | bool | `true` | Should the chart deploy titiler |
| elasticsearch.image.repository | string | `"bitnamilegacy/elasticsearch"` | Elasticsearch for development and test only. For production, please refer to the elasticsearch documentation to deploy a production ready elasticsearch instance instead. |
| global.authIssuer | string | `"https://keycloak.arlas.k8s/realms/arlas"` | __MUST BE CONFIGURED:__ The issuer's uri |
| global.celeryBrokerUrl | string | `"pyamqp://admin:secret4rabbitmq@arlas-stack-rabbitmq:5672//"` | __MUST BE CONFIGURED:__ RabbitMQ broker URL for APROC tasks |
| global.celeryResultBackend | string | `"redis://:secret4redis@arlas-stack-redis-master:6379/0"` | __MUST BE CONFIGURED:__ Redis backend URL for APROC task results |
| global.defaultStorageClass | string | `"standard-retain"` | __MUST BE CONFIGURED:__ The default ARLAS storage class for the persistence. By default, the `standard-retain` storage class is created based on the provisioner `rancher.io/local-path` with a retain policy. |
| global.dnsDomain | string | `"site.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing the ARLAS deployment |
| global.elasticDnsDomain | string | `"elastic.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing ES for ARLAS deployment |
| global.elasticLogin | string | `"elastic"` | Elasticsearch login for elasticsearch itself and the services that are connecting to elasticsearch |
| global.elasticPassword | string | `"secret4elastic"` | __MUST BE CONFIGURED:__ Elasticsearch password for elasticsearch itself and the services that are connecting to elasticsearch |
| global.ingressClassName | string | `"nginx"` | __MUST BE CONFIGURED:__ The default ingress class. By default, the `nginx` controler is used. |
| global.keycloak.secret | string | `"rha14c4202RB0Dxlke6ZNCCTw9gkvLJ8"` | __MUST BE CONFIGURED:__ The secret configured for the ARLAS client of the keyckloak's realm  |
| global.keycloak.url | string | `"https://keycloak.arlas.k8s"` | __MUST BE CONFIGURED:__ Keycloak URL |
| global.keycloakDnsDomain | string | `"keycloak.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing keycloak for ARLAS deployment |
| global.keycloakLogin | string | `"admin"` | Keycloak admin login for keycloak deployment (for test only) |
| global.keycloakPassword | string | `"secret4keycloak"` | __MUST BE CONFIGURED:__ Keycloak admin password  |
| global.logoutUrl | string | `nil` | The logout URL to be used |
| global.minioDnsDomain | string | `"minio.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing minio for ARLAS deployment |
| global.minioLogin | string | `"minioadmin"` | Minio login for minio itself and the services that are connecting to minio |
| global.minioPassword | string | `"secret4minio"` | __MUST BE CONFIGURED:__ Minio password for minio itself and the services that are connecting to minio |
| global.organization | string | `"org.com"` | __MUST BE CONFIGURED:__ Name of the organization using AIAS |
| global.postgresql.auth.password | string | `"secret4postgres"` | __MUST BE CONFIGURED:__ postgres password for keycloak |
| global.protocol | string | `"https"` | __MUST BE CONFIGURED:__ The protocol for accessing the ARLAS deployment |
| global.rabbitMQLogin | string | `"admin"` | RabbitMQ Login |
| global.rabbitMQPassword | string | `"secret4rabbitmq"` | __MUST BE CONFIGURED:__ RabbitMQ Password |
| global.redisPassword | string | `"secret4redis"` | __MUST BE CONFIGURED:__ redis Password |
| keycloak.httpsEnabled | bool | `true` |  |
| keycloak.httpsPort | int | `8443` |  |
| keycloak.image.repository | string | `"bitnamilegacy/keycloak"` | Keycloak for development and test only. For production, please refer to the Keycloak documentation to deploy a production ready Keycloak instance instead. |
| keycloak.proxyHeaders | string | `"xforwarded"` |  |
| minio.image.repository | string | `"bitnamilegacy/minio"` | Minio for development and test only. For production, please refer to the minio documentation to deploy a production ready minio instance instead. |
| rabbitmq.image.repository | string | `"bitnamilegacy/rabbitmq"` | Rabbitmq for development and test only. For production, please refer to the rabbitmq documentation to deploy a production ready rabbitmq instance instead. |
| redis.image.repository | string | `"bitnamilegacy/redis"` | Redis for development and test only. For production, please refer to the redis documentation to deploy a production ready redis instance instead. |
| titiler.podSecurityContext.fsGroup | int | `1001` |  |
| titiler.podSecurityContext.runAsNonRoot | bool | `true` |  |
| titiler.podSecurityContext.runAsUser | int | `1001` |  |
| titiler.replicaCount | int | `1` |  |
| titiler.resources.limits.cpu | int | `4` |  |
| titiler.resources.limits.memory | string | `"4Gi"` |  |
| titiler.resources.requests.cpu | float | `0.1` |  |
| titiler.resources.requests.memory | string | `"1Gi"` |  |
| titiler.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| titiler.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| titiler.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| titiler.securityContext.runAsNonRoot | bool | `true` |  |
| titiler.securityContext.runAsUser | int | `1001` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
