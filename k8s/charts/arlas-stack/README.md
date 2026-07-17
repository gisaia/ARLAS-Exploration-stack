# arlas-aias

![Version: 28.6.0](https://img.shields.io/badge/Version-28.6.0-informational?style=flat-square) ![AppVersion: 28.6.0](https://img.shields.io/badge/AppVersion-28.6.0-informational?style=flat-square)

A Helm Chart to deploy the ARLAS Exploration Stack with AIAS services

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../aias-services | aias-services | 28.6.0 |
| file://../arlas-services | arlas-services | 28.6.0 |
| file://../arlas-uis | arlas-uis | 28.6.0 |
| file://../titiler | titiler | 28.6.0 |
| https://charts.bitnami.com/bitnami | elasticsearch-logs(elasticsearch) | 22.0.4 |
| https://charts.bitnami.com/bitnami | elasticsearch-app(elasticsearch) | 22.0.4 |
| https://charts.bitnami.com/bitnami | keycloak | 25.2.0 |
| https://charts.bitnami.com/bitnami | minio | 14.10.5 |
| https://charts.bitnami.com/bitnami | rabbitmq | 16.0.11 |
| https://charts.bitnami.com/bitnami | redis | 21.2.13 |
| https://helm.elastic.co | apm-server | 8.5.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.authIssuer | string | `"https://keycloak.arlas.k8s/realms/arlas"` | __MUST BE CONFIGURED:__ The issuer's uri |
| global.celeryBrokerUrl | string | `"pyamqp://admin:secret4rabbitmq@arlas-stack-rabbitmq:5672//"` | __MUST BE CONFIGURED:__ RabbitMQ broker URL for APROC tasks |
| global.celeryResultBackend | string | `"redis://:secret4redis@arlas-stack-redis-master:6379/0"` | __MUST BE CONFIGURED:__ Redis backend URL for APROC task results |
| global.defaultStorageClass | string | `"standard-retain"` | __MUST BE CONFIGURED:__ The default ARLAS storage class for the persistence. By default, the `standard-retain` storage class is created based on the provisioner `rancher.io/local-path` with a retain policy. |
| global.dnsDomain | string | `"site.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing the ARLAS deployment |
| global.elasticDnsDomain | string | `"elastic.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing ES for ARLAS deployment |
| global.elasticLogin | string | `"elastic"` | Elasticsearch login for elasticsearch itself and the services that are connecting to elasticsearch |
| global.elasticLogsDnsDomain | string | `"elastic.logs.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing ES for logs for ARLAS deployment |
| global.elasticLogsLogin | string | `"elasticlogs"` | Elasticsearch login for elasticsearch-logs itself and the services that are connecting to elasticsearch-logs |
| global.elasticLogsPassword | string | `"secret4elasticlogs"` | __MUST BE CONFIGURED:__ Elasticsearch password for elasticsearch-logs itself and the services that are connecting to elasticsearch-logs |
| global.elasticPassword | string | `"secret4elastic"` | __MUST BE CONFIGURED:__ Elasticsearch password for elasticsearch itself and the services that are connecting to elasticsearch |
| global.enableKibana | bool | `true` |  |
| global.enableKibanaLogs | bool | `true` |  |
| global.ingressClassName | string | `"nginx"` | __MUST BE CONFIGURED:__ The default ingress class. By default, the `nginx` controler is used. |
| global.keycloak.secret | string | `"rha14c4202RB0Dxlke6ZNCCTw9gkvLJ8"` | __MUST BE CONFIGURED:__ The secret configured for the ARLAS client of the keyckloak's realm  |
| global.keycloak.url | string | `"https://keycloak.arlas.k8s"` | __MUST BE CONFIGURED:__ Keycloak URL |
| global.keycloakDnsDomain | string | `"keycloak.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing keycloak for ARLAS deployment |
| global.keycloakLogin | string | `"admin"` | Keycloak admin login for keycloak deployment (for test only) |
| global.keycloakPassword | string | `"secret4keycloak"` | __MUST BE CONFIGURED:__ Keycloak admin password  |
| global.kibanaDnsDomain | string | `"kibana.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing kibana for ARLAS deployment |
| global.kibanaLogsDnsDomain | string | `"kibana.logs.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing kibana for logs for ARLAS deployment |
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
| aias-services.services.aproc.configuration.extensions.ingest.aprocEndpoint | string | `"http://aproc-service:8000"` | APROC endpoint URL accessed by ingest processes |
| aias-services.services.aproc.configuration.extensions.ingest.inputsDirectory | string | `"https://storage.googleapis.com/gisaia-public/test-aias"` | Directory where archives to ingest are stored. Must be in sync with the accessManager readable_paths configuration below. Examples: /inputs, https://storage.googleapis.com/gisaia-public/OPENDATA/eo inputsDirectory: http://arlas-stack-minio:9000/inputs |
| aias-services.services.aproc.service.serviceName | string | `"aproc-service"` | APROC service name |
| aias-services.services.aproc.worker | object | `{"affinity":{},"nodeSelector":{},"replicaCount":1,"resources":{"limits":{"cpu":2,"memory":"10Gi"}},"tolerations":[]}` | APROC worker configuration |
| aias-services.services.fam.serviceName | string | `"arlas-fam"` | FAM service name |
| apm-server.apmConfig."apm-server.yml" | string | `"apm-server:\n  host: \"0.0.0.0:8200\"\n  data_streams:\n    wait_for_integration: false\noutput.elasticsearch:\n  hosts: [\"https://arlas-stack-elasticsearch-logs:9200\"]\n  username: \"${ELASTICSEARCH_USERNAME}\"\n  password: \"${ELASTICSEARCH_PASSWORD}\"\n  protocol: \"https\"\n  ssl.verification_mode: \"none\"\nsetup.kibana:\n  host: \"http://arlas-stack-kibana-logs:5601\"\n"` |  |
| apm-server.extraEnvs[0].name | string | `"ELASTICSEARCH_PASSWORD"` |  |
| apm-server.extraEnvs[0].value | string | `"secret4elasticlogs"` |  |
| apm-server.extraEnvs[1].name | string | `"ELASTICSEARCH_USERNAME"` |  |
| apm-server.extraEnvs[1].value | string | `"elastic"` |  |
| apm-server.fullnameOverride | string | `"arlas-stack-apm-server"` |  |
| apm-server.service.port | int | `8200` |  |
| apm-server.service.type | string | `"ClusterIP"` |  |
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
| deployment.apmServer.enabled | bool | `true` | Should the chart deploy apm-server to collect log with OTEL |
| deployment.arlas.services.enabled | bool | `true` | Should the chart deploy arlas-services |
| deployment.arlas.services.ingress.annotations | string | `nil` | Annotations for arlas-services ingress |
| deployment.arlas.services.ingress.enabled | bool | `true` | Should the chart deploy arlas-services ingress |
| deployment.arlas.uis.enabled | bool | `true` |  |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/force-ssl-redirect" | string | `"true"` | Annotation for ARLAS UI ingress |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffering" | string | `"off"` | Annotation for ARLAS UI ingress |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$1"` | Annotation for ARLAS UI ingress |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/use-regex" | string | `"true"` | Annotation for ARLAS UI ingress |
| deployment.arlas.uis.ingress.enabled | bool | `true` |  |
| deployment.elasticsearch.app.enabled | bool | `true` | Should the chart deploy elasticsearch for store applicative data |
| deployment.elasticsearch.app.ingress.enabled | bool | `true` | Should the chart deploy elasticsearch app ingress |
| deployment.elasticsearch.logs.enabled | bool | `true` | Should the chart deploy elasticsearch-logs for store logs |
| deployment.elasticsearch.logs.ingress.enabled | bool | `true` | Should the chart deploy elasticsearch-logs ingress |
| deployment.keycloak.enabled | bool | `true` | __MUST BE CONFIGURED:__ Should the chart deploy keycloak. __Enable for tests only__ or configure carefully the chart for your production needs. |
| deployment.minio.enabled | bool | `true` | Should the chart deploy minio |
| deployment.minio.ingress.enabled | bool | `true` | Should the chart deploy minio ingress |
| deployment.rabbitmq.enabled | bool | `true` | Should the chart deploy rabbitmq |
| deployment.redis.enabled | bool | `true` | Should the chart deploy redis |
| deployment.titiler.enabled | bool | `true` | Should the chart deploy titiler |
| elasticsearch-app.<<.copyTlsCerts.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearch-app.<<.image.repository | string | `"bitnamilegacy/elasticsearch"` | Elasticsearch for development and test only. For production, please refer to the elasticsearch documentation to deploy a production ready elasticsearch instance instead. |
| elasticsearch-app.<<.metrics.annotations | object | `{}` |  |
| elasticsearch-app.<<.metrics.enabled | bool | `false` |  |
| elasticsearch-app.<<.sysctl.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearch-app.<<.sysctlImage.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearch-app.<<.volumePermissions.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearch-app.fullnameOverride | string | `"arlas-stack-elasticsearch"` |  |
| elasticsearch-app.kibana.elasticsearch.hosts[0] | string | `"arlas-stack-elasticsearch"` |  |
| elasticsearch-app.kibana.elasticsearch.port | int | `9200` |  |
| elasticsearch-app.kibana.elasticsearch.security.auth.createSystemUser | bool | `true` |  |
| elasticsearch-app.kibana.elasticsearch.security.auth.elasticsearchPasswordSecret | string | `"arlas-stack-elasticsearch"` |  |
| elasticsearch-app.kibana.elasticsearch.security.auth.enabled | bool | `true` |  |
| elasticsearch-app.kibana.elasticsearch.security.auth.kibanaPassword | string | `"secret4elastic"` |  |
| elasticsearch-app.kibana.elasticsearch.security.auth.kibanaUsername | string | `"elastic"` |  |
| elasticsearch-app.kibana.elasticsearch.security.tls.enabled | bool | `true` |  |
| elasticsearch-app.kibana.elasticsearch.security.tls.existingSecret | string | `"arlas-stack-elasticsearch-master-crt"` |  |
| elasticsearch-app.kibana.elasticsearch.security.tls.usePemCerts | bool | `true` |  |
| elasticsearch-app.kibana.fullnameOverride | string | `"arlas-stack-kibana"` |  |
| elasticsearch-app.kibana.image.repository | string | `"bitnamilegacy/kibana"` | Elasticsearch for development and test only. For production, please refer to the elasticsearch documentation to deploy a production ready elasticsearch instance instead. |
| elasticsearch-app.kibana.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| elasticsearch-app.kibana.ingress.annotations."nginx.ingress.kubernetes.io/backend-protocol" | string | `"HTTP"` |  |
| elasticsearch-app.kibana.ingress.enabled | bool | `true` |  |
| elasticsearch-app.kibana.ingress.hostname | string | `"kibana.arlas.k8s"` |  |
| elasticsearch-app.kibana.ingress.ingressClassName | string | `"nginx"` |  |
| elasticsearch-app.kibana.ingress.tls | bool | `false` |  |
| elasticsearch-app.kibana.volumePermissions.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearch-logs.<<.copyTlsCerts.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearch-logs.<<.image.repository | string | `"bitnamilegacy/elasticsearch"` | Elasticsearch for development and test only. For production, please refer to the elasticsearch documentation to deploy a production ready elasticsearch instance instead. |
| elasticsearch-logs.<<.metrics.annotations | object | `{}` |  |
| elasticsearch-logs.<<.metrics.enabled | bool | `false` |  |
| elasticsearch-logs.<<.sysctl.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearch-logs.<<.sysctlImage.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearch-logs.<<.volumePermissions.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearch-logs.fullnameOverride | string | `"arlas-stack-elasticsearch-logs"` |  |
| elasticsearch-logs.kibana.elasticsearch.hosts[0] | string | `"arlas-stack-elasticsearch-logs"` |  |
| elasticsearch-logs.kibana.elasticsearch.port | int | `9200` |  |
| elasticsearch-logs.kibana.elasticsearch.security.auth.createSystemUser | bool | `true` |  |
| elasticsearch-logs.kibana.elasticsearch.security.auth.elasticsearchPasswordSecret | string | `"arlas-stack-elasticsearch-logs"` |  |
| elasticsearch-logs.kibana.elasticsearch.security.auth.enabled | bool | `true` |  |
| elasticsearch-logs.kibana.elasticsearch.security.auth.kibanaPassword | string | `"secret4elasticlogs"` |  |
| elasticsearch-logs.kibana.elasticsearch.security.auth.kibanaUsername | string | `"elastic"` |  |
| elasticsearch-logs.kibana.elasticsearch.security.tls.enabled | bool | `true` |  |
| elasticsearch-logs.kibana.elasticsearch.security.tls.existingSecret | string | `"arlas-stack-elasticsearch-logs-master-crt"` |  |
| elasticsearch-logs.kibana.elasticsearch.security.tls.usePemCerts | bool | `true` |  |
| elasticsearch-logs.kibana.fullnameOverride | string | `"arlas-stack-kibana-logs"` |  |
| elasticsearch-logs.kibana.image.repository | string | `"bitnamilegacy/kibana"` | Elasticsearch for development and test only. For production, please refer to the elasticsearch documentation to deploy a production ready elasticsearch instance instead. |
| elasticsearch-logs.kibana.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| elasticsearch-logs.kibana.ingress.annotations."nginx.ingress.kubernetes.io/backend-protocol" | string | `"HTTP"` |  |
| elasticsearch-logs.kibana.ingress.enabled | bool | `true` |  |
| elasticsearch-logs.kibana.ingress.hostname | string | `"kibana.logs.arlas.k8s"` |  |
| elasticsearch-logs.kibana.ingress.ingressClassName | string | `"nginx"` |  |
| elasticsearch-logs.kibana.ingress.tls | bool | `false` |  |
| elasticsearch-logs.kibana.volumePermissions.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearchCommon.copyTlsCerts.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearchCommon.image.repository | string | `"bitnamilegacy/elasticsearch"` | Elasticsearch for development and test only. For production, please refer to the elasticsearch documentation to deploy a production ready elasticsearch instance instead. |
| elasticsearchCommon.metrics.annotations | object | `{}` |  |
| elasticsearchCommon.metrics.enabled | bool | `false` |  |
| elasticsearchCommon.sysctl.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearchCommon.sysctlImage.repository | string | `"bitnamilegacy/os-shell"` |  |
| elasticsearchCommon.volumePermissions.image.repository | string | `"bitnamilegacy/os-shell"` |  |
| keycloak.httpsEnabled | bool | `true` |  |
| keycloak.httpsPort | int | `8443` |  |
| keycloak.image.repository | string | `"bitnamilegacy/keycloak"` | Keycloak for development and test only. For production, please refer to the Keycloak documentation to deploy a production ready Keycloak instance instead. |
| keycloak.proxyHeaders | string | `"xforwarded"` |  |
| minio.image.repository | string | `"bitnamilegacy/minio"` | Minio for development and test only. For production, please refer to the minio documentation to deploy a production ready minio instance instead. |
| rabbitmq.image.repository | string | `"bitnamilegacy/rabbitmq"` | Rabbitmq for development and test only. For production, please refer to the rabbitmq documentation to deploy a production ready rabbitmq instance instead. |
| redis.image.repository | string | `"bitnamilegacy/redis"` | Redis for development and test only. For production, please refer to the redis documentation to deploy a production ready redis instance instead. |
| titiler.image.tag | string | `"0.22.4"` |  |
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
| aias-services.cors.allowedCredentials | bool | `true` | CORS Allowed Credentials or not |
| aias-services.cors.allowedHeaders | string | `"arlas-user,arlas-groups,arlas-organization,arlas-org-filter,X-Requested-With,Content-Type,Accept,Origin,Authorization,X-Forwarded-User"` | CORS Allowed Headers |
| aias-services.cors.allowedHosts | string | `"0.0.0.0"` |  |
| aias-services.cors.allowedMethods | string | `"OPTIONS,GET,PUT,POST,DELETE,HEAD"` | Allowed hosts |
| aias-services.cors.allowedOrigins | string | `"\"*\""` | CORS Allowed Origins |
| aias-services.cors.exposedHeaders | string | `"Content-Type,Authorization,X-Requested-With,Content-Length,Accept,Origin,Location,WWW-Authenticate"` | CORS Exposed Headers |
| aias-services.dnsDomain | string | `"localhost"` | DNS domain hosting ARLAS |
| aias-services.elastic.cluster | string | `"elastic"` | Elasticsearch cluster name |
| aias-services.elastic.endpoint | string | `"https://elasticsearch:9200"` | Elasticsearch endpoint URL for AIRS and APROC services |
| aias-services.elastic.login | string | `"elastic"` | Elasticsearch login |
| aias-services.elastic.password | string | `"elastic"` | Elasticsearch password |
| aias-services.initBuckets | bool | `false` | Whether to initialize the S3 buckets used by AIRS service at startup or not |
| aias-services.logger.loggingConsoleLevel | string | `"INFO"` | Default console logging level |
| aias-services.logger.loggingLevel | string | `"INFO"` | Default logging level |
| aias-services.protocol | string | `"http"` | HTTP protocol used to access AIAS services |
| aias-services.services.agate.affinity | object | `{}` | Affinity for AGATE service pods |
| aias-services.services.agate.configuration.arlasUrlSearch | string | `"http://arlas-server:8000/arlas/explore/{collection}/_search?f=id:eq:{item}"` | ARLAS endpoint used by AGATE to check whether an item is accessible or not |
| aias-services.services.agate.configuration.methodHeader | string | `"x-forwarded-method"` | URBAC HTTP header containing the method of the original request |
| aias-services.services.agate.configuration.nbWorkers | int | `4` | Number of worker processes for AGATE |
| aias-services.services.agate.configuration.roles.group/public | object | `{"description":["Public group"],"permissions":["r:session:DELETE","r:permissions:GET","r:organisations:GET,POST","r:organisations/check:GET","r:users/.*:GET,PUT,DELETE"]}` | Public role. See example at https://raw.githubusercontent.com/gisaia/ARLAS-server/master/arlas-commons/src/main/resources/roles.yaml |
| aias-services.services.agate.configuration.roles.role/arlas/builder | object | `{"description":["Building dashboards in ARLAS"],"permissions":["r:collections:GET","r:collections/.*:PATCH,PUT,DELETE","r:collections/_export:GET","r:collections/_import:POST","r:persist/resource/.*:PUT,POST,DELETE"]}` | ARLAS Builder role |
| aias-services.services.agate.configuration.roles.role/arlas/datasets | object | `{"description":["Managing data (ingest, update and enrich) in ARLAS"],"permissions":["r:datasets/.*:GET,PUT,POST,DELETE","r:/aproc/processes/ingest:GET","r:/aproc/processes/ingest/execution:POST","r:/aproc/processes/enrich:GET","r:/aproc/processes/enrich/execution:POST","r:/aproc/processes/directory_ingest:GET","r:/aproc/processes/directory_ingest/execution:POST","r:/aproc/processes/dc3build:GET","r:/aproc/processes/dc3build/execution:POST","r:/fam/.*:GET,POST","r:/aproc/jobs/.*:GET,DELETE","r:/aproc/jobs:GET","r:/airs/collections:GET","r:/airs/collections/.*:GET,POST,PUT,DELETE"]}` | ARLAS Datasets role |
| aias-services.services.agate.configuration.roles.role/arlas/downloader | object | `{"description":["Download data from ARLAS"],"permissions":["r:/aproc/processes/download:GET","r:/aproc/processes/download/execution:POST","r:/aproc/jobs/.*:GET,DELETE"]}` | ARLAS Downloader role |
| aias-services.services.agate.configuration.roles.role/arlas/owner | object | `{"description":["Managing users and permissions of ARLAS"],"permissions":["r:permissions:GET","r:collections:GET","r:organisations:GET,POST","r:organisations/.*:GET,POST,PUT,DELETE","r:users/.*:GET,PUT,DELETE","r:session:DELETE"]}` | ARLAS Owner role |
| aias-services.services.agate.configuration.roles.role/arlas/tagger | object | `{"description":["Tagging data in ARLAS"],"permissions":["r:write/.*:POST","r:status/.*:GET"]}` | ARLAS Tagger role |
| aias-services.services.agate.configuration.roles.role/arlas/user | object | `{"description":["Viewing data in ARLAS"],"permissions":["h:arlas-organization:${org}","h:arlas-workspace:${ws}","r:explore/.*:GET,POST","r:collections/.*:GET","r:explore/_list:GET","r:explore/ogc/opensearch/.*:GET","r:ogc/.*:GET","r:stac:GET","r:openapi.json:GET","r:stac/.*:GET,POST","r:persist/resource/.*:GET","r:persist/groups/.*:GET","r:persist/resources/.*:GET","r:authorize/resources:GET"]}` | ARLAS User role |
| aias-services.services.agate.configuration.roles.role/iam/admin | object | `{"description":["IAM admin"],"permissions":["r:organisations:GET,POST","r:organisations/.*:GET,POST,DELETE","r:users/.*:GET,PUT,DELETE","r:session:DELETE","r:permissions:GET"]}` | IAM Admin role |
| aias-services.services.agate.configuration.roles.role/m2m/importer.description[0] | string | `"M2M account for importing collections"` |  |
| aias-services.services.agate.configuration.roles.role/m2m/importer.permissions[0] | string | `"r:collections:GET"` |  |
| aias-services.services.agate.configuration.roles.role/m2m/importer.permissions[1] | string | `"r:collections/.*:PATCH,PUT,DELETE"` |  |
| aias-services.services.agate.configuration.roles.role/m2m/importer.permissions[2] | string | `"r:collections/_import:POST"` |  |
| aias-services.services.agate.configuration.roles.role/m2m/importer.permissions[3] | string | `"r:organisations/.*:GET"` |  |
| aias-services.services.agate.configuration.roles.role/m2m/importer.permissions[4] | string | `"r:persist/resource/.*:POST,PUT"` |  |
| aias-services.services.agate.configuration.services.airs-storage.jwt_location | list | `["headers"]` | Locations where to find the JWT token for storage access |
| aias-services.services.agate.configuration.services.airs-storage.jwt_name | string | `"authorization"` | Name of the header containing the JWT token |
| aias-services.services.agate.configuration.services.airs-storage.private | list | `[{"part":"path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/overview"},{"part":"path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/cog"}]` | Patterns for private assets |
| aias-services.services.agate.configuration.services.airs-storage.public | list | `[{"part":"path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/thumbnail"}]` | Patterns for private assets |
| aias-services.services.agate.configuration.services.cog | object | `{"jwt_location":["headers","query_params"],"jwt_name":"authorization","private":[{"part":"query.url.url.path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/(?P<asset>[^/]+)"}]}` | Configuration for accessing private COG assets |
| aias-services.services.agate.configuration.services.cog.jwt_location | list | `["headers","query_params"]` | Locations where to find the JWT token for COG access |
| aias-services.services.agate.configuration.services.cog.jwt_name | string | `"authorization"` | Name of the header containing the JWT token for COG access |
| aias-services.services.agate.configuration.services.cog.private | list | `[{"part":"query.url.url.path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/(?P<asset>[^/]+)"}]` | Patterns for private COG assets |
| aias-services.services.agate.configuration.services.titiler_public.public | list | `[{"part":"path","pattern":"(/colorMaps/)(.*)"}]` | Patterns for public COG statistics access |
| aias-services.services.agate.configuration.urbac.jwks_uri | string | `"https://keycloak.arlas.k8s/realms/arlas/protocol/openid-connect/certs"` | Keys endpoint |
| aias-services.services.agate.configuration.urbac.jwtAudience | string | `"arlas-backend"` | Expected audience in the JWT token |
| aias-services.services.agate.configuration.urbac.jwtHeader | string | `"authorization"` | URBAC HTTP header containing the JWT token of the original request |
| aias-services.services.agate.configuration.urbac.verifyJwt | bool | `true` | Whether to verify the JWT signature or not |
| aias-services.services.agate.configuration.urbac.verifySsl | bool | `true` | Whether to verify the SSL certificate of the OpenID Provider or not |
| aias-services.services.agate.configuration.urlHeader | string | `"x-forwarded-uri"` | HTTP header containing the original request URL |
| aias-services.services.agate.extraContainers | list | `[]` |  |
| aias-services.services.agate.extraEnv | string | `nil` |  |
| aias-services.services.agate.extraInitContainers | string | `nil` |  |
| aias-services.services.agate.extraVolumeMounts | string | `nil` |  |
| aias-services.services.agate.extraVolumes | string | `nil` |  |
| aias-services.services.agate.image | string | `"gisaia/agate:0.16.1"` |  |
| aias-services.services.agate.imagePullSecrets | list | `[]` | Extra environment variables for the agate container |
| aias-services.services.agate.nodeSelector | object | `{}` | Node selector for AGATE service pods |
| aias-services.services.agate.replicaCount | int | `1` | Number of AGATE service replicas |
| aias-services.services.agate.resources | object | `{"limits":{"cpu":0.5,"memory":"256Mi"},"requests":{"cpu":0.1,"memory":"50Mi"}}` | Resources configuration for AGATE service |
| aias-services.services.agate.serviceBinding | string | `"0.0.0.0"` |  |
| aias-services.services.agate.serviceName | string | `"arlas-agate"` |  |
| aias-services.services.agate.tolerations | list | `[]` | Tolerations for AGATE service pods |
| aias-services.services.agate.urlPrefix | string | `"/agate"` |  |
| aias-services.services.airs.affinity | object | `{}` | Affinity for AIRS service pods |
| aias-services.services.airs.configuration.arlaseoCollectionUrl | string | `"https://raw.githubusercontent.com/gisaia/ARLAS-EO/v1.3.0/collection.json"` | ARLAS-EO collection URL used for initializing new collections. |
| aias-services.services.airs.configuration.arlaseoMappingUrl | string | `"/app/mappings/arlas_eo_mapping.json"` | ARLAS-EO mapping and collection URLs used for initializing new indices of new collections |
| aias-services.services.airs.configuration.indexCollectionPrefix | string | `"org.com@airs"` | Prefix for elasticsearch indices created for AIRS collections. This MUST contain the organization name followed by '@' followed by a custom suffix, e.g. org.com@airs |
| aias-services.services.airs.configuration.s3.accessKeyId | string | `"airs"` | S3 access key id |
| aias-services.services.airs.configuration.s3.assetHttpEndpointUrl | string | `"https://arlas-stack-minio:9000/{}/{}"` | Public URL Pattern to access assets over HTTPS, must look like http(s)://your-s3-endpoint/{}/{} where first {} is the bucket, second {} is the path to the object. This is used to generate the asset URLs in the STAC item |
| aias-services.services.airs.configuration.s3.bucket | string | `"airs-storage"` | S3 bucket name for storing and accessing the STAC collections, items and managed assets |
| aias-services.services.airs.configuration.s3.endpointUrl | string | `"http://arlas-stack-minio:9000"` | S3 internal endpoint URL, e.g. http://minio:9000 |
| aias-services.services.airs.configuration.s3.platform | string | `"MINIO"` | S3 platform type. This value is provided in the item properties of the STAC item |
| aias-services.services.airs.configuration.s3.region | string | `nil` | S3 bucket's region. This value is provided in the item properties of the STAC item |
| aias-services.services.airs.configuration.s3.secretAccessKey | string | `"airssecret"` | S3 secret access key |
| aias-services.services.airs.configuration.s3.tier | string | `"Standard"` | S3 bucket's tier. This value is provided in the item properties of the STAC item |
| aias-services.services.airs.configuration.s3.writablePaths | list | `["/"]` | List of writable paths in the S3 bucket |
| aias-services.services.airs.extraContainers | list | `[]` |  |
| aias-services.services.airs.extraEnv | list | `[]` |  |
| aias-services.services.airs.extraInitContainers | list | `[]` |  |
| aias-services.services.airs.extraVolumeMounts | list | `[]` |  |
| aias-services.services.airs.extraVolumes | list | `[]` |  |
| aias-services.services.airs.image | string | `"gisaia/airs:0.16.1"` |  |
| aias-services.services.airs.imagePullSecrets | list | `[]` |  |
| aias-services.services.airs.nodeSelector | object | `{}` | Node selector for AIRS service pods |
| aias-services.services.airs.replicaCount | int | `1` | Number of AIRS service replicas |
| aias-services.services.airs.resources | object | `{"limits":{"cpu":0.5,"memory":"2Gi"},"requests":{"cpu":0.1,"memory":"50Mi"}}` | Resources configuration for AIRS service |
| aias-services.services.airs.serviceBinding | string | `"0.0.0.0"` |  |
| aias-services.services.airs.serviceName | string | `"airs-server"` |  |
| aias-services.services.airs.tolerations | list | `[]` | Tolerations for AIRS service pods |
| aias-services.services.airs.urlPrefix | string | `"/airs"` |  |
| aias-services.services.aproc.configuration.accessManager.storages | list | `[{"readable_paths":["/inputs"],"type":"file","writable_paths":["/tmp","/outbox"]},{"bucket":"archives","endpoint":"$APROC_ARCHIVE_ENDPOINT|http://minio:9000\"","readable_paths":["/inputs"],"type":"s3"},{"bucket":"downloads","endpoint":"http://minio:9000","readable_paths":["/"],"type":"s3","writable_paths":["/"]}]` | Configuration of the storages used by the access manager to provide access to various storage backends |
| aias-services.services.aproc.configuration.accessManager.tmpDir | string | `"/tmp/"` | Temporary directory used by the access manager |
| aias-services.services.aproc.configuration.airsEndpoint | string | `"http://airs-server:8000/arlas/airs"` | AIRS service endpoint URL accessed by APROC |
| aias-services.services.aproc.configuration.arlasUrlSearch | string | `"http://arlas-server:8000/arlas/explore/{collection}/_search?f=id:eq:{item}"` | ARLAS search URL used by APROC to check whether an item exists |
| aias-services.services.aproc.configuration.celeryBrokerUrl | string | `"pyamqp://guest:guest@rabbitmq:5672//"` | Celery broker URL for APROC tasks |
| aias-services.services.aproc.configuration.celeryResultBackend | string | `"redis://:somepassword@redis-master:6379/0"` |  |
| aias-services.services.aproc.configuration.celeryResultBackendTransportOptions | string | `nil` |  |
| aias-services.services.aproc.configuration.extensions.dc3build.drivers.safe.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.dc3build.drivers.safe.priority | int | `1` |  |
| aias-services.services.aproc.configuration.extensions.dc3build.enabled | bool | `true` | Whether the DC3 build extension is enabled or not |
| aias-services.services.aproc.configuration.extensions.directoryIngest.enabled | bool | `true` | Whether the directory ingest extension is enabled or not |
| aias-services.services.aproc.configuration.extensions.download.cleanOutboxDir | bool | `true` | should directory where download are temporally built before copy are cleaned |
| aias-services.services.aproc.configuration.extensions.download.downloadMappingUrl | string | `"/app/mappings/arlas_eo_download_mapping.json"` | Downloads mapping configuration for indexing the download requests |
| aias-services.services.aproc.configuration.extensions.download.drivers.copy | object | `{"enabled":true,"priority":4}` | drivers used for building the downloads. This list should remain as is unless you have custom download drivers |
| aias-services.services.aproc.configuration.extensions.download.drivers.imageFile.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.download.drivers.imageFile.priority | int | `3` |  |
| aias-services.services.aproc.configuration.extensions.download.drivers.metFile.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.download.drivers.metFile.priority | int | `2` |  |
| aias-services.services.aproc.configuration.extensions.download.drivers.zarr.enabled | bool | `false` |  |
| aias-services.services.aproc.configuration.extensions.download.drivers.zarr.priority | int | `1` |  |
| aias-services.services.aproc.configuration.extensions.download.emails.message.admin.emails | string | `"admin@the.boss,someone.else@the.boss"` | admin emails that will receive the download notifications, other than the user himself |
| aias-services.services.aproc.configuration.extensions.download.emails.message.done.admin | object | `{"content":"The download of {collection}/{item_id} for {arlas-user-email} is available in {target_directory} ({file_name}) for projection {target_projection} ({target_format}). <br>ARLAS Services.","subject":"The download of {collection}/{item_id} for {arlas-user-email} is available."}` | Message templates for download done notifications to admins |
| aias-services.services.aproc.configuration.extensions.download.emails.message.done.user | object | `{"content":"ARLAS Services - Dear {arlas-user-email}. <br>Your download of {collection}/{item_id} is available for projection {target_projection} ({target_format}). <br>ARLAS Services.","subject":"ARLAS Services - Your download of {collection}/{item_id} is available."}` | Message templates for download done notifications to users |
| aias-services.services.aproc.configuration.extensions.download.emails.message.error | object | `{"content":"ARLAS Services - The download of {collection}/{item_id} failed ({error}).","subject":"ARLAS Services - ERROR - The download of {collection}/{item_id} failed."}` | Message templates for download error notifications to users and admins |
| aias-services.services.aproc.configuration.extensions.download.emails.message.path.prefix | string | `"file:/"` | prefix to put in front of the path for emails |
| aias-services.services.aproc.configuration.extensions.download.emails.message.path.windows | bool | `false` | change to windows path |
| aias-services.services.aproc.configuration.extensions.download.emails.message.request.admin | object | `{"content":"ARLAS Services - {arlas-user-email} requested the download of {collection}/{item_id} for projection {target_projection} ({target_format}). <br>ARLAS Services.","subject":"ARLAS Services - {arlas-user-email} requested the download of {collection}/{item_id}."}` | Message templates for download request notifications to admins |
| aias-services.services.aproc.configuration.extensions.download.emails.message.request.user | object | `{"content":"ARLAS Services - Dear {arlas-user-email}. <br>Your download request for {collection}/{item_id} with projection {target_projection} ({target_format}) will shortly be taken into account. <br>ARLAS Services.","subject":"ARLAS Services - Thank you for your download request (({collection}/{item_id})."}` | Message templates for download request notifications to users |
| aias-services.services.aproc.configuration.extensions.download.enabled | bool | `true` | Whether the download extension is enabled or not |
| aias-services.services.aproc.configuration.extensions.download.index.name | string | `"aproc_downloads"` | Elasticsearch index name for the download requests |
| aias-services.services.aproc.configuration.extensions.download.outboxDirectory | string | `"/tmp/downloads"` | where downloads are placed |
| aias-services.services.aproc.configuration.extensions.download.outboxS3 | object | `{"accessKeyId":"airs","assetHttpEndpointUrl":"http://arlas-stack-minio:9000/{}/{}","bucket":"downloads","endpointUrl":"http://arlas-stack-minio:9000","secretAccessKey":"airssecret"}` | S3 configuration for uploading the built downloads |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.accessKeyId | string | `"airs"` | S3 access key id for uploading the built downloads |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.assetHttpEndpointUrl | string | `"http://arlas-stack-minio:9000/{}/{}"` | Public URL Pattern to access the built downloads over HTTPS, must look like http(s)://your-s3-endpoint/{}/{} where first {} is the bucket, second {} is the path to the object |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.bucket | string | `"downloads"` | S3 bucket name for uploading the built downloads |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.endpointUrl | string | `"http://arlas-stack-minio:9000"` | S3 endpoint URL for uploading the built downloads |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.secretAccessKey | string | `"airssecret"` | S3 secret access key for uploading the built downloads |
| aias-services.services.aproc.configuration.extensions.enrich.drivers.s2_cog.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.enrich.drivers.s2_cog.priority | int | `1` |  |
| aias-services.services.aproc.configuration.extensions.enrich.enabled | bool | `true` | Whether the enrich extension is enabled or not |
| aias-services.services.aproc.configuration.extensions.ingest.aprocEndpoint | string | `"http://aproc-service:8000"` | APROC endpoint URL accessed by the ingest extension |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.astDem.build_overview_when_local | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.astDem.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.astDem.priority | int | `4` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.axelspace.build_overview_when_local | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.axelspace.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.axelspace.priority | int | `16` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.bsg.build_overview_when_local | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.bsg.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.bsg.priority | int | `10` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.capella.build_overview_when_local | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.capella.build_overview_when_remote | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.capella.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.capella.priority | int | `21` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.cosmoskymed.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.cosmoskymed.priority | int | `8` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.digitalglobe.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.digitalglobe.priority | int | `3` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.dimap.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.dimap.priority | int | `1` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.geoeyes.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.geoeyes.priority | int | `2` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.geosat.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.geosat.priority | int | `17` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.iceye.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.iceye.priority | int | `13` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.jpeg2000.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.jpeg2000.priority | int | `101` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.landsat.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.landsat.priority | int | `19` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.opencosmos.build_overview_when_local | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.opencosmos.build_overview_when_remote | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.opencosmos.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.opencosmos.priority | int | `23` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.opencosmos.product_types[0] | string | `"platero"` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.opencosmos.product_types[1] | string | `"hammer"` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.radarsat2.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.radarsat2.priority | int | `14` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.rapideye.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.rapideye.priority | int | `5` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.satellogic.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.satellogic.priority | int | `20` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.sentinel1.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.sentinel1.priority | int | `12` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.sentinel2.build_overview_when_remote | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.sentinel2.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.sentinel2.priority | int | `11` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.skysat.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.skysat.priority | int | `15` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.spot5.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.spot5.priority | int | `6` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.superview.build_overview_when_local | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.superview.build_overview_when_remote | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.superview.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.superview.priority | int | `22` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.terrasarx.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.terrasarx.priority | int | `7` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.tiff.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.tiff.priority | int | `100` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.umbra.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.umbra.priority | int | `9` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.umbra_stac.build_overview_when_local | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.umbra_stac.build_overview_when_remote | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.umbra_stac.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.umbra_stac.priority | int | `9` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.wyvern.enabled | bool | `true` |  |
| aias-services.services.aproc.configuration.extensions.ingest.drivers.wyvern.priority | int | `18` |  |
| aias-services.services.aproc.configuration.extensions.ingest.enabled | bool | `true` | Whether the archive ingest extension is enabled or not |
| aias-services.services.aproc.configuration.extensions.ingest.inputsDirectory | string | `"/inputs"` | Directory where archives to ingest are stored |
| aias-services.services.aproc.configuration.extensions.ingest.maxNumberOfArchivesForIngest | int | `100000` | Maximum number of archives that can be ingested in a single batch |
| aias-services.services.aproc.configuration.extensions.ingest.resourceIdHashStartAt | int | `1` |  |
| aias-services.services.aproc.service.affinity | object | `{}` | Affinity for APROC service pods |
| aias-services.services.aproc.service.extraContainers | list | `[]` |  |
| aias-services.services.aproc.service.extraEnv | string | `nil` |  |
| aias-services.services.aproc.service.extraInitContainers | string | `nil` |  |
| aias-services.services.aproc.service.extraVolumeMounts | string | `nil` |  |
| aias-services.services.aproc.service.extraVolumes | string | `nil` |  |
| aias-services.services.aproc.service.image | string | `"gisaia/aproc-service:0.16.1"` |  |
| aias-services.services.aproc.service.imagePullSecrets | list | `[]` |  |
| aias-services.services.aproc.service.nodeSelector | object | `{}` | Node selector for APROC service pods |
| aias-services.services.aproc.service.replicaCount | int | `1` | Number of APROC service replicas |
| aias-services.services.aproc.service.resources | object | `{"limits":{"cpu":0.5,"memory":"256Mi"},"requests":{"cpu":0.1,"memory":"50Mi"}}` | Resources configuration for APROC service |
| aias-services.services.aproc.service.serviceBinding | string | `"0.0.0.0"` |  |
| aias-services.services.aproc.service.serviceName | string | `"aproc-service"` |  |
| aias-services.services.aproc.service.tolerations | list | `[]` | Tolerations for APROC service pods |
| aias-services.services.aproc.service.urlPrefix | string | `"/aproc"` |  |
| aias-services.services.aproc.worker.affinity | object | `{}` | Affinity for APROC worker pods |
| aias-services.services.aproc.worker.extraContainers | list | `[]` |  |
| aias-services.services.aproc.worker.extraEnv | string | `nil` |  |
| aias-services.services.aproc.worker.extraInitContainers | string | `nil` |  |
| aias-services.services.aproc.worker.extraVolumeMounts | string | `nil` |  |
| aias-services.services.aproc.worker.extraVolumes | string | `nil` |  |
| aias-services.services.aproc.worker.image | string | `"gisaia/aproc-proc:0.16.1"` |  |
| aias-services.services.aproc.worker.imagePullSecrets | list | `[]` |  |
| aias-services.services.aproc.worker.nodeSelector | object | `{}` | Node selector for APROC worker pods |
| aias-services.services.aproc.worker.replicaCount | int | `1` | Number of APROC worker replicas |
| aias-services.services.aproc.worker.resources | object | `{"limits":{"cpu":2,"memory":"2Gi"},"requests":{"cpu":0.5,"memory":"512Mi"}}` | Resources configuration for APROC worker |
| aias-services.services.aproc.worker.serviceName | string | `"aproc-proc"` |  |
| aias-services.services.aproc.worker.tolerations | list | `[]` | Tolerations for APROC worker pods |
| aias-services.services.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| aias-services.services.fam.affinity | object | `{}` | Affinity for FAM service pods |
| aias-services.services.fam.extraContainers | list | `[]` |  |
| aias-services.services.fam.extraEnv | string | `nil` |  |
| aias-services.services.fam.extraInitContainers | string | `nil` |  |
| aias-services.services.fam.extraVolumeMounts | string | `nil` |  |
| aias-services.services.fam.extraVolumes | string | `nil` |  |
| aias-services.services.fam.image | string | `"gisaia/fam:0.16.1"` |  |
| aias-services.services.fam.imagePullSecrets | list | `[]` | Extra environment variables for the fam container |
| aias-services.services.fam.nodeSelector | object | `{}` | Node selector for FAM service pods |
| aias-services.services.fam.replicaCount | int | `1` | Number of FAM service replicas |
| aias-services.services.fam.resources | object | `{"limits":{"cpu":0.5,"memory":"256Mi"},"requests":{"cpu":0.1,"memory":"50Mi"}}` | Resources configuration for FAM service |
| aias-services.services.fam.serviceBinding | string | `"0.0.0.0"` |  |
| aias-services.services.fam.serviceName | string | `"arlas-fam"` |  |
| aias-services.services.fam.tolerations | list | `[]` | Tolerations for FAM service pods |
| aias-services.services.fam.urlPrefix | string | `"/fam"` |  |
| aias-services.services.podSecurityContext.fsGroup | int | `1000` |  |
| aias-services.services.podSecurityContext.runAsNonRoot | bool | `true` |  |
| aias-services.services.podSecurityContext.runAsUser | int | `1000` |  |
| aias-services.services.servicePort | int | `8000` |  |
| aias-services.services.serviceType | string | `"ClusterIP"` |  |
| aias-services.smtp.enabled | bool | `false` | Whether SMTP email sending is enabled or not |
| aias-services.smtp.from | string | `"tobechanged"` | SMTP sender email address |
| aias-services.smtp.host | string | `"tobechanged"` | SMTP server host |
| aias-services.smtp.password | string | `"tobechanged"` | SMTP password |
| aias-services.smtp.port | int | `25` | SMTP server port |
| aias-services.smtp.username | string | `"tobechanged"` | SMTP username |
| arlas-services.auth.checkOrganizations | bool | `false` |  |
| arlas-services.cacheFactoryClass | string | `"io.arlas.server.core.impl.cache.LocalCacheFactory"` | The factory class for the cache (io.arlas.server.core.impl.cache.HazelcastCacheFactory, io.arlas.server.core.impl.cache.LocalCacheFactory or io.arlas.server.core.impl.cache.NoCacheFactory) |
| arlas-services.cacheTimeout | int | `60` | Cache TTL for items in cache (seconds), used for all deployments to ensure consistency |
| arlas-services.cors.allowedCredentials | bool | `true` | CORS Allowed Credentials or not |
| arlas-services.cors.allowedHeaders | string | `"arlas-user,arlas-groups,arlas-organization,arlas-org-filter,X-Requested-With,Content-Type,Accept,Origin,Authorization,X-Forwarded-User"` | CORS Allowed Headers |
| arlas-services.cors.allowedMethods | string | `"OPTIONS,GET,PUT,POST,DELETE,HEAD"` | CORS Allowed Methods |
| arlas-services.cors.allowedOrigins | string | `"\"*\""` | CORS Allowed Origins |
| arlas-services.cors.enabled | bool | `false` | Enable CORS or not |
| arlas-services.cors.exposedHeaders | string | `"Content-Type,Authorization,X-Requested-With,Content-Length,Accept,Origin,Location,WWW-Authenticate"` | CORS Exposed Headers |
| arlas-services.defaultStorageClass | string | `"standard"` |  |
| arlas-services.dnsDomain | string | `"localhost"` | DNS domain hosting ARLAS |
| arlas-services.elastic.cluster | string | `"elastic"` |  |
| arlas-services.elastic.login | string | `"elastic"` |  |
| arlas-services.elastic.nodes | string | `"elasticsearch:9200"` |  |
| arlas-services.elastic.password | string | `"password4elastic"` |  |
| arlas-services.elastic.skipMaster | bool | `true` |  |
| arlas-services.elastic.sniffing | bool | `false` |  |
| arlas-services.elastic.ssl.enabled | bool | `true` |  |
| arlas-services.keycloak.client | string | `"arlas-backend"` |  |
| arlas-services.keycloak.enabled | bool | `true` |  |
| arlas-services.keycloak.realm | string | `"arlas"` |  |
| arlas-services.keycloak.secret | string | `"rha14c4202RB0Dxlke6ZNCCTw9gkvLJ8"` |  |
| arlas-services.keycloak.url | string | `"http://172.18.0.2/auth"` |  |
| arlas-services.logger.loggingConsoleLevel | string | `"INFO"` | Default console logging level |
| arlas-services.logger.loggingFile | string | `"/tmp/arlas.log"` | Default logging file |
| arlas-services.logger.loggingLevel | string | `"INFO"` | Default logging level |
| arlas-services.otel.attributes | string | `"deployment.environment={{ .Values.dnsDomain }}"` |  |
| arlas-services.otel.endpoint | string | `"http://arlas-stack-apm-server:8200"` |  |
| arlas-services.otel.ignoredUserAgents | string | `"GoogleHC/*, kube-probe/*, curl*, GoogleStackdriverMonitoring*"` |  |
| arlas-services.otel.protocol | string | `"http/protobuf"` |  |
| arlas-services.persistence.engine | string | `"file"` | Storage engine to use: either `file` or `hibernate` |
| arlas-services.persistence.hibernate | object | `{"dialect":"org.hibernate.dialect.PostgreSQLDialect","driver":"org.postgresql.Driver","password":null,"url":"jdbc:postgresql://db:5432/arlas","user":null}` | Configuration node if `engine=hibernate`, ignored otherwise |
| arlas-services.persistence.hibernate.dialect | string | `"org.hibernate.dialect.PostgreSQLDialect"` | SQL Dialect |
| arlas-services.persistence.hibernate.driver | string | `"org.postgresql.Driver"` | JDBC Driver |
| arlas-services.persistence.hibernate.password | string | `nil` | Database user password |
| arlas-services.persistence.hibernate.url | string | `"jdbc:postgresql://db:5432/arlas"` | JDBC URL |
| arlas-services.persistence.hibernate.user | string | `nil` | Database user login |
| arlas-services.persistence.localFolder | string | `"/persistence/"` | Path to use for file persistence |
| arlas-services.persistence.storageSize | string | `"100Mi"` | Storage size in case of file persistence |
| arlas-services.services.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| arlas-services.services.mountCertificate | bool | `false` |  |
| arlas-services.services.permissions.affinity | object | `{}` |  |
| arlas-services.services.permissions.extraContainers | list | `[]` |  |
| arlas-services.services.permissions.extraEnv | string | `nil` |  |
| arlas-services.services.permissions.extraInitContainers | string | `nil` |  |
| arlas-services.services.permissions.extraVolumeMounts | string | `nil` |  |
| arlas-services.services.permissions.extraVolumes | string | `nil` |  |
| arlas-services.services.permissions.image | string | `"gisaia/arlas-permissions-server:28.0.0"` |  |
| arlas-services.services.permissions.imagePullSecrets | list | `[]` |  |
| arlas-services.services.permissions.jvmXmx | string | `"512m"` |  |
| arlas-services.services.permissions.nodeSelector | object | `{}` |  |
| arlas-services.services.permissions.otel | bool | `true` | Whether OpenTelemetry should be activated or not |
| arlas-services.services.permissions.publicUris | string | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET/POST,explore/.*:GET/POST,persist/.*:GET,authorize/resources:GET"` |  |
| arlas-services.services.permissions.replicaCount | int | `1` |  |
| arlas-services.services.permissions.resources.limits.cpu | float | `0.5` |  |
| arlas-services.services.permissions.resources.limits.memory | string | `"512Mi"` |  |
| arlas-services.services.permissions.resources.requests.cpu | float | `0.1` |  |
| arlas-services.services.permissions.resources.requests.memory | string | `"128Mi"` |  |
| arlas-services.services.permissions.serviceName | string | `"arlas-permissions-server"` |  |
| arlas-services.services.permissions.tolerations | list | `[]` |  |
| arlas-services.services.permissions.urlPrefix | string | `"/permissions"` |  |
| arlas-services.services.persistence.affinity | object | `{}` |  |
| arlas-services.services.persistence.extraContainers | list | `[]` |  |
| arlas-services.services.persistence.extraEnv | string | `nil` |  |
| arlas-services.services.persistence.extraInitContainers | string | `nil` |  |
| arlas-services.services.persistence.extraVolumeMounts | string | `nil` |  |
| arlas-services.services.persistence.extraVolumes | string | `nil` |  |
| arlas-services.services.persistence.image | string | `"gisaia/arlas-persistence-server:28.0.0"` |  |
| arlas-services.services.persistence.imagePullSecrets | list | `[]` |  |
| arlas-services.services.persistence.jvmXmx | string | `"512m"` |  |
| arlas-services.services.persistence.nodeSelector | object | `{}` |  |
| arlas-services.services.persistence.otel | bool | `true` | Whether OpenTelemetry should be activated or not |
| arlas-services.services.persistence.publicUris | string | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET/POST,explore/.*:GET/POST,persist/.*:GET,authorize/resources:GET"` |  |
| arlas-services.services.persistence.replicaCount | int | `1` |  |
| arlas-services.services.persistence.resources.limits.cpu | float | `0.5` |  |
| arlas-services.services.persistence.resources.limits.memory | string | `"512Mi"` |  |
| arlas-services.services.persistence.resources.requests.cpu | float | `0.1` |  |
| arlas-services.services.persistence.resources.requests.memory | string | `"128Mi"` |  |
| arlas-services.services.persistence.serviceName | string | `"arlas-persistence-server"` |  |
| arlas-services.services.persistence.tolerations | list | `[]` |  |
| arlas-services.services.persistence.urlPrefix | string | `"/persist"` |  |
| arlas-services.services.podSecurityContext.fsGroup | int | `65532` |  |
| arlas-services.services.podSecurityContext.runAsNonRoot | bool | `true` |  |
| arlas-services.services.podSecurityContext.runAsUser | int | `65532` |  |
| arlas-services.services.server.affinity | object | `{}` |  |
| arlas-services.services.server.extraContainers | list | `[]` |  |
| arlas-services.services.server.extraEnv | string | `nil` |  |
| arlas-services.services.server.extraInitContainers | string | `nil` |  |
| arlas-services.services.server.extraVolumeMounts | string | `nil` |  |
| arlas-services.services.server.extraVolumes | string | `nil` |  |
| arlas-services.services.server.image | string | `"gisaia/arlas-server:28.0.0"` |  |
| arlas-services.services.server.imagePullSecrets | list | `[]` |  |
| arlas-services.services.server.jvmXmx | string | `"1800m"` |  |
| arlas-services.services.server.nodeSelector | object | `{}` |  |
| arlas-services.services.server.otel | bool | `true` | Whether OpenTelemetry should be activated or not |
| arlas-services.services.server.publicUris | string | `"swagger.*:*,stac:GET,openapi.json:GET,stac/.*:GET/POST,explore/.*:GET/POST,persist/.*:GET,authorize/resources:GET"` |  |
| arlas-services.services.server.replicaCount | int | `1` |  |
| arlas-services.services.server.resources.limits.cpu | int | `1` |  |
| arlas-services.services.server.resources.limits.memory | string | `"1000Mi"` |  |
| arlas-services.services.server.resources.requests.cpu | float | `0.1` |  |
| arlas-services.services.server.resources.requests.memory | string | `"256Mi"` |  |
| arlas-services.services.server.serviceName | string | `"arlas-server"` |  |
| arlas-services.services.server.tolerations | list | `[]` |  |
| arlas-services.services.server.trustStoreOptions | string | `"-Djavax.net.ssl.trustStore=/opt/app/store/arlas-ks.jks -Djavax.net.ssl.trustStorePassword=arlaspassword"` |  |
| arlas-services.services.server.urlPrefix | string | `"/arlas"` |  |
| arlas-services.services.servicePort | int | `8000` |  |
| arlas-services.services.serviceType | string | `"ClusterIP"` |  |
| arlas-services.subServices.cswActivated | string | `"\"false\""` | Whether CSW Service is activated or not |
| arlas-services.subServices.inspireActivated | string | `"\"false\""` | Whether INSPIRE Service is activated or not |
| arlas-services.subServices.rasterTileActivated | string | `"\"false\""` | Whether Raster Tile Service is activated or not |
| arlas-services.subServices.wfsActivated | string | `"\"false\""` | Whether WFS Service is activated or not |
| arlas-services.swaggerResource | string | `"io.arlas.server.rest,io.arlas.server.stac"` | The java package to process for extracting the APIs displayed in Swagger |
| arlas-uis.affinity | object | `{}` | Allows constraining pod(s) to only run on particular nodes, or to prefer to run on particular nodes. It is based on label-selection. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| arlas-uis.authent.authMode | string | `"openid"` | Defines authentication mode (i.e. "iam", "openid" or not defined) |
| arlas-uis.authent.clearHashAfterLogin | bool | `true` | Defines whether to clear the hash fragment in url after logging in |
| arlas-uis.authent.clientId | string | `"arlas-front"` | The client's id as registered with the auth server |
| arlas-uis.authent.customQueryParams | list | `[{"audience":"http://arlas.io/api/server"}]` | Custom query params |
| arlas-uis.authent.disableAtHashCheck | bool | `true` | This property has been introduced to disable at_hash checks and is indented for Identity Provider that does not deliver an at_hash EVEN THOUGH its recommended by the OIDC specs. |
| arlas-uis.authent.forceConnect | bool | `true` | When authentication is enabled, this option forces to be connected to Identity Provider at application bootstrap |
| arlas-uis.authent.issuer | string | `nil` | The issuer's uri |
| arlas-uis.authent.logoutUrl | string | `nil` | The logout URL to be used |
| arlas-uis.authent.requireHttps | bool | `false` | Defines whether https is required |
| arlas-uis.authent.responseType | string | `"code"` | Response type values |
| arlas-uis.authent.scope | string | `"profile"` |  |
| arlas-uis.authent.sessionChecksEnabled | bool | `true` | If true, the app will try to check whether the user is still logged in on a regular basis as described |
| arlas-uis.authent.showDebugInformation | bool | `false` | Defines whether to display debug log in browser console |
| arlas-uis.authent.silentRefreshTimeout | string | `"1000"` | Timeout for silent refresh |
| arlas-uis.authent.storage | string | `"memorystorage"` | Defines the kind of storage: localstorage or sessionstorage |
| arlas-uis.authent.threshold | int | `60000` | Refresh token timer (arlas iam) |
| arlas-uis.authent.timeoutFactor | string | `"0.75"` | Defines when the token_timeout event should be raised. If you set this to the default value 0.75, the event s triggered after 75% of the token's life time. |
| arlas-uis.authent.useAuthent | bool | `true` | Defines whether to be authenticated to Identity Provider |
| arlas-uis.authent.useDiscovery | bool | `true` | Defines whether we use Identity Provider document discovery service |
| arlas-uis.basemap.storageSize | string | `"10Mi"` | Size of the directory containing the basemap files |
| arlas-uis.configuration | object | `{}` |  |
| arlas-uis.dashboardShortcut | bool | `false` | Whether to display the dashboard shortcut icon |
| arlas-uis.defaultStorageClass | string | `"standard"` |  |
| arlas-uis.dnsDomain | string | `"localhost"` | DNS domain hosting ARLAS |
| arlas-uis.enableGeocoding | bool | `false` | Enable or disable Geocoding feature |
| arlas-uis.geocodingUrl | string | `nil` | Geocoding find place URL |
| arlas-uis.geocodingZoomTo | int | `11` | Maximum zoom level for geocoding feature |
| arlas-uis.googleAnalyticsKey | string | `nil` | The Google Analytics key of the wui app |
| arlas-uis.histogramsExportNbBuckets | int | `1000` | Maximum number of buckets for the histogram export |
| arlas-uis.histogramsMaxBucket | int | `200` | Maximum number of buckets for the histogram graph |
| arlas-uis.hitsExporterVersion | float | `2.2` | Version number of the ARLAS Hits Exporter to use |
| arlas-uis.links | string | `" [ { \"name\":\"Dashboards\", \"url\":\"/hub/\", \"icon\":\"hub\", \"check_url\": \"/arlas/collections\", \"check_url_response_type\": \"text\" }, { \"name\": \"Archives\", \"url\": \"/fam-wui/\", \"icon\": \"collections\", \"check_url\": \"/fam/healthcheck\", \"check_url_response_type\": \"text\" } ]"` | List of links to be added in the left menu of the WUI. Each link must contain `icon`, `url` and `name` attributes. |
| arlas-uis.logger.loggingConsoleLevel | string | `"INFO"` | Default console logging level |
| arlas-uis.logger.loggingLevel | string | `"INFO"` | Default logging level |
| arlas-uis.nodeSelector | object | `{}` | Label-based selector, to control the nodes the pod(s) will run on. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector |
| arlas-uis.protocol | string | `"http"` |  |
| arlas-uis.replicaCount | int | `1` | Number of desired pods |
| arlas-uis.resources.limits.cpu | float | `0.1` |  |
| arlas-uis.resources.limits.memory | string | `"50Mi"` |  |
| arlas-uis.resources.requests.cpu | float | `0.05` |  |
| arlas-uis.resources.requests.memory | string | `"10Mi"` |  |
| arlas-uis.resultListEnableExport | bool | `false` | Whether or not to enable result list export |
| arlas-uis.resultListExportSize | int | `1000` | Result list export size |
| arlas-uis.services.airs.urlPrefix | string | `"/airs"` |  |
| arlas-uis.services.aprocService.urlPrefix | string | `"/aproc"` |  |
| arlas-uis.services.fam.urlPrefix | string | `"/fam"` |  |
| arlas-uis.services.permissions.urlPrefix | string | `"/permissions"` |  |
| arlas-uis.services.persistence.urlPrefix | string | `"/persist"` |  |
| arlas-uis.services.server.urlPrefix | string | `"/arlas"` |  |
| arlas-uis.tolerations | list | `[]` | Pod-Tolerations & Nodes-Taints work together to allow nodes to repel certain kinds of pods. See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| arlas-uis.uis.builder.aboutConfigMapName | string | `"arlas-builder-default-about-configmap"` |  |
| arlas-uis.uis.builder.advancedFeatures | bool | `false` |  |
| arlas-uis.uis.builder.allowExternalNodeConfiguration | bool | `true` |  |
| arlas-uis.uis.builder.extraContainers | list | `[]` |  |
| arlas-uis.uis.builder.extraEnv | string | `nil` |  |
| arlas-uis.uis.builder.extraInitContainers | string | `nil` |  |
| arlas-uis.uis.builder.extraVolumeMounts | string | `nil` |  |
| arlas-uis.uis.builder.extraVolumes | string | `nil` |  |
| arlas-uis.uis.builder.image | string | `"gisaia/arlas-wui-builder:28.0.1"` |  |
| arlas-uis.uis.builder.imagePullSecrets | list | `[]` |  |
| arlas-uis.uis.builder.serviceName | string | `"arlas-builder"` |  |
| arlas-uis.uis.builder.tabName | string | `"ARLAS Studio"` |  |
| arlas-uis.uis.builder.terrain | string | `"{ \"type\": \"raster-dem\", \"tiles\": [\"https://tiles.mapterhorn.com/{z}/{x}/{y}.webp\"], \"encoding\": terrarium, \"tileSize\": 512 }"` |  |
| arlas-uis.uis.builder.urlPrefix | string | `"/builder/"` |  |
| arlas-uis.uis.colors.arlas.bg | string | `"#ff4081"` |  |
| arlas-uis.uis.colors.handle.color | string | `"#ff4081"` |  |
| arlas-uis.uis.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| arlas-uis.uis.famWui.archivePageSize | int | `10` |  |
| arlas-uis.uis.famWui.catalog | string | `"main catalog"` |  |
| arlas-uis.uis.famWui.collectionName | string | `"main"` |  |
| arlas-uis.uis.famWui.extraContainers | list | `[]` |  |
| arlas-uis.uis.famWui.extraEnv | string | `nil` |  |
| arlas-uis.uis.famWui.extraInitContainers | string | `nil` |  |
| arlas-uis.uis.famWui.extraVolumeMounts | string | `nil` |  |
| arlas-uis.uis.famWui.extraVolumes | string | `nil` |  |
| arlas-uis.uis.famWui.famDefaultURL | string | `nil` |  |
| arlas-uis.uis.famWui.filePageSize | int | `50` |  |
| arlas-uis.uis.famWui.image | string | `"gisaia/arlas-fam-wui:0.16.1"` |  |
| arlas-uis.uis.famWui.imagePullSecrets | list | `[]` |  |
| arlas-uis.uis.famWui.serviceName | string | `"arlas-fam-wui"` |  |
| arlas-uis.uis.famWui.tabName | string | `"ARLAS FAM Wui"` |  |
| arlas-uis.uis.famWui.urlPrefix | string | `"/fam-wui"` | Extra environment variables for the arlas fam wui container |
| arlas-uis.uis.hub.aboutConfigMapName | string | `"arlas-hub-default-about-configmap"` |  |
| arlas-uis.uis.hub.extraContainers | list | `[]` |  |
| arlas-uis.uis.hub.extraEnv | string | `nil` |  |
| arlas-uis.uis.hub.extraInitContainers | string | `nil` |  |
| arlas-uis.uis.hub.extraVolumeMounts | string | `nil` |  |
| arlas-uis.uis.hub.extraVolumes | string | `nil` |  |
| arlas-uis.uis.hub.image | string | `"gisaia/arlas-wui-hub:28.0.2"` |  |
| arlas-uis.uis.hub.imagePullSecrets | list | `[]` |  |
| arlas-uis.uis.hub.serviceName | string | `"arlas-hub"` |  |
| arlas-uis.uis.hub.tabName | string | `"ARLAS Hub"` |  |
| arlas-uis.uis.hub.urlPrefix | string | `"/hub"` |  |
| arlas-uis.uis.podSecurityContext.fsGroup | int | `1000` |  |
| arlas-uis.uis.podSecurityContext.runAsNonRoot | bool | `true` |  |
| arlas-uis.uis.podSecurityContext.runAsUser | int | `1000` |  |
| arlas-uis.uis.servicePort | int | `8080` |  |
| arlas-uis.uis.serviceType | string | `"ClusterIP"` |  |
| arlas-uis.uis.wui.aboutAndTourConfigMapName | string | `"arlas-default-about-and-tour-configmap"` |  |
| arlas-uis.uis.wui.basemapUrl | string | `nil` |  |
| arlas-uis.uis.wui.extraContainers | list | `[]` |  |
| arlas-uis.uis.wui.extraEnv | string | `nil` |  |
| arlas-uis.uis.wui.extraInitContainers | string | `nil` |  |
| arlas-uis.uis.wui.extraVolumeMounts | string | `nil` |  |
| arlas-uis.uis.wui.extraVolumes | string | `nil` |  |
| arlas-uis.uis.wui.image | string | `"gisaia/arlas-wui:28.0.3"` |  |
| arlas-uis.uis.wui.imagePullSecrets | list | `[]` |  |
| arlas-uis.uis.wui.serviceName | string | `"arlas-wui"` |  |
| arlas-uis.uis.wui.tabName | string | `"ARLAS Exploration"` |  |
| arlas-uis.uis.wui.urlPrefix | string | `"/wui"` | Extra environment variables for the arlas wui container |
| arlas-uis.uis.wui.whitelistedUrls[0] | string | `"https://tiles.mapterhorn.com"` |  |
| titiler.affinity | object | `{}` |  |
| titiler.env.CPL_TMPDIR | string | `"/tmp"` |  |
| titiler.env.GDAL_CACHEMAX | int | `200` |  |
| titiler.env.GDAL_DISABLE_READDIR_ON_OPEN | string | `"EMPTY_DIR"` |  |
| titiler.env.GDAL_HTTP_MERGE_CONSECUTIVE_RANGES | string | `"YES"` |  |
| titiler.env.GDAL_HTTP_MULTIPLEX | string | `"YES"` |  |
| titiler.env.GDAL_HTTP_VERSION | int | `2` |  |
| titiler.env.GDAL_INGESTED_BYTES_AT_OPEN | int | `32768` |  |
| titiler.env.PYTHONWARNINGS | string | `"ignore"` |  |
| titiler.env.VSI_CACHE | string | `"TRUE"` |  |
| titiler.env.VSI_CACHE_SIZE | int | `5000000` |  |
| titiler.extraHostPathMounts | list | `[]` |  |
| titiler.fullnameOverride | string | `""` |  |
| titiler.image.args[0] | string | `"titiler.application.main:app"` |  |
| titiler.image.args[1] | string | `"--host"` |  |
| titiler.image.args[2] | string | `"0.0.0.0"` |  |
| titiler.image.args[3] | string | `"--port"` |  |
| titiler.image.args[4] | string | `"8000"` |  |
| titiler.image.args[5] | string | `"--workers"` |  |
| titiler.image.args[6] | string | `"4"` |  |
| titiler.image.command | string | `"uvicorn"` |  |
| titiler.image.pullPolicy | string | `"IfNotPresent"` |  |
| titiler.image.repository | string | `"ghcr.io/developmentseed/titiler"` |  |
| titiler.image.tag | string | `"latest"` |  |
| titiler.imagePullSecrets | list | `[]` |  |
| titiler.ingress.annotations | object | `{}` |  |
| titiler.ingress.enabled | bool | `false` |  |
| titiler.ingress.hosts[0].host | string | `"titiler.local"` |  |
| titiler.ingress.hosts[0].paths[0] | string | `"/"` |  |
| titiler.ingress.tls | list | `[]` |  |
| titiler.nameOverride | string | `""` |  |
| titiler.nodeSelector | object | `{}` |  |
| titiler.podSecurityContext | object | `{}` |  |
| titiler.replicaCount | int | `1` |  |
| titiler.resources.limits.cpu | int | `1` |  |
| titiler.resources.limits.memory | string | `"2Gi"` |  |
| titiler.resources.requests.cpu | float | `0.1` |  |
| titiler.resources.requests.memory | string | `"50Mi"` |  |
| titiler.securityContext | object | `{}` |  |
| titiler.service.port | int | `8000` |  |
| titiler.service.type | string | `"ClusterIP"` |  |
| titiler.serviceAccountName | string | `""` |  |
| titiler.terminationGracePeriodSeconds | int | `30` |  |
| titiler.tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
