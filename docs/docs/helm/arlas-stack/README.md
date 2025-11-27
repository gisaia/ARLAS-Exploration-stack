# arlas-aias

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square)

A Helm Chart to deploy the ARLAS Exploration Stack with AIAS services

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../aias-services | aias-services | 0.0.1 |
| file://../arlas-services | arlas-services | 0.0.1 |
| file://../arlas-uis | arlas-uis | 0.0.1 |
| file://../titiler | titiler | 1.2.7 |
| https://charts.bitnami.com/bitnami | elasticsearch | 22.0.4 |
| https://charts.bitnami.com/bitnami | keycloak | 20.0.1 |
| https://charts.bitnami.com/bitnami | minio | 17.0.21 |
| https://charts.bitnami.com/bitnami | rabbitmq | 16.0.11 |
| https://charts.bitnami.com/bitnami | redis | 21.2.13 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| aias-services | object | `{"initBuckets":true,"logger":{"loggingConsoleLevel":"DEBUG","loggingLevel":"DEBUG"},"services":{"agate":{"configuration":{"arlasUrlSearch":"http://arlas-server:8000/arlas/explore/{collection}/_search?f=id:eq:{item}","methodHeader":"x-original-method","roles":null,"urbac":{"jwtAudience":"arlas-backend","openIdProvider":"https://keycloak.arlas.k8s/auth/realms/arlas/.well-known/openid-configuration","verifySsl":false},"urlHeader":"x-auth-request-redirect"},"extraEnvVars":null,"serviceName":"arlas-agate"},"airs":{"configuration":{"s3":{"accessKeyId":"minioadmin","assetHttpEndpointUrl":"https://site.arlas.k8s/{}/{}","bucket":"airs-storages","endpoint":"http://arlas-stack-minio:9000","secretAccessKey":"secret4minio","writablePaths":["/"]}},"extraEnvVars":null,"serviceName":"airs-server"},"aproc":{"configuration":{"accessManager":{"storages":[{"readable_paths":["/inputs"],"type":"file","writable_paths":["/tmp","/outbox"]},{"bucket":"gisaia-public","readable_paths":["/OPENDATA"],"type":"gs"},{"api_key":{"access_key":"minioadmin","secret_key":"secret4minio"},"bucket":"archives","endpoint":"$APROC_ARCHIVE_ENDPOINT|http://arlas-stack-minio:9000\"","readable_paths":["/inputs"],"type":"s3"},{"bucket":"gisaia-public","endpoint":"https://storage.googleapis.com","readable_paths":["/OPENDATA"],"type":"s3"},{"api_key":{"access_key":"minioadmin","secret_key":"secret4minio"},"bucket":"downloads","endpoint":"http://arlas-stack-minio:9000","readable_paths":["/"],"type":"s3","writable_paths":["/"]},{"api_key":{"access_key":"minioadmin","secret_key":"secret4minio"},"bucket":"inputs","endpoint":"http://arlas-stack-minio:9000","readable_paths":["/"],"type":"s3"}],"tmpDir":"/tmp/"},"airsEndpoint":"http://airs-server:8000/airs","arlasUrlSearch":"http://arlas-server:8000/arlas/explore/{collection}/_search?f=id:eq:{item}","celeryBrokerUrl":"pyamqp://admin:secret4rabbitmq@arlas-stack-rabbitmq:5672//","celeryResultBackend":"redis://:secret4redis@arlas-stack-redis-master:6379/0","celeryResultBackendTransportOptions":null,"extensions":{"download":{"index":{"name":"org.com@aproc_downloads"},"outboxS3":{"accessKeyId":"minioadmin","assetHttpEndpointUrl":"https://site.arlas.k8s/{}/{}","bucket":"downloads","endpointUrl":"http://arlas-stack-minio:9000","secretAccessKey":"secret4minio"}},"ingest":{"aprocEndpoint":"http://aproc-service:8001","inputsDirectory":"http://arlas-stack-minio:9000/inputs"}}},"service":{"extraEnvVars":null,"serviceName":"aproc-service"},"worker":{"affinity":{},"extraEnvVars":null,"nodeSelector":{},"replicaCount":1,"resources":{"limits":{"cpu":2,"memory":"10Gi"}},"tolerations":[]}},"fam":{"extraEnvVars":null,"serviceName":"arlas-fam"}}}` | See the documentation of the sub-chart aias-services https://docs.arlas.io/external_docs/ARLAS-Exploration-stack/helm/aias-services/ |
| aias-services.initBuckets | bool | `true` | Init the AIAS minio buckets   |
| aias-services.logger.loggingConsoleLevel | string | `"DEBUG"` | Console logging level for aias-services |
| aias-services.logger.loggingLevel | string | `"DEBUG"` | Logging level for aias-services |
| aias-services.services.agate.configuration.roles | string | `nil` | If a prefix is added to the arlas deployment, then you must add it to the path permissions below (change "myprefix" with your own prefix and uncomment). |
| aias-services.services.agate.configuration.urbac.verifySsl | bool | `false` | __MUST BE CONFIGURED:__ Change to true in production or if certificate can be verified |
| aias-services.services.agate.extraEnvVars | string | `nil` | Extra environment variables for the agate container |
| aias-services.services.airs.configuration.s3.assetHttpEndpointUrl | string | `"https://site.arlas.k8s/{}/{}"` | __MUST BE CONFIGURED:__ Change with the domain of your deployment |
| aias-services.services.airs.configuration.s3.bucket | string | `"airs-storages"` | __IMPORTANT:__ If you change the bucket name here, make sure to overwrite the patterns in agate.configuration.services (k8s/charts/aias-services/values.yaml). |
| aias-services.services.airs.extraEnvVars | string | `nil` | Extra environment variables for the airs container |
| aias-services.services.aproc.configuration.accessManager.storages | list | `[{"readable_paths":["/inputs"],"type":"file","writable_paths":["/tmp","/outbox"]},{"bucket":"gisaia-public","readable_paths":["/OPENDATA"],"type":"gs"},{"api_key":{"access_key":"minioadmin","secret_key":"secret4minio"},"bucket":"archives","endpoint":"$APROC_ARCHIVE_ENDPOINT|http://arlas-stack-minio:9000\"","readable_paths":["/inputs"],"type":"s3"},{"bucket":"gisaia-public","endpoint":"https://storage.googleapis.com","readable_paths":["/OPENDATA"],"type":"s3"},{"api_key":{"access_key":"minioadmin","secret_key":"secret4minio"},"bucket":"downloads","endpoint":"http://arlas-stack-minio:9000","readable_paths":["/"],"type":"s3","writable_paths":["/"]},{"api_key":{"access_key":"minioadmin","secret_key":"secret4minio"},"bucket":"inputs","endpoint":"http://arlas-stack-minio:9000","readable_paths":["/"],"type":"s3"}]` | Configuration of the storages used by the access manager to provide access to various storage backends |
| aias-services.services.aproc.configuration.accessManager.tmpDir | string | `"/tmp/"` | Temporary directory used by the access manager |
| aias-services.services.aproc.configuration.airsEndpoint | string | `"http://airs-server:8000/airs"` | AIRS service endpoint URL accessed by APROC |
| aias-services.services.aproc.configuration.arlasUrlSearch | string | `"http://arlas-server:8000/arlas/explore/{collection}/_search?f=id:eq:{item}"` | ARLAS search URL used by APROC to check whether an item exists |
| aias-services.services.aproc.configuration.celeryBrokerUrl | string | `"pyamqp://admin:secret4rabbitmq@arlas-stack-rabbitmq:5672//"` | __MUST BE CONFIGURED:__ RabbitMQ broker URL for APROC tasks |
| aias-services.services.aproc.configuration.celeryResultBackend | string | `"redis://:secret4redis@arlas-stack-redis-master:6379/0"` | __MUST BE CONFIGURED:__ Redis backend URL for APROC task results |
| aias-services.services.aproc.configuration.extensions.download.index.name | string | `"org.com@aproc_downloads"` | __MUST BE CONFIGURED:__ Change with the domain (org.com) with your own organization name |
| aias-services.services.aproc.configuration.extensions.download.outboxS3.assetHttpEndpointUrl | string | `"https://site.arlas.k8s/{}/{}"` | __MUST BE CONFIGURED:__ Change with the domain of your deployment |
| aias-services.services.aproc.configuration.extensions.ingest.inputsDirectory | string | `"http://arlas-stack-minio:9000/inputs"` | Directory where archives to ingest are stored. Must be in sync with the accessManager readable_paths configuration below. Examples: /inputs, https://storage.googleapis.com/gisaia-public/OPENDATA/eo |
| aias-services.services.aproc.service.extraEnvVars | string | `nil` | Extra environment variables for the aproc service container |
| aias-services.services.aproc.worker.extraEnvVars | string | `nil` | Extra environment variables for the aproc worker container |
| aias-services.services.fam.extraEnvVars | string | `nil` | Extra environment variables for the fam container |
| arlas-services | object | `{"logger":{"loggingConsoleLevel":"INFO","loggingLevel":"INFO"},"services":{"mountCertificate":true,"permissions":{"extraEnvVars":null},"persistence":{"extraEnvVars":null},"server":{"extraEnvVars":null}}}` | See the documentation of the sub-chart arlas-services https://docs.arlas.io/external_docs/ARLAS-Exploration-stack/helm/arlas-services/ |
| arlas-services.logger.loggingConsoleLevel | string | `"INFO"` | Console logging level |
| arlas-services.logger.loggingLevel | string | `"INFO"` | Logging level |
| arlas-services.services.mountCertificate | bool | `true` | __MUST BE CONFIGURED:__ Set to true if you want the services to use the certificate contained in the k8s/charts/arlas-stack/templates/keycloak-certificate-configmap.yaml file and enable the keycloak.ingress.extraTls bloc. False otherwise and disable the keycloak.ingress.extraTls bloc. |
| arlas-services.services.permissions.extraEnvVars | string | `nil` | Extra environment variables for the permission server container |
| arlas-services.services.persistence.extraEnvVars | string | `nil` | Extra environment variables for the persistence server container |
| arlas-services.services.server.extraEnvVars | string | `nil` | Extra environment variables for the arlas server container |
| arlas-uis | object | `{"basemap":{"storageSize":"50Mi"},"logger":{"loggingConsoleLevel":"INFO","loggingLevel":"INFO"},"uis":{"builder":{"extraEnvVars":null},"famWui":{"extraEnvVars":null},"hub":{"extraEnvVars":null},"wui":{"extraEnvVars":null}}}` | See the documentation of the sub-chart arlas-uis https://docs.arlas.io/external_docs/ARLAS-Exploration-stack/helm/arlas-uis/ |
| arlas-uis.basemap | object | `{"storageSize":"50Mi"}` | __MUST BE CONFIGURED:__ Set to 120 Gi if you copy the full basemap |
| arlas-uis.logger.loggingConsoleLevel | string | `"INFO"` | Console logging level |
| arlas-uis.logger.loggingLevel | string | `"INFO"` | Logging level |
| arlas-uis.uis.builder.extraEnvVars | string | `nil` | Extra environment variables for the arlas builder container |
| arlas-uis.uis.famWui.extraEnvVars | string | `nil` | Extra environment variables for the arlas fam wui container |
| arlas-uis.uis.hub.extraEnvVars | string | `nil` | Extra environment variables for the arlas hub container |
| arlas-uis.uis.wui.extraEnvVars | string | `nil` | Extra environment variables for the arlas wui container |
| deployment.aias.enabled | bool | `true` |  |
| deployment.aias.services.airs.ingress.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` |  |
| deployment.aias.services.airs.ingress.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/url-role-based-authorization"` |  |
| deployment.aias.services.airs.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffering" | string | `"off"` |  |
| deployment.aias.services.airs.ingress.enabled | bool | `true` |  |
| deployment.aias.services.aproc.ingress.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` |  |
| deployment.aias.services.aproc.ingress.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/url-role-based-authorization"` |  |
| deployment.aias.services.aproc.ingress.enabled | bool | `true` |  |
| deployment.aias.services.fam.ingress.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` |  |
| deployment.aias.services.fam.ingress.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/url-role-based-authorization"` |  |
| deployment.aias.services.fam.ingress.enabled | bool | `true` |  |
| deployment.aias.services.minio.ingress.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` |  |
| deployment.aias.services.minio.ingress.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/authorization/airs-storage"` |  |
| deployment.aias.services.minio.ingress.enabled | bool | `true` |  |
| deployment.aias.services.minio.port | int | `9000` |  |
| deployment.aias.services.minio.serviceName | string | `"arlas-stack-minio"` |  |
| deployment.aias.services.titiler.ingress.annotations."nginx.ingress.kubernetes.io/auth-response-headers" | string | `"Authorization, arlas-org-filter"` |  |
| deployment.aias.services.titiler.ingress.annotations."nginx.ingress.kubernetes.io/auth-url" | string | `"http://arlas-agate.arlas.svc.cluster.local:8000/agate/authorization/cog"` |  |
| deployment.aias.services.titiler.ingress.enabled | bool | `true` |  |
| deployment.aias.services.titiler.port | int | `9000` |  |
| deployment.aias.services.titiler.serviceName | string | `"arlas-stack-minio"` |  |
| deployment.aias.uis.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$1"` |  |
| deployment.aias.uis.ingress.annotations."nginx.ingress.kubernetes.io/use-regex" | string | `"true"` |  |
| deployment.aias.uis.ingress.enabled | bool | `true` |  |
| deployment.arlas.services.enabled | bool | `true` |  |
| deployment.arlas.services.ingress.annotations | string | `nil` |  |
| deployment.arlas.services.ingress.enabled | bool | `true` |  |
| deployment.arlas.uis.enabled | bool | `true` |  |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/force-ssl-redirect" | string | `"true"` |  |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffering" | string | `"off"` |  |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$1"` |  |
| deployment.arlas.uis.ingress.annotations."nginx.ingress.kubernetes.io/use-regex" | string | `"true"` |  |
| deployment.arlas.uis.ingress.enabled | bool | `true` |  |
| deployment.elasticsearch.enabled | bool | `true` | Should the chart deploy elasticsearch |
| deployment.elasticsearch.ingress.enabled | bool | `true` |  |
| deployment.keycloak.enabled | bool | `true` | __MUST BE CONFIGURED:__ Should the chart deploy keycloak. __Enable for tests only__ or configure carefully the chart for your production needs. |
| deployment.minio.enabled | bool | `true` | Should the chart deploy minio |
| deployment.minio.ingress.enabled | bool | `true` |  |
| deployment.rabbitmq.enabled | bool | `true` | Should the chart deploy rabbitmq |
| deployment.redis.enabled | bool | `true` | Should the chart deploy redis |
| deployment.titiler.enabled | bool | `true` | Should the chart deploy titiler |
| elasticsearch | object | `{"coordinating":{"replicaCount":0},"copyTlsCerts":{"image":{"repository":"bitnamilegacy/os-shell"}},"data":{"persistentVolumeClaimRetentionPolicy":{"enabled":true},"replicaCount":0},"image":{"repository":"bitnamilegacy/elasticsearch"},"ingest":{"replicaCount":0},"master":{"masterOnly":false,"persistentVolumeClaimRetentionPolicy":{"enabled":true},"replicaCount":1,"resourcesPreset":"large"},"security":{"enabled":true,"tls":{"autoGenerated":true}},"service":{"type":"ClusterIP"},"sysctlImage":{"repository":"bitnamilegacy/os-shell"}}` | Elasticsearch for development and test only. For production, please refer to the elasticsearch documentation to deploy a production ready elasticsearch instance instead. |
| global.authIssuer | string | `"https://keycloak.arlas.k8s/auth/realms/arlas"` | __MUST BE CONFIGURED:__ The issuer's uri |
| global.celeryBrokerUrl | string | `"pyamqp://admin:secret4rabbitmq@arlas-stack-rabbitmq:5672//"` | __MUST BE CONFIGURED:__ RabbitMQ broker URL for APROC tasks |
| global.celeryResultBackend | string | `"redis://:secret4redis@arlas-stack-redis-master:6379/0"` | __MUST BE CONFIGURED:__ Redis backend URL for APROC task results |
| global.defaultStorageClass | string | `"standard-retain"` | __MUST BE CONFIGURED:__ The default ARLAS storage class for the persistence. By default, the `standard-retain` storage class is created based on the provisioner `rancher.io/local-path` with a retain policy. |
| global.dnsDomain | string | `"site.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing the ARLAS deployment |
| global.elasticDnsDomain | string | `"elastic.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing ES for ARLAS deployment |
| global.elasticLogin | string | `"elastic"` | Elasticsearch login for elasticsearch itself and the services that are connecting to elasticsearch |
| global.elasticPassword | string | `"secret4elastic"` | __MUST BE CONFIGURED:__ Elasticsearch password for elasticsearch itself and the services that are connecting to elasticsearch |
| global.ingressClassName | string | `"nginx"` | __MUST BE CONFIGURED:__ The default ingress class. By default, the `nginx` controler is used. |
| global.keycloak.secret | string | `"rha14c4202RB0Dxlke6ZNCCTw9gkvLJ8"` | __MUST BE CONFIGURED:__ The secret configured for the ARLAS client of the keyckloak's realm  |
| global.keycloak.url | string | `"https://keycloak.arlas.k8s/auth"` | __MUST BE CONFIGURED:__ Keycloak URL |
| global.keycloakDnsDomain | string | `"keycloak.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing keycloak for ARLAS deployment |
| global.keycloakLogin | string | `"admin"` | Keycloak admin login for keycloak deployment (for test only) |
| global.keycloakPassword | string | `"secret4keycloak"` | __MUST BE CONFIGURED:__ Keycloak admin password  |
| global.logoutUrl | string | `nil` | The logout URL to be used |
| global.minioDnsDomain | string | `"minio.arlas.k8s"` | __MUST BE CONFIGURED:__ The domain name for accessing minio for ARLAS deployment |
| global.minioLogin | string | `"minioadmin"` | Minio login for minio itself and the services that are connecting to minio |
| global.minioPassword | string | `"secret4minio"` | __MUST BE CONFIGURED:__ Minio password for minio itself and the services that are connecting to minio |
| global.openIdProvider | string | `"https://keycloak.arlas.k8s/auth/realms/arlas/.well-known/openid-configuration"` | __MUST BE CONFIGURED:__ The access to the openid-configuration |
| global.organization | string | `"org.com"` | __MUST BE CONFIGURED:__ Name of the organization using AIAS |
| global.postgresql.auth.password | string | `"secret4postgres"` | __MUST BE CONFIGURED:__ postgres password for keycloak |
| global.protocol | string | `"https"` | __MUST BE CONFIGURED:__ The protocol for accessing the ARLAS deployment |
| global.rabbitMQLogin | string | `"admin"` | RabbitMQ Login |
| global.rabbitMQPassword | string | `"secret4rabbitmq"` | __MUST BE CONFIGURED:__ RabbitMQ Password |
| global.redisPassword | string | `"secret4redis"` | __MUST BE CONFIGURED:__ redis Password |
| keycloak | object | `{"auth":{"adminPassword":"secret4keycloak","adminUser":"admin"},"extraEnvVars":[{"name":"KEYCLOAK_EXTRA_ARGS","value":"--import-realm"}],"extraVolumeMounts":[{"mountPath":"/opt/bitnami/keycloak/data/import","name":"realm-config"}],"extraVolumes":[{"configMap":{"name":"keycloak-realm-configmap"},"name":"realm-config"}],"httpRelativePath":"/auth/","image":{"repository":"bitnamilegacy/keycloak"},"ingress":{"annotations":{"nginx.ingress.kubernetes.io/proxy-buffer-size":"16k","nginx.ingress.kubernetes.io/proxy-buffers-number":"8"},"enabled":true,"extraTls":[{"hosts":["keycloak.arlas.k8s"],"secretName":"keycloak-tls"}],"path":"/","servicePort":8080,"tls":true},"postgresql":{"global":{"security":{"allowInsecureImages":true}},"image":{"repository":"bitnamilegacy/postgresql"}},"proxy":"edge","readinessProbe":{"initialDelaySeconds":300,"timeoutSeconds":60},"realm":{"configmap":{"enabled":true}},"resourcesPreset":"medium","service":{"http":{"enabled":true},"ports":{"http":8080,"https":8443},"type":"ClusterIP"},"startupProbe":{"initialDelaySeconds":300,"timeoutSeconds":60}}` | Keycloak for development and test only. For production, please refer to the Keycloak documentation to deploy a production ready Keycloak instance instead. |
| keycloak.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"16k"` | Default nginx ingress has default proxy buffers that are too small for keycloak headers. |
| keycloak.ingress.extraTls | list | `[{"hosts":["keycloak.arlas.k8s"],"secretName":"keycloak-tls"}]` | __MUST BE CONFIGURED:__ Enable extraTls bloc if you provide the certificate in the keycloak-tls secret, comment the block below otherwise. If the block is enabled, then set arlas-services.services.mountCertificate must be true, false otherwise (so that the certificate is mounted on the pods). start-of-block    |
| minio | object | `{"console":{"image":{"repository":"bitnamilegacy/minio-object-browser"}},"image":{"repository":"bitnamilegacy/minio"},"persistence":{"storageClass":"standard-retain"},"resourcesPreset":"medium"}` | Minio for development and test only. For production, please refer to the minio documentation to deploy a production ready minio instance instead. |
| rabbitmq | object | `{"image":{"repository":"bitnamilegacy/rabbitmq"},"persistentVolumeClaimRetentionPolicy":{"enabled":true},"resources":{"limits":{"memory":"2Gi"},"requests":{"memory":"1Gi"}}}` | Rabbitmq for development and test only. For production, please refer to the rabbitmq documentation to deploy a production ready rabbitmq instance instead. |
| redis | object | `{"architecture":"standalone","commonConfiguration":"loadmodule /opt/bitnami/redis/lib/redis/modules/redisbloom.so\nloadmodule /opt/bitnami/redis/lib/redis/modules/redisearch.so\nloadmodule /opt/bitnami/redis/lib/redis/modules/rejson.so\nloadmodule /opt/bitnami/redis/lib/redis/modules/redistimeseries.so\n","image":{"repository":"bitnamilegacy/redis"},"replica":{"persistence":{"storageClass":"standard-retain"},"persistentVolumeClaimRetentionPolicy":{"enabled":true}}}` | Redis for development and test only. For production, please refer to the redis documentation to deploy a production ready redis instance instead. |
| titiler.replicaCount | int | `1` |  |
| titiler.resources.limits.cpu | int | `4` |  |
| titiler.resources.limits.memory | string | `"4Gi"` |  |
| titiler.resources.requests.cpu | float | `0.1` |  |
| titiler.resources.requests.memory | string | `"1Gi"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
