# aias-services

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square)

A Helm Chart to deploy ARLAS AIAS Services

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| airsIndexPrefix | string | `"airs"` | Prefix appended to elasticsearch indices containing AIRS collections. The final name is of the form: prefix@organization_indexname |
| arlasMappingUrl | string | `"https://raw.githubusercontent.com/gisaia/ARLAS-EO/v0.0.9/mapping.json"` | This elasticsearch mapping is used during the initialization of the index of a newly created collection |
| arlasSearchUrl | string | `"http://arlas-server:9999/arlas/explore/{collection}/_search?f=id:eq:{item}"` | ARLAS URL Search for AGATE to check whether an item is accessible or not |
| cors.allowedCredentials | bool | `true` | CORS Allowed Credentials or not |
| cors.allowedHeaders | string | `"arlas-user,arlas-groups,arlas-organization,arlas-org-filter,X-Requested-With,Content-Type,Accept,Origin,Authorization,X-Forwarded-User"` | CORS Allowed Headers |
| cors.allowedHosts | string | `"0.0.0.0"` |  |
| cors.allowedMethods | string | `"OPTIONS,GET,PUT,POST,DELETE,HEAD"` | Allowed hosts |
| cors.allowedOrigins | string | `"\"*\""` | CORS Allowed Origins |
| cors.exposedHeaders | string | `"Content-Type,Authorization,X-Requested-With,Content-Length,Accept,Origin,Location,WWW-Authenticate"` | CORS Exposed Headers |
| dnsDomain | string | `"localhost"` | DNS domain hosting ARLAS |
| download.cleanAfterUpload | bool | `true` |  |
| download.downloadReportIndex | string | `"aproc_downloads"` | Name of the download index that will contain the download requests |
| download.message.admin.emails | string | `"admin@the.boss,someone.else@the.boss"` | admin emails that will receive the download notifications, other than the user himself |
| download.message.done.admin.content | string | `"The download of {collection}/{item_id} for {arlas-user-email} is available in {target_directory} ({file_name}) for projection {target_projection} ({target_format}). <br>ARLAS Services."` |  |
| download.message.done.admin.subject | string | `"The download of {collection}/{item_id} for {arlas-user-email} is available."` |  |
| download.message.done.user.content | string | `"ARLAS Services - Dear {arlas-user-email}. <br>Your download of {collection}/{item_id} is available for projection {target_projection} ({target_format}). <br>ARLAS Services."` |  |
| download.message.done.user.subject | string | `"ARLAS Services - Your download of {collection}/{item_id} is available."` |  |
| download.message.error.content | string | `"ARLAS Services - The download of {collection}/{item_id} failed ({error})."` |  |
| download.message.error.subject | string | `"ARLAS Services - ERROR - The download of {collection}/{item_id} failed."` |  |
| download.message.path.prefix | string | `"file:/"` | prefix to put in front of the path for emails |
| download.message.path.windows | bool | `false` | change to windows path |
| download.message.request.admin.content | string | `"ARLAS Services - {arlas-user-email} requested the download of {collection}/{item_id} for projection {target_projection} ({target_format}). <br>ARLAS Services."` |  |
| download.message.request.admin.subject | string | `"ARLAS Services - {arlas-user-email} requested the download of {collection}/{item_id}."` |  |
| download.message.request.user.content | string | `"ARLAS Services - Dear {arlas-user-email}. <br>Your download request for {collection}/{item_id} with projection {target_projection} ({target_format}) will shortly be taken into account. <br>ARLAS Services."` |  |
| download.message.request.user.subject | string | `"ARLAS Services - Thank you for your download request (({collection}/{item_id})."` |  |
| download.s3.bucket | string | `"downloads"` | bucket that will contain the downloads |
| download.s3.endpoint | string | `"http://arlas-stack-minio:9000"` | where downloads are uploaded once ready |
| download.s3.http | string | `"http://arlas-stack-minio:9000/{}/{}"` | where downloads are uploaded once ready, first {} is the bucket, second {} is the path to the object |
| download.s3.key | string | `"airs"` |  |
| download.s3.secret | string | `"airssecret"` |  |
| download.tmpFolder | string | `"/tmp/outbox/"` | Where download are temporally built before copy |
| elastic.cluster | string | `"elastic"` |  |
| elastic.login | string | `"elastic"` |  |
| elastic.password | string | `"elastic"` |  |
| ingest.folder | string | `"https://storage.googleapis.com/gisaia-public/OPENDATA/eo"` | Folder used by FAM for ingestion   |
| ingest.storage.forceDownload | bool | `true` |  |
| ingest.storage.s3.bucket | string | `""` |  |
| ingest.storage.s3.key | string | `""` |  |
| ingest.storage.s3.secret | string | `""` |  |
| ingest.storage.type | string | `"https"` |  |
| ingestFolder | string | `"https://storage.googleapis.com/gisaia-public/OPENDATA/eo"` | Root of the ingest folder |
| logger.loggingConsoleLevel | string | `"INFO"` | Default console logging level |
| logger.loggingLevel | string | `"INFO"` | Default logging level |
| organization | string | `"org.com"` | Name of the organization using AIAS |
| protocol | string | `"http"` |  |
| rabbitmq.host | string | `"rabbitmq"` |  |
| rabbitmq.login | string | `"guest"` |  |
| rabbitmq.password | string | `"guest"` |  |
| rabbitmq.port | int | `5672` |  |
| redis.db | int | `0` |  |
| redis.host | string | `"redis-master"` |  |
| redis.password | string | `"somepassword"` |  |
| redis.port | int | `6379` |  |
| redis.username | string | `"default"` |  |
| resourceIdHashStartAt | int | `0` |  |
| s3 | object | `{"accessKeyId":"airs","assetHttpEndpointUrlPattern":"http://arlas-stack-minio:9000/{}/{}","bucket":"airs-storage","endpoint":"http://arlas-stack-minio:9000","platform":"MINIO","region":"Standard","secret":"airssecret","tier":"Standard"}` | Configuration of the s3 used for storing and accessing the STAC collections, items and managed assets |
| s3.accessKeyId | string | `"airs"` | s3 key |
| s3.assetHttpEndpointUrlPattern | string | `"http://arlas-stack-minio:9000/{}/{}"` | asset_http_endpoint_url_pattern must look like https://storage.googleapis.com/{}/{} where first {} is the bucket, second {} is the path to the object   |
| s3.bucket | string | `"airs-storage"` | s3 bucket name for storing the STAC collections, items and managed assets |
| s3.endpoint | string | `"http://arlas-stack-minio:9000"` | s3 endpoint |
| s3.platform | string | `"MINIO"` | Platform type. This value is provided in the item properties |
| s3.region | string | `"Standard"` | Region. This value is provided in the item properties |
| s3.secret | string | `"airssecret"` | s3 secret |
| s3.tier | string | `"Standard"` | Tier. This value is provided in the item properties |
| services.agate.affinity | object | `{}` |  |
| services.agate.image | string | `"gisaia/agate:0.6.40"` |  |
| services.agate.nodeSelector | object | `{}` |  |
| services.agate.replicaCount | int | `1` |  |
| services.agate.resources.limits.cpu | float | `0.5` |  |
| services.agate.resources.limits.memory | string | `"256Mi"` |  |
| services.agate.resources.requests.cpu | float | `0.1` |  |
| services.agate.resources.requests.memory | string | `"50Mi"` |  |
| services.agate.serviceBinding | string | `"0.0.0.0"` |  |
| services.agate.serviceName | string | `"arlas-agate"` |  |
| services.agate.tolerations | list | `[]` |  |
| services.agate.urlPrefix | string | `"/agate"` |  |
| services.airs.affinity | object | `{}` |  |
| services.airs.image | string | `"gisaia/airs:0.6.40"` |  |
| services.airs.nodeSelector | object | `{}` |  |
| services.airs.replicaCount | int | `1` |  |
| services.airs.resources.limits.cpu | float | `0.5` |  |
| services.airs.resources.limits.memory | string | `"256Mi"` |  |
| services.airs.resources.requests.cpu | float | `0.1` |  |
| services.airs.resources.requests.memory | string | `"50Mi"` |  |
| services.airs.serviceBinding | string | `"0.0.0.0"` |  |
| services.airs.serviceName | string | `"airs-server"` |  |
| services.airs.tolerations | list | `[]` |  |
| services.airs.urlPrefix | string | `"/airs"` |  |
| services.aproc.service.affinity | object | `{}` |  |
| services.aproc.service.image | string | `"gisaia/aproc-service:0.6.40"` |  |
| services.aproc.service.nodeSelector | object | `{}` |  |
| services.aproc.service.replicaCount | int | `1` |  |
| services.aproc.service.resources.limits.cpu | float | `0.5` |  |
| services.aproc.service.resources.limits.memory | string | `"256Mi"` |  |
| services.aproc.service.resources.requests.cpu | float | `0.1` |  |
| services.aproc.service.resources.requests.memory | string | `"50Mi"` |  |
| services.aproc.service.serviceBinding | string | `"0.0.0.0"` |  |
| services.aproc.service.serviceName | string | `"aproc-service"` |  |
| services.aproc.service.tolerations | list | `[]` |  |
| services.aproc.service.urlPrefix | string | `"/aproc"` |  |
| services.aproc.worker.affinity | object | `{}` |  |
| services.aproc.worker.image | string | `"gisaia/aproc-proc:0.6.32"` |  |
| services.aproc.worker.nodeSelector | object | `{}` |  |
| services.aproc.worker.replicaCount | int | `1` |  |
| services.aproc.worker.resources.limits.cpu | int | `2` |  |
| services.aproc.worker.resources.limits.memory | string | `"2Gi"` |  |
| services.aproc.worker.resources.requests.cpu | float | `0.5` |  |
| services.aproc.worker.resources.requests.memory | string | `"512Mi"` |  |
| services.aproc.worker.serviceName | string | `"aproc-proc"` |  |
| services.aproc.worker.tolerations | list | `[]` |  |
| services.fam.affinity | object | `{}` |  |
| services.fam.image | string | `"gisaia/fam:0.6.40"` |  |
| services.fam.nodeSelector | object | `{}` |  |
| services.fam.replicaCount | int | `1` |  |
| services.fam.resources.limits.cpu | float | `0.5` |  |
| services.fam.resources.limits.memory | string | `"256Mi"` |  |
| services.fam.resources.requests.cpu | float | `0.1` |  |
| services.fam.resources.requests.memory | string | `"50Mi"` |  |
| services.fam.serviceBinding | string | `"0.0.0.0"` |  |
| services.fam.serviceName | string | `"arlas-fam"` |  |
| services.fam.tolerations | list | `[]` |  |
| services.fam.urlPrefix | string | `"/fam"` |  |
| services.servicePort | int | `8000` |  |
| services.serviceType | string | `"ClusterIP"` |  |
| smtp.enabled | bool | `false` |  |
| smtp.from | string | `"tobechanged"` |  |
| smtp.host | string | `"tobechanged"` |  |
| smtp.password | string | `"tobechanged"` |  |
| smtp.port | int | `25` |  |
| smtp.username | string | `"tobechanged"` |  |
| softTimeLimit | int | `1190` |  |
| timeLimit | int | `1200` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
