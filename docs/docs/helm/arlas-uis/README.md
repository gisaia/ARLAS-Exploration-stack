# arlas-uis

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square)

A Helm Chart to deploy ARLAS User Interfaces

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Allows constraining pod(s) to only run on particular nodes, or to prefer to run on particular nodes. It is based on label-selection. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| authent.authMode | string | `"openid"` | Defines authentication mode (i.e. "iam", "openid" or not defined) |
| authent.clearHashAfterLogin | bool | `true` | Defines whether to clear the hash fragment in url after logging in |
| authent.clientId | string | `"arlas-front"` | The client's id as registered with the auth server |
| authent.customQueryParams | list | `[{"audience":"http://arlas.io/api/server"}]` | Custom query params |
| authent.disableAtHashCheck | bool | `true` | This property has been introduced to disable at_hash checks and is indented for Identity Provider that does not deliver an at_hash EVEN THOUGH its recommended by the OIDC specs. |
| authent.forceConnect | bool | `true` | When authentication is enabled, this option forces to be connected to Identity Provider at application bootstrap |
| authent.issuer | string | `nil` | The issuer's uri |
| authent.logoutUrl | string | `nil` | The logout URL to be used |
| authent.requireHttps | bool | `false` | Defines whether https is required |
| authent.responseType | string | `"code"` | Response type values |
| authent.scope | string | `"profile"` |  |
| authent.sessionChecksEnabled | bool | `true` | If true, the app will try to check whether the user is still logged in on a regular basis as described |
| authent.showDebugInformation | bool | `false` | Defines whether to display debug log in browser console |
| authent.silentRefreshTimeout | string | `"1000"` | Timeout for silent refresh |
| authent.storage | string | `"memorystorage"` | Defines the kind of storage: localstorage or sessionstorage |
| authent.threshold | int | `60000` | Refresh token timer (arlas iam) |
| authent.timeoutFactor | string | `"0.75"` | Defines when the token_timeout event should be raised. If you set this to the default value 0.75, the event s triggered after 75% of the token's life time. |
| authent.useAuthent | bool | `true` | Defines whether to be authenticated to Identity Provider |
| authent.useDiscovery | bool | `true` | Defines whether we use Identity Provider document discovery service |
| basemap.storageSize | string | `"10Mi"` | Size of the directory containing the basemap files |
| configuration | object | `{}` |  |
| dashboardShortcut | bool | `false` | Whether to display the dashboard shortcut icon |
| dnsDomain | string | `"localhost"` | DNS domain hosting ARLAS |
| enableGeocoding | bool | `false` | Enable or disable Geocoding feature |
| geocodingUrl | string | `nil` | Geocoding find place URL |
| geocodingZoomTo | int | `11` | Maximum zoom level for geocoding feature |
| googleAnalyticsKey | string | `nil` | The Google Analytics key of the wui app |
| histogramsExportNbBuckets | int | `1000` | Maximum number of buckets for the histogram export |
| histogramsMaxBucket | int | `200` | Maximum number of buckets for the histogram graph |
| hitsExporterVersion | float | `2.2` | Version number of the ARLAS Hits Exporter to use |
| links | string | `" [ { \"name\":\"Hub\", \"url\":\"/hub/\", \"icon\":\"hub\", \"check_url\": \"/persist/healthcheck\" }, { \"name\": \"Import\", \"icon\": \"folder\", \"url\": \"/fam-wui/\", \"check_url\": \"/fam/healthcheck\", \"check_url_response_type\": \"text\" } ]"` | List of links to be added in the left menu of the WUI. Each link must contain `icon`, `url` and `name` attributes. |
| logger.loggingConsoleLevel | string | `"INFO"` | Default console logging level |
| logger.loggingLevel | string | `"INFO"` | Default logging level |
| nodeSelector | object | `{}` | Label-based selector, to control the nodes the pod(s) will run on. See https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#nodeselector |
| protocol | string | `"http"` |  |
| replicaCount | int | `1` | Number of desired pods |
| resources.limits.cpu | float | `0.1` |  |
| resources.limits.memory | string | `"50Mi"` |  |
| resources.requests.cpu | float | `0.05` |  |
| resources.requests.memory | string | `"10Mi"` |  |
| resultListEnableExport | bool | `false` | Whether or not to enable result list export |
| resultListExportSize | int | `1000` | Result list export size |
| services.airs.urlPrefix | string | `"/airs"` |  |
| services.aprocService.urlPrefix | string | `"/aproc"` |  |
| services.fam.urlPrefix | string | `"/fam"` |  |
| services.permissions.urlPrefix | string | `"/permissions"` |  |
| services.persistence.urlPrefix | string | `"/persist"` |  |
| services.server.urlPrefix | string | `"/arlas"` |  |
| tolerations | list | `[]` | Pod-Tolerations & Nodes-Taints work together to allow nodes to repel certain kinds of pods. See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| uis.builder.advancedFeatures | bool | `false` |  |
| uis.builder.allowExternalNodeConfiguration | bool | `true` |  |
| uis.builder.image | string | `"gisaia/arlas-wui-builder:27.0.5"` |  |
| uis.builder.serviceName | string | `"arlas-builder"` |  |
| uis.builder.tabName | string | `"ARLAS Studio"` |  |
| uis.builder.urlPrefix | string | `"/builder/"` |  |
| uis.famWui.archivePageSize | int | `10` |  |
| uis.famWui.catalog | string | `"main catalog"` |  |
| uis.famWui.collectionName | string | `"main"` |  |
| uis.famWui.famDefaultURL | string | `nil` |  |
| uis.famWui.filePageSize | int | `50` |  |
| uis.famWui.image | string | `"gisaia/arlas-fam-wui:0.6.40"` |  |
| uis.famWui.serviceName | string | `"arlas-fam-wui"` |  |
| uis.famWui.tabName | string | `"ARLAS FAM Wui"` |  |
| uis.famWui.urlPrefix | string | `"/fam-wui"` |  |
| uis.hub.image | string | `"gisaia/arlas-wui-hub:27.0.2"` |  |
| uis.hub.serviceName | string | `"arlas-hub"` |  |
| uis.hub.tabName | string | `"ARLAS Hub"` |  |
| uis.hub.urlPrefix | string | `"/hub"` |  |
| uis.servicePort | int | `8080` |  |
| uis.serviceType | string | `"ClusterIP"` |  |
| uis.wui.image | string | `"gisaia/arlas-wui:27.0.5"` |  |
| uis.wui.serviceName | string | `"arlas-wui"` |  |
| uis.wui.tabName | string | `"ARLAS Exploration"` |  |
| uis.wui.urlPrefix | string | `"/wui"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
