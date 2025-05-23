# arlas-aias

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square)

A Helm Chart to deploy arlas-aias

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../arlas-server | arlas-server | 0.0.1 |
| https://charts.bitnami.com/bitnami | elasticsearch | 22.0.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| arlas-server.dnsDomain | string | `"localhost"` |  |
| dnsDomain | string | `"localhost"` |  |
| elasticsearch.coordinating.replicaCount | int | `0` |  |
| elasticsearch.data.replicaCount | int | `0` |  |
| elasticsearch.ingest.replicaCount | int | `0` |  |
| elasticsearch.master.masterOnly | bool | `false` |  |
| elasticsearch.master.replicaCount | int | `1` |  |
| arlas-server.affinity | object | `{}` | Allows constraining pod(s) to only run on particular nodes, or to prefer to run on particular nodes. It is based on label-selection. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| arlas-server.apm | bool | `false` | Whether ES APM should be activated or not |
| arlas-server.cacheFactoryClass | string | `"io.arlas.server.core.impl.cache.LocalCacheFactory"` | The factory class for the cache (io.arlas.server.core.impl.cache.HazelcastCacheFactory, io.arlas.server.core.impl.cache.LocalCacheFactory or io.arlas.server.core.impl.cache.NoCacheFactory) |
| arlas-server.cacheTimeout | int | `60` | Cache TTL for items in cache (seconds), used for all deployments to ensure consistency |
| arlas-server.cors.allowedCredentials | bool | `true` | CORS Allowed Credentials or not |
| arlas-server.cors.allowedHeaders | string | `"arlas-user,arlas-groups,arlas-organization,arlas-org-filter,X-Requested-With,Content-Type,Accept,Origin,Authorization,X-Forwarded-User"` | CORS Allowed Headers |
| arlas-server.cors.allowedMethods | string | `"OPTIONS,GET,PUT,POST,DELETE,HEAD"` | CORS Allowed Methods |
| arlas-server.cors.allowedOrigins | string | `"\"*\""` | CORS Allowed Origins |
| arlas-server.cors.enabled | bool | `false` | Enable CORS or not |
| arlas-server.cors.exposedHeaders | string | `"Content-Type,Authorization,X-Requested-With,Content-Length,Accept,Origin,Location,WWW-Authenticate"` | CORS Exposed Headers |
| arlas-server.dnsDomain | string | `"localhost"` |  |
| arlas-server.elastic.apm.secret | string | `nil` |  |
| arlas-server.elastic.apm.url | string | `nil` |  |
| arlas-server.elasticEnv[0].name | string | `"ARLAS_ELASTIC_SKIP_MASTER"` |  |
| arlas-server.elasticEnv[0].value | string | `"true"` |  |
| arlas-server.elasticEnv[1].name | string | `"ARLAS_ELASTIC_SNIFFING"` |  |
| arlas-server.elasticEnv[1].value | string | `"false"` |  |
| arlas-server.elasticEnv[2].name | string | `"ARLAS_ELASTIC_ENABLE_SSL"` |  |
| arlas-server.elasticEnv[2].value | string | `"false"` |  |
| arlas-server.enabled | bool | `true` | Whether to protect ARLAS server with authentication |
| arlas-server.image | string | `"gisaia/arlas-server:27.0.1"` |  |
| arlas-server.jvmXmx | string | `"1800m"` | Java Xmx value |
| arlas-server.logger.loggingConsoleLevel | string | `"INFO"` | Default console logging level |
| arlas-server.logger.loggingLevel | string | `"INFO"` | Default logging level |
| arlas-server.nodeSelector | object | `{}` | Label-based selector, to control the nodes the pod(s) will run on. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector |
| arlas-server.permissionUrl | string | `"/permissions"` | Endpoint to call in order to get user permissions given an access token when using HTTPPolicyEnforcer class |
| arlas-server.policyEnv | list | `[{"name":"ARLAS_AUTH_POLICY_CLASS","value":"io.arlas.filter.impl.NoPolicyEnforcer"}]` | ARLAS Policy Enforcer |
| arlas-server.policyEnv[0] | object | `{"name":"ARLAS_AUTH_POLICY_CLASS","value":"io.arlas.filter.impl.NoPolicyEnforcer"}` | Policy Enforcer class to use |
| arlas-server.publicUris | string | `"swagger,swagger.*,openapi.*,session:POST, session/refresh:PUT,users:POST,users/.*:POST,organisations/check:GET"` | Comma separated list of endpoints that should bypass authentication |
| arlas-server.replicaCount | int | `1` | Number of desired pods |
| arlas-server.resources.limits.cpu | int | `2` |  |
| arlas-server.resources.limits.memory | string | `"2000Mi"` |  |
| arlas-server.resources.requests.cpu | float | `0.5` |  |
| arlas-server.resources.requests.memory | string | `"750Mi"` |  |
| arlas-server.serviceName | string | `"arlas-server"` |  |
| arlas-server.services.cswActivated | string | `"\"false\""` | Whether CSW Service is activated or not |
| arlas-server.services.inspireActivated | string | `"\"false\""` | Whether INSPIRE Service is activated or not |
| arlas-server.services.rasterTileActivated | string | `"\"false\""` | Whether Raster Tile Service is activated or not |
| arlas-server.services.wfsActivated | string | `"\"false\""` | Whether WFS Service is activated or not |
| arlas-server.swaggerResource | string | `"io.arlas.server.rest,io.arlas.server.stac"` | The java package to process for extracting the APIs displayed in Swagger |
| arlas-server.tolerations | list | `[]` | Pod-Tolerations & Nodes-Taints work together to allow nodes to repel certain kinds of pods. See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| arlas-server.urlPrefix | string | `"/arlas"` | Base URL path for the server's general API |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
