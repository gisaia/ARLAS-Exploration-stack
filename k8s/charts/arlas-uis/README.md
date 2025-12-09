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
| defaultStorageClass | string | `"standard"` |  |
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
| uis.builder.extraEnvVars | string | `nil` | Extra environment variables for the arlas builder container |
| uis.builder.image | string | `"gisaia/arlas-wui-builder:27.1.2"` |  |
| uis.builder.serviceName | string | `"arlas-builder"` |  |
| uis.builder.tabName | string | `"ARLAS Studio"` |  |
| uis.builder.urlPrefix | string | `"/builder/"` |  |
| uis.colors.arlas.bg | string | `"#ff4081"` |  |
| uis.colors.handle.color | string | `"#ff4081"` |  |
| uis.famWui.archivePageSize | int | `10` |  |
| uis.famWui.catalog | string | `"main catalog"` |  |
| uis.famWui.collectionName | string | `"main"` |  |
| uis.famWui.extraEnvVars | string | `nil` | Extra environment variables for the arlas fam wui container |
| uis.famWui.famDefaultURL | string | `nil` |  |
| uis.famWui.filePageSize | int | `50` |  |
| uis.famWui.image | string | `"gisaia/arlas-fam-wui:0.9.4"` |  |
| uis.famWui.serviceName | string | `"arlas-fam-wui"` |  |
| uis.famWui.tabName | string | `"ARLAS FAM Wui"` |  |
| uis.famWui.urlPrefix | string | `"/fam-wui"` |  |
| uis.hub.extraEnvVars | string | `nil` | Extra environment variables for the arlas hub container |
| uis.hub.image | string | `"gisaia/arlas-wui-hub:27.1.2"` |  |
| uis.hub.serviceName | string | `"arlas-hub"` |  |
| uis.hub.tabName | string | `"ARLAS Hub"` |  |
| uis.hub.urlPrefix | string | `"/hub"` |  |
| uis.logoImagePng60x60Base64 | string | `"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"` |  |
| uis.logoInnerPngBase64 | string | `nil` |  |
| uis.noViewPngBase64 | string | `nil` |  |
| uis.servicePort | int | `8080` |  |
| uis.serviceType | string | `"ClusterIP"` |  |
| uis.spinnerGifBase64 | string | `nil` |  |
| uis.wui.basemapUrl | string | `nil` |  |
| uis.wui.extraEnvVars | string | `nil` | Extra environment variables for the arlas wui container |
| uis.wui.image | string | `"gisaia/arlas-wui:27.1.3"` |  |
| uis.wui.serviceName | string | `"arlas-wui"` |  |
| uis.wui.tabName | string | `"ARLAS Exploration"` |  |
| uis.wui.urlPrefix | string | `"/wui"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
