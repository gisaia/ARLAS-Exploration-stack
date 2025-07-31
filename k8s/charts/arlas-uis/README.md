# arlas-wui

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square)

A Helm Chart to deploy ARLAS Wui

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| actionsEnv[0] | object | `{"name":"ARLAS_DOWNLOAD_PROCESS_URL","value":"/aproc/processes/download/execution"}` | Relative AIAS download execution URL |
| actionsEnv[1] | object | `{"name":"ARLAS_DOWNLOAD_PROCESS_CHECK_URL","value":"/aproc/processes/download"}` | Relative AIAS download URL |
| actionsEnv[2] | object | `{"name":"ARLAS_DOWNLOAD_PROCESS_MAX_ITEMS","value":"100"}` | AIAS download max number of items |
| actionsEnv[3] | object | `{"name":"ARLAS_DOWNLOAD_PROCESS_SETTINGS_URL","value":"assets/processes/download.json"}` | AIAS download configuration file location |
| actionsEnv[4] | object | `{"name":"ARLAS_DOWNLOAD_PROCESS_STATUS_URL","value":"/aproc/jobs"}` | AIAS download status relative url |
| actionsEnv[5] | object | `{"name":"ARLAS_ENRICH_PROCESS_URL","value":"/aproc/processes/enrich/execution"}` | Relative AIAS enrich execution URL |
| actionsEnv[6] | object | `{"name":"ARLAS_ENRICH_PROCESS_CHECK_URL","value":"/aproc/processes/enrich"}` | Relative AIAS enrich URL |
| actionsEnv[7] | object | `{"name":"ARLAS_ENRICH_PROCESS_MAX_ITEMS","value":"100"}` | AIAS enrich max number of items |
| actionsEnv[8] | object | `{"name":"ARLAS_ENRICH_PROCESS_SETTINGS_URL","value":"assets/processes/enrich.json"}` | AIAS enrich configuration file location |
| actionsEnv[9] | object | `{"name":"ARLAS_ENRICH_PROCESS_STATUS_URL","value":"/aproc/jobs"}` | AIAS enrich status relative url |
| affinity | object | `{}` | Allows constraining pod(s) to only run on particular nodes, or to prefer to run on particular nodes. It is based on label-selection. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| basemap.storageSize | string | `"10Mi"` | Size of the directory containing the basemap files |
| dnsDomain | string | `"localhost"` | DNS domain hosting ARLAS |
| image | string | `"gisaia/arlas-wui:27.0.5"` |  |
| logger.loggingConsoleLevel | string | `"INFO"` | Default console logging level |
| logger.loggingLevel | string | `"INFO"` | Default logging level |
| nodeSelector | object | `{}` | Label-based selector, to control the nodes the pod(s) will run on. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector |
| permissions.urlPrefix | string | `"/arlas/permissions"` |  |
| persistence.urlPrefix | string | `"/arlas/persistence"` |  |
| replicaCount | int | `1` | Number of desired pods |
| resources.limits.cpu | float | `0.3` |  |
| resources.limits.memory | string | `"30Mi"` |  |
| resources.requests.cpu | float | `0.05` |  |
| resources.requests.memory | string | `"10Mi"` |  |
| serviceName | string | `"arlas-wui"` |  |
| servicePort | int | `8080` |  |
| serviceType | string | `"ClusterIP"` |  |
| tolerations | list | `[]` | Pod-Tolerations & Nodes-Taints work together to allow nodes to repel certain kinds of pods. See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| wui.baseAppPath | string | `"/arlas/wui"` | Base URL path |
| wui.configuration | object | `{}` |  |
| wui.dashboardShortcut | bool | `false` | Whether to display the dashboard shortcut icon |
| wui.enableGeocoding | bool | `false` | Enable or disable Geocoding feature |
| wui.geocodingUrl | string | `nil` | Geocoding find place URL |
| wui.geocodingZoomTo | int | `11` | Maximum zoom level for geocoding feature |
| wui.googleAnalyticsKey | string | `nil` | The Google Analytics key of the wui app |
| wui.histogramsExportNbBuckets | int | `1000` | Maximum number of buckets for the histogram export |
| wui.histogramsMaxBucket | int | `200` | Maximum number of buckets for the histogram graph |
| wui.hitsExporterVersion | float | `2.2` | Version number of the ARLAS Hits Exporter to use |
| wui.links | list | `[]` | List of links to be added in the left menu of the WUI. Each link must contain `icon`, `url` and `name` attributes. |
| wui.resultListEnableExport | bool | `false` | Whether or not to enable result list export |
| wui.resultListExportSize | int | `1000` | Result list export size |
| wui.tabName | string | `"ARLAS Exploration"` | The text to display on the tab of the web browser (will be enriched with the dashboard name) |
| wuiAuthent.authMode | string | `"openid"` | Defines authentication mode (i.e. "iam", "openid" or not defined) |
| wuiAuthent.clearHashAfterLogin | bool | `true` | Defines whether to clear the hash fragment in url after logging in |
| wuiAuthent.clientId | string | `nil` | The client's id as registered with the auth server |
| wuiAuthent.customQueryParams | list | `[{"audience":"http://arlas.io/api/server"}]` | Custom query params |
| wuiAuthent.disableAtHashCheck | bool | `true` | This property has been introduced to disable at_hash checks and is indented for Identity Provider that does not deliver an at_hash EVEN THOUGH its recommended by the OIDC specs. |
| wuiAuthent.forceConnect | bool | `false` | When authentication is enabled, this option forces to be connected to Identity Provider at application bootstrap |
| wuiAuthent.issuer | string | `nil` | The issuer's uri |
| wuiAuthent.logoutUrl | string | `nil` | The logout URL to be used |
| wuiAuthent.requireHttps | bool | `true` | Defines whether https is required |
| wuiAuthent.responseType | string | `"code"` | Response type values |
| wuiAuthent.scope | string | `"profile"` |  |
| wuiAuthent.sessionChecksEnabled | bool | `true` | If true, the app will try to check whether the user is still logged in on a regular basis as described |
| wuiAuthent.showDebugInformation | bool | `false` | Defines whether to display debug log in browser console |
| wuiAuthent.silentRefreshTimeout | string | `"10000"` | Timeout for silent refresh |
| wuiAuthent.storage | string | `"memorystorage"` | Defines the kind of storage: localstorage or sessionstorage |
| wuiAuthent.threshold | int | `60000` | Refresh token timer (arlas iam) |
| wuiAuthent.timeoutFactor | string | `"0.75"` | Defines when the token_timeout event should be raised. If you set this to the default value 0.75, the event s triggered after 75% of the token's life time. |
| wuiAuthent.useAuthent | bool | `true` | Defines whether to be authenticated to Identity Provider |
| wuiAuthent.useDiscovery | bool | `true` | Defines whether we use Identity Provider document discovery service |
| wuiHub.baseAppPath | string | `"/arlas/wui/hub"` | Base URL path |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
