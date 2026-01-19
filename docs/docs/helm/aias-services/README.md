# aias-services

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square)

A Helm Chart to deploy ARLAS AIAS Services

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cors.allowedCredentials | bool | `true` | CORS Allowed Credentials or not |
| cors.allowedHeaders | string | `"arlas-user,arlas-groups,arlas-organization,arlas-org-filter,X-Requested-With,Content-Type,Accept,Origin,Authorization,X-Forwarded-User"` | CORS Allowed Headers |
| cors.allowedHosts | string | `"0.0.0.0"` |  |
| cors.allowedMethods | string | `"OPTIONS,GET,PUT,POST,DELETE,HEAD"` | Allowed hosts |
| cors.allowedOrigins | string | `"\"*\""` | CORS Allowed Origins |
| cors.exposedHeaders | string | `"Content-Type,Authorization,X-Requested-With,Content-Length,Accept,Origin,Location,WWW-Authenticate"` | CORS Exposed Headers |
| dnsDomain | string | `"localhost"` | DNS domain hosting ARLAS |
| elastic.cluster | string | `"elastic"` | Elasticsearch cluster name |
| elastic.endpoint | string | `"https://elasticsearch:9200"` | Elasticsearch endpoint URL for AIRS and APROC services |
| elastic.login | string | `"elastic"` | Elasticsearch login |
| elastic.password | string | `"elastic"` | Elasticsearch password |
| initBuckets | bool | `false` |  |
| logger.loggingConsoleLevel | string | `"INFO"` | Default console logging level |
| logger.loggingLevel | string | `"INFO"` | Default logging level |
| protocol | string | `"http"` |  |
| services.agate.affinity | object | `{}` | Affinity for AGATE service pods |
| services.agate.configuration.arlasUrlSearch | string | `"http://arlas-server:8000/arlas/explore/{collection}/_search?f=id:eq:{item}"` | ARLAS endpoint used by AGATE to check whether an item is accessible or not |
| services.agate.configuration.methodHeader | string | `"x-forwarded-method"` | URBAC HTTP header containing the method of the original request |
| services.agate.configuration.nbWorkers | int | `4` | Number of worker processes for AGATE |
| services.agate.configuration.roles | object | `{"group/public":{"description":["Public group"],"permissions":["r:session:DELETE","r:permissions:GET","r:organisations:GET,POST","r:organisations/check:GET","r:users/.*:GET,PUT,DELETE"]},"role/arlas/builder":{"description":["Building dashboards in ARLAS"],"permissions":["r:collections:GET","r:collections/.*:PATCH,PUT,DELETE","r:collections/_export:GET","r:collections/_import:POST","r:persist/resource/.*:PUT,POST,DELETE"]},"role/arlas/datasets":{"description":["Managing data (ingest, update and enrich) in ARLAS"],"permissions":["r:datasets/.*:GET,PUT,POST,DELETE","r:/aproc/processes/ingest:GET","r:/aproc/processes/ingest/execution:POST","r:/aproc/processes/enrich:GET","r:/aproc/processes/enrich/execution:POST","r:/aproc/processes/directory_ingest:GET","r:/aproc/processes/directory_ingest/execution:POST","r:/aproc/processes/dc3build:GET","r:/aproc/processes/dc3build/execution:POST","r:/fam/.*:GET,POST","r:/aproc/jobs/.*:GET,DELETE","r:/aproc/jobs:GET","r:/airs/collections/.*:GET,POST,PUT,DELETE"]},"role/arlas/downloader":{"description":["Download data from ARLAS"],"permissions":["r:/aproc/processes/download:GET","r:/aproc/processes/download/execution:POST","r:/aproc/jobs/.*:GET,DELETE"]},"role/arlas/owner":{"description":["Managing users and permissions of ARLAS"],"permissions":["r:permissions:GET","r:collections:GET","r:organisations:GET,POST","r:organisations/.*:GET,POST,PUT,DELETE","r:users/.*:GET,PUT,DELETE","r:session:DELETE"]},"role/arlas/tagger":{"description":["Tagging data in ARLAS"],"permissions":["r:write/.*:POST","r:status/.*:GET"]},"role/arlas/user":{"description":["Viewing data in ARLAS"],"permissions":["h:arlas-organization:${org}","h:arlas-workspace:${ws}","r:explore/.*:GET,POST","r:collections/.*:GET","r:explore/_list:GET","r:explore/ogc/opensearch/.*:GET","r:ogc/.*:GET","r:stac:GET","r:openapi.json:GET","r:stac/.*:GET,POST","r:persist/resource/.*:GET","r:persist/groups/.*:GET","r:persist/resources/.*:GET","r:authorize/resources:GET"]},"role/iam/admin":{"description":["IAM admin"],"permissions":["r:organisations:GET,POST","r:organisations/.*:GET,POST,DELETE","r:users/.*:GET,PUT,DELETE","r:session:DELETE","r:permissions:GET"]},"role/m2m/importer":{"description":["M2M account for importing collections"],"permissions":["r:collections:GET","r:collections/.*:PATCH,PUT,DELETE","r:collections/_import:POST","r:organisations/.*:GET","r:persist/resource/.*:POST,PUT"]}}` | Roles used by URBAC. See example at https://raw.githubusercontent.com/gisaia/ARLAS-server/master/arlas-commons/src/main/resources/roles.yaml |
| services.agate.configuration.services.airs-storage.jwt_location | list | `["headers"]` | Locations where to find the JWT token for storage access |
| services.agate.configuration.services.airs-storage.jwt_name | string | `"authorization"` | Name of the header containing the JWT token |
| services.agate.configuration.services.airs-storage.private | list | `[{"part":"path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/overview"},{"part":"path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/cog"}]` | Patterns for private assets |
| services.agate.configuration.services.airs-storage.public | list | `[{"part":"path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/thumbnail"}]` | Patterns for private assets |
| services.agate.configuration.services.cog | object | `{"jwt_location":["headers","query_params"],"jwt_name":"authorization","private":[{"part":"query.url.url.path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/(?P<asset>[^/]+)"}]}` | Configuration for accessing private COG assets |
| services.agate.configuration.services.cog.jwt_location | list | `["headers","query_params"]` | Locations where to find the JWT token for COG access |
| services.agate.configuration.services.cog.jwt_name | string | `"authorization"` | Name of the header containing the JWT token for COG access |
| services.agate.configuration.services.cog.private | list | `[{"part":"query.url.url.path","pattern":"(/airs-storage/)(?P<collection>[^/]+)/items/(?P<item>[^/]+)/assets/(?P<asset>[^/]+)"}]` | Patterns for private COG assets |
| services.agate.configuration.services.cog_preview.jwt_location | list | `["headers","query_params"]` | Locations where to find the JWT token for COG preview access |
| services.agate.configuration.services.cog_preview.jwt_name | string | `"authorization"` | Name of the header containing the JWT token for COG preview access |
| services.agate.configuration.services.cog_preview.public | list | `[{"part":"path","pattern":"(/cog/preview)(.*)"}]` | Patterns for public COG preview access |
| services.agate.configuration.services.cog_statistics.jwt_location | list | `["headers","query_params"]` | Locations where to find the JWT token for COG statistics access |
| services.agate.configuration.services.cog_statistics.jwt_name | string | `"authorization"` | Name of the header containing the JWT token for COG statistics access |
| services.agate.configuration.services.cog_statistics.public | list | `[{"part":"path","pattern":"(/cog/statistics)(.*)"}]` | Patterns for public COG statistics access |
| services.agate.configuration.urbac.jwks_uri | string | `"https://keycloak.arlas.k8s/auth/realms/arlas/protocol/openid-connect/certs"` | Keys endpoint |
| services.agate.configuration.urbac.jwtAudience | string | `"arlas-backend"` | Expected audience in the JWT token |
| services.agate.configuration.urbac.jwtHeader | string | `"authorization"` | URBAC HTTP header containing the JWT token of the original request |
| services.agate.configuration.urbac.verifyJwt | bool | `true` | Whether to verify the JWT signature or not |
| services.agate.configuration.urbac.verifySsl | bool | `true` | Whether to verify the SSL certificate of the OpenID Provider or not |
| services.agate.configuration.urlHeader | string | `"x-forwarded-uri"` | HTTP header containing the original request URL |
| services.agate.extraContainers | list | `[]` |  |
| services.agate.extraEnv | string | `nil` |  |
| services.agate.extraInitContainers | string | `nil` |  |
| services.agate.extraVolumeMounts | string | `nil` |  |
| services.agate.extraVolumes | string | `nil` |  |
| services.agate.image | string | `"gisaia/agate:0.10.6"` |  |
| services.agate.imagePullSecrets | list | `[]` | Extra environment variables for the agate container |
| services.agate.nodeSelector | object | `{}` | Node selector for AGATE service pods |
| services.agate.replicaCount | int | `1` | Number of AGATE service replicas |
| services.agate.resources | object | `{"limits":{"cpu":0.5,"memory":"256Mi"},"requests":{"cpu":0.1,"memory":"50Mi"}}` | Resources configuration for AGATE service |
| services.agate.serviceBinding | string | `"0.0.0.0"` |  |
| services.agate.serviceName | string | `"arlas-agate"` |  |
| services.agate.tolerations | list | `[]` | Tolerations for AGATE service pods |
| services.agate.urlPrefix | string | `"/agate"` |  |
| services.airs.affinity | object | `{}` | Affinity for AIRS service pods |
| services.airs.configuration.arlaseoCollectionUrl | string | `"https://raw.githubusercontent.com/gisaia/ARLAS-EO/v1.1.0/collection.json"` | ARLAS-EO collection URL used for initializing new collections. |
| services.airs.configuration.arlaseoMappingUrl | string | `"/app/mappings/arlas_eo_mapping.json"` | ARLAS-EO mapping and collection URLs used for initializing new indices of new collections |
| services.airs.configuration.indexCollectionPrefix | string | `"org.com@airs"` | Prefix for elasticsearch indices created for AIRS collections. This MUST contain the organization name followed by '@' followed by a custom suffix, e.g. org.com@airs |
| services.airs.configuration.s3.accessKeyId | string | `"airs"` | S3 access key id |
| services.airs.configuration.s3.assetHttpEndpointUrl | string | `"https://arlas-stack-minio:9000/{}/{}"` | Public URL Pattern to access assets over HTTPS, must look like http(s)://your-s3-endpoint/{}/{} where first {} is the bucket, second {} is the path to the object. This is used to generate the asset URLs in the STAC item |
| services.airs.configuration.s3.bucket | string | `"airs-storage"` | S3 bucket name for storing and accessing the STAC collections, items and managed assets |
| services.airs.configuration.s3.endpointUrl | string | `"http://arlas-stack-minio:9000"` | S3 internal endpoint URL, e.g. http://minio:9000 |
| services.airs.configuration.s3.platform | string | `"MINIO"` | S3 platform type. This value is provided in the item properties of the STAC item |
| services.airs.configuration.s3.region | string | `nil` | S3 bucket's region. This value is provided in the item properties of the STAC item |
| services.airs.configuration.s3.secretAccessKey | string | `"airssecret"` | S3 secret access key |
| services.airs.configuration.s3.tier | string | `"Standard"` | S3 bucket's tier. This value is provided in the item properties of the STAC item |
| services.airs.configuration.s3.writablePaths | list | `["/"]` | List of writable paths in the S3 bucket |
| services.airs.extraContainers | list | `[]` |  |
| services.airs.extraEnv | list | `[]` |  |
| services.airs.extraInitContainers | list | `[]` |  |
| services.airs.extraVolumeMounts | list | `[]` |  |
| services.airs.extraVolumes | list | `[]` |  |
| services.airs.image | string | `"gisaia/airs:0.10.6"` |  |
| services.airs.imagePullSecrets | list | `[]` |  |
| services.airs.nodeSelector | object | `{}` | Node selector for AIRS service pods |
| services.airs.replicaCount | int | `1` | Number of AIRS service replicas |
| services.airs.resources | object | `{"limits":{"cpu":0.5,"memory":"2Gi"},"requests":{"cpu":0.1,"memory":"50Mi"}}` | Resources configuration for AIRS service |
| services.airs.serviceBinding | string | `"0.0.0.0"` |  |
| services.airs.serviceName | string | `"airs-server"` |  |
| services.airs.tolerations | list | `[]` | Tolerations for AIRS service pods |
| services.airs.urlPrefix | string | `"/airs"` |  |
| services.aproc.configuration.accessManager.storages | list | `[{"readable_paths":["/inputs"],"type":"file","writable_paths":["/tmp","/outbox"]},{"bucket":"archives","endpoint":"$APROC_ARCHIVE_ENDPOINT|http://minio:9000\"","readable_paths":["/inputs"],"type":"s3"},{"bucket":"downloads","endpoint":"http://minio:9000","readable_paths":["/"],"type":"s3","writable_paths":["/"]}]` | Configuration of the storages used by the access manager to provide access to various storage backends |
| services.aproc.configuration.accessManager.tmpDir | string | `"/tmp/"` | Temporary directory used by the access manager |
| services.aproc.configuration.airsEndpoint | string | `"http://airs-server:8000/arlas/airs"` | AIRS service endpoint URL accessed by APROC |
| services.aproc.configuration.arlasUrlSearch | string | `"http://arlas-server:8000/arlas/explore/{collection}/_search?f=id:eq:{item}"` | ARLAS search URL used by APROC to check whether an item exists |
| services.aproc.configuration.celeryBrokerUrl | string | `"pyamqp://guest:guest@rabbitmq:5672//"` | Celery broker URL for APROC tasks |
| services.aproc.configuration.celeryResultBackend | string | `"redis://:somepassword@redis-master:6379/0"` |  |
| services.aproc.configuration.celeryResultBackendTransportOptions | string | `nil` |  |
| services.aproc.configuration.extensions.dc3build.drivers.safe.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.dc3build.drivers.safe.priority | int | `1` |  |
| services.aproc.configuration.extensions.dc3build.enabled | bool | `true` | Whether the DC3 build extension is enabled or not |
| services.aproc.configuration.extensions.directoryIngest.enabled | bool | `true` | Whether the directory ingest extension is enabled or not |
| services.aproc.configuration.extensions.download.cleanOutboxDir | bool | `true` | should directory where download are temporally built before copy are cleaned |
| services.aproc.configuration.extensions.download.downloadMappingUrl | string | `"/app/mappings/arlas_eo_download_mapping.json"` | Downloads mapping configuration for indexing the download requests |
| services.aproc.configuration.extensions.download.drivers.copy | object | `{"enabled":true,"priority":4}` | drivers used for building the downloads. This list should remain as is unless you have custom download drivers |
| services.aproc.configuration.extensions.download.drivers.imageFile.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.download.drivers.imageFile.priority | int | `3` |  |
| services.aproc.configuration.extensions.download.drivers.metFile.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.download.drivers.metFile.priority | int | `2` |  |
| services.aproc.configuration.extensions.download.drivers.zarr.enabled | bool | `false` |  |
| services.aproc.configuration.extensions.download.drivers.zarr.priority | int | `1` |  |
| services.aproc.configuration.extensions.download.emails.message.admin.emails | string | `"admin@the.boss,someone.else@the.boss"` | admin emails that will receive the download notifications, other than the user himself |
| services.aproc.configuration.extensions.download.emails.message.done.admin | object | `{"content":"The download of {collection}/{item_id} for {arlas-user-email} is available in {target_directory} ({file_name}) for projection {target_projection} ({target_format}). <br>ARLAS Services.","subject":"The download of {collection}/{item_id} for {arlas-user-email} is available."}` | Message templates for download done notifications to admins |
| services.aproc.configuration.extensions.download.emails.message.done.user | object | `{"content":"ARLAS Services - Dear {arlas-user-email}. <br>Your download of {collection}/{item_id} is available for projection {target_projection} ({target_format}). <br>ARLAS Services.","subject":"ARLAS Services - Your download of {collection}/{item_id} is available."}` | Message templates for download done notifications to users |
| services.aproc.configuration.extensions.download.emails.message.error | object | `{"content":"ARLAS Services - The download of {collection}/{item_id} failed ({error}).","subject":"ARLAS Services - ERROR - The download of {collection}/{item_id} failed."}` | Message templates for download error notifications to users and admins |
| services.aproc.configuration.extensions.download.emails.message.path.prefix | string | `"file:/"` | prefix to put in front of the path for emails |
| services.aproc.configuration.extensions.download.emails.message.path.windows | bool | `false` | change to windows path |
| services.aproc.configuration.extensions.download.emails.message.request.admin | object | `{"content":"ARLAS Services - {arlas-user-email} requested the download of {collection}/{item_id} for projection {target_projection} ({target_format}). <br>ARLAS Services.","subject":"ARLAS Services - {arlas-user-email} requested the download of {collection}/{item_id}."}` | Message templates for download request notifications to admins |
| services.aproc.configuration.extensions.download.emails.message.request.user | object | `{"content":"ARLAS Services - Dear {arlas-user-email}. <br>Your download request for {collection}/{item_id} with projection {target_projection} ({target_format}) will shortly be taken into account. <br>ARLAS Services.","subject":"ARLAS Services - Thank you for your download request (({collection}/{item_id})."}` | Message templates for download request notifications to users |
| services.aproc.configuration.extensions.download.enabled | bool | `true` | Whether the download extension is enabled or not |
| services.aproc.configuration.extensions.download.index.name | string | `"aproc_downloads"` | Elasticsearch index name for the download requests |
| services.aproc.configuration.extensions.download.outboxDirectory | string | `"/tmp/downloads"` | where downloads are placed |
| services.aproc.configuration.extensions.download.outboxS3 | object | `{"accessKeyId":"airs","assetHttpEndpointUrl":"http://arlas-stack-minio:9000/{}/{}","bucket":"downloads","endpointUrl":"http://arlas-stack-minio:9000","secretAccessKey":"airssecret"}` | S3 configuration for uploading the built downloads |
| services.aproc.configuration.extensions.download.outboxS3.accessKeyId | string | `"airs"` | S3 access key id for uploading the built downloads |
| services.aproc.configuration.extensions.download.outboxS3.assetHttpEndpointUrl | string | `"http://arlas-stack-minio:9000/{}/{}"` | Public URL Pattern to access the built downloads over HTTPS, must look like http(s)://your-s3-endpoint/{}/{} where first {} is the bucket, second {} is the path to the object |
| services.aproc.configuration.extensions.download.outboxS3.bucket | string | `"downloads"` | S3 bucket name for uploading the built downloads |
| services.aproc.configuration.extensions.download.outboxS3.endpointUrl | string | `"http://arlas-stack-minio:9000"` | S3 endpoint URL for uploading the built downloads |
| services.aproc.configuration.extensions.download.outboxS3.secretAccessKey | string | `"airssecret"` | S3 secret access key for uploading the built downloads |
| services.aproc.configuration.extensions.enrich.drivers.s2_cog.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.enrich.drivers.s2_cog.priority | int | `1` |  |
| services.aproc.configuration.extensions.enrich.enabled | bool | `true` | Whether the enrich extension is enabled or not |
| services.aproc.configuration.extensions.ingest.aprocEndpoint | string | `"http://aproc-service:8001"` | APROC endpoint URL accessed by the ingest extension |
| services.aproc.configuration.extensions.ingest.drivers.astDem.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.astDem.priority | int | `4` |  |
| services.aproc.configuration.extensions.ingest.drivers.axelspace.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.axelspace.priority | int | `16` |  |
| services.aproc.configuration.extensions.ingest.drivers.bsg.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.bsg.priority | int | `10` |  |
| services.aproc.configuration.extensions.ingest.drivers.cosmoskymed.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.cosmoskymed.priority | int | `8` |  |
| services.aproc.configuration.extensions.ingest.drivers.digitalglobe.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.digitalglobe.priority | int | `3` |  |
| services.aproc.configuration.extensions.ingest.drivers.dimap.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.dimap.priority | int | `1` |  |
| services.aproc.configuration.extensions.ingest.drivers.geoeyes.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.geoeyes.priority | int | `2` |  |
| services.aproc.configuration.extensions.ingest.drivers.geosat.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.geosat.priority | int | `17` |  |
| services.aproc.configuration.extensions.ingest.drivers.iceye.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.iceye.priority | int | `13` |  |
| services.aproc.configuration.extensions.ingest.drivers.jpeg2000.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.jpeg2000.priority | int | `101` |  |
| services.aproc.configuration.extensions.ingest.drivers.radarsat2.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.radarsat2.priority | int | `14` |  |
| services.aproc.configuration.extensions.ingest.drivers.rapideye.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.rapideye.priority | int | `5` |  |
| services.aproc.configuration.extensions.ingest.drivers.sentinel1.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.sentinel1.priority | int | `12` |  |
| services.aproc.configuration.extensions.ingest.drivers.sentinel2.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.sentinel2.priority | int | `11` |  |
| services.aproc.configuration.extensions.ingest.drivers.skysat.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.skysat.priority | int | `15` |  |
| services.aproc.configuration.extensions.ingest.drivers.spot5.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.spot5.priority | int | `6` |  |
| services.aproc.configuration.extensions.ingest.drivers.terrasarx.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.terrasarx.priority | int | `7` |  |
| services.aproc.configuration.extensions.ingest.drivers.tiff.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.tiff.priority | int | `100` |  |
| services.aproc.configuration.extensions.ingest.drivers.umbra.enabled | bool | `true` |  |
| services.aproc.configuration.extensions.ingest.drivers.umbra.priority | int | `9` |  |
| services.aproc.configuration.extensions.ingest.enabled | bool | `true` | Whether the archive ingest extension is enabled or not |
| services.aproc.configuration.extensions.ingest.inputsDirectory | string | `"/inputs"` | Directory where archives to ingest are stored |
| services.aproc.configuration.extensions.ingest.maxNumberOfArchivesForIngest | int | `100000` | Maximum number of archives that can be ingested in a single batch |
| services.aproc.configuration.extensions.ingest.resourceIdHashStartAt | int | `1` |  |
| services.aproc.service.affinity | object | `{}` | Affinity for APROC service pods |
| services.aproc.service.extraContainers | list | `[]` |  |
| services.aproc.service.extraEnv | string | `nil` |  |
| services.aproc.service.extraInitContainers | string | `nil` |  |
| services.aproc.service.extraVolumeMounts | string | `nil` |  |
| services.aproc.service.extraVolumes | string | `nil` |  |
| services.aproc.service.image | string | `"gisaia/aproc-service:0.10.6"` |  |
| services.aproc.service.imagePullSecrets | list | `[]` |  |
| services.aproc.service.nodeSelector | object | `{}` | Node selector for APROC service pods |
| services.aproc.service.replicaCount | int | `1` | Number of APROC service replicas |
| services.aproc.service.resources | object | `{"limits":{"cpu":0.5,"memory":"256Mi"},"requests":{"cpu":0.1,"memory":"50Mi"}}` | Resources configuration for APROC service |
| services.aproc.service.serviceBinding | string | `"0.0.0.0"` |  |
| services.aproc.service.serviceName | string | `"aproc-service"` |  |
| services.aproc.service.tolerations | list | `[]` | Tolerations for APROC service pods |
| services.aproc.service.urlPrefix | string | `"/aproc"` |  |
| services.aproc.worker.affinity | object | `{}` | Affinity for APROC worker pods |
| services.aproc.worker.extraContainers | list | `[]` |  |
| services.aproc.worker.extraEnv | string | `nil` |  |
| services.aproc.worker.extraInitContainers | string | `nil` |  |
| services.aproc.worker.extraVolumeMounts | string | `nil` |  |
| services.aproc.worker.extraVolumes | string | `nil` |  |
| services.aproc.worker.image | string | `"gisaia/aproc-proc:0.10.6"` |  |
| services.aproc.worker.imagePullSecrets | list | `[]` |  |
| services.aproc.worker.nodeSelector | object | `{}` | Node selector for APROC worker pods |
| services.aproc.worker.replicaCount | int | `1` | Number of APROC worker replicas |
| services.aproc.worker.resources | object | `{"limits":{"cpu":2,"memory":"2Gi"},"requests":{"cpu":0.5,"memory":"512Mi"}}` | Resources configuration for APROC worker |
| services.aproc.worker.serviceName | string | `"aproc-proc"` |  |
| services.aproc.worker.tolerations | list | `[]` | Tolerations for APROC worker pods |
| services.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| services.fam.affinity | object | `{}` | Affinity for FAM service pods |
| services.fam.extraContainers | list | `[]` |  |
| services.fam.extraEnv | string | `nil` |  |
| services.fam.extraInitContainers | string | `nil` |  |
| services.fam.extraVolumeMounts | string | `nil` |  |
| services.fam.extraVolumes | string | `nil` |  |
| services.fam.image | string | `"gisaia/fam:0.10.6"` |  |
| services.fam.imagePullSecrets | list | `[]` | Extra environment variables for the fam container |
| services.fam.nodeSelector | object | `{}` | Node selector for FAM service pods |
| services.fam.replicaCount | int | `1` | Number of FAM service replicas |
| services.fam.resources | object | `{"limits":{"cpu":0.5,"memory":"256Mi"},"requests":{"cpu":0.1,"memory":"50Mi"}}` | Resources configuration for FAM service |
| services.fam.serviceBinding | string | `"0.0.0.0"` |  |
| services.fam.serviceName | string | `"arlas-fam"` |  |
| services.fam.tolerations | list | `[]` | Tolerations for FAM service pods |
| services.fam.urlPrefix | string | `"/fam"` |  |
| services.podSecurityContext.fsGroup | int | `1000` |  |
| services.podSecurityContext.runAsNonRoot | bool | `true` |  |
| services.podSecurityContext.runAsUser | int | `1000` |  |
| services.servicePort | int | `8000` |  |
| services.serviceType | string | `"ClusterIP"` |  |
| smtp.enabled | bool | `false` | Whether SMTP email sending is enabled or not |
| smtp.from | string | `"tobechanged"` | SMTP sender email address |
| smtp.host | string | `"tobechanged"` | SMTP server host |
| smtp.password | string | `"tobechanged"` | SMTP password |
| smtp.port | int | `25` | SMTP server port |
| smtp.username | string | `"tobechanged"` | SMTP username |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
