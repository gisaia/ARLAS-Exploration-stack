{{- define "arlasWebUserInterface.labels" -}}
# app.kubernetes.io/part-of: arlas-stack
# app.kubernetes.io/managed-by: {{ .Release.Service }}
# app.kubernetes.io/instance: {{ .Release.Name }}
# app.kubernetes.io/version: {{ .Chart.AppVersion }}
# app.kubernetes.io/name: arlas-stack
{{- end }}


{{- define "arlasWebUserInterface.auth2Env" -}}
# AUTHENTICATION
- name: ARLAS_USE_AUTHENT
  value: {{ .Values.authent.useAuthent | quote }}
- name: ARLAS_AUTHENT_MODE
  value: {{ .Values.authent.authMode | quote  }}
- name: ARLAS_AUTHENT_USE_DISCOVERY
  value: {{ .Values.authent.useDiscovery  | quote }}
- name: ARLAS_AUTHENT_ISSUER
  value: {{ .Values.authent.issuer }}
- name: ARLAS_AUTHENT_CLIENT_ID
  value: {{ .Values.authent.clientId }}
- name: ARLAS_AUTHENT_SCOPE
  value: {{ .Values.authent.scope }}
# - name: ARLAS_AUTHENT_CUSTOM_QUERY_PARAMS
#     value: {{ .Values.authent.customQueryParams | toPrettyJson | quote }}
- name: ARLAS_AUTHENT_REQUIRE_HTTPS
  value: {{ .Values.authent.requireHttps | quote  }}
- name: ARLAS_AUTHENT_RESPONSE_TYPE
  value: {{ .Values.authent.responseType }}
- name: ARLAS_AUTHENT_SILENT_REFRESH_TIMEOUT
  value: {{ .Values.authent.silentRefreshTimeout | quote }}
- name: ARLAS_AUTHENT_TIMEOUT_FACTOR
  value: {{ .Values.authent.timeoutFactor | quote }}
- name: ARLAS_AUTHENT_ENABLE_SESSION_CHECKS
  value: {{ .Values.authent.sessionChecksEnabled | quote }}
- name: ARLAS_AUTHENT_CLEAR_HASH
  value: {{ .Values.authent.clearHashAfterLogin | quote }}
- name: ARLAS_AUTHENT_DISABLE_AT_HASH_CHECK
  value: {{ .Values.authent.disableAtHashCheck | quote }}
- name: ARLAS_AUTHENT_SHOW_DEBUG
  value: {{ .Values.authent.showDebugInformation | quote }}
- name: ARLAS_AUTHENT_STORAGE
  value: {{ .Values.authent.storage | quote }}
- name: ARLAS_AUTHENT_LOGOUT_URL
  value: {{ .Values.authent.logoutUrl | quote }}
{{- end }}


{{- define "arlasWebUserInterface.linksEnv" -}}
# LINKS
- name: FAM_WUI_BASE_HREF
  value: {{ .Values.uis.famWui.urlPrefix | quote }}
- name: ARLAS_BUILDER_URL
  value: {{ .Values.uis.builder.urlPrefix | quote }}
- name: ARLAS_HUB_BASE_HREF
  value: {{ .Values.uis.hub.urlPrefix | quote }}
- name: ARLAS_WUI_URL
  value: {{ .Values.uis.wui.urlPrefix | quote }}
- name: ARLAS_HUB_URL
  value: {{ .Values.uis.hub.urlPrefix | quote }}
{{- end }}


{{- define "arlasWebUserInterface.servicesEnv" -}}
# SERVICES
- name: ARLAS_SERVER_URL
  value: {{ .Values.services.server.urlPrefix }}
- name: FAM_SERVER_URL
  value: {{ .Values.services.fam.urlPrefix }}
- name: APROC_SERVER_URL
  value: {{ .Values.services.aprocService.urlPrefix }}
- name: AIRS_SERVER_URL
  value: {{ .Values.services.airs.urlPrefix }}
- name: ARLAS_PERSISTENCE_URL
  value: {{ .Values.services.persistence.urlPrefix }}
- name: ARLAS_PERMISSIONS_URL
  value: {{ .Values.services.permissions.urlPrefix }}
- name: ARLAS_GEOCODING_FIND_PLACE_URL
  value: {{ .Values.geocodingUrl }}
{{- end }}


{{- define "arlasWebUserInterface.actionsEnv" -}}
# -- Relative AIAS download execution URL
- name: ARLAS_DOWNLOAD_PROCESS_URL
  value: /aproc/processes/download/execution
# -- Relative AIAS download URL
- name: ARLAS_DOWNLOAD_PROCESS_CHECK_URL
  value: /aproc/processes/download
# -- AIAS download max number of items
- name: ARLAS_DOWNLOAD_PROCESS_MAX_ITEMS
  value: "100"
# -- AIAS download configuration file location
- name: ARLAS_DOWNLOAD_PROCESS_SETTINGS_URL
  value: assets/processes/download.json
# -- AIAS download status relative url
- name: ARLAS_DOWNLOAD_PROCESS_STATUS_URL
  value: /aproc/jobs
# -- Relative AIAS enrich execution URL
- name: ARLAS_ENRICH_PROCESS_URL
  value: /aproc/processes/enrich/execution
# -- Relative AIAS enrich URL
- name: ARLAS_ENRICH_PROCESS_CHECK_URL
  value: /aproc/processes/enrich
# -- AIAS enrich max number of items
- name: ARLAS_ENRICH_PROCESS_MAX_ITEMS
  value: "100"
# -- AIAS enrich configuration file location
- name: ARLAS_ENRICH_PROCESS_SETTINGS_URL
  value: assets/processes/enrich.json
# -- AIAS enrich status relative url
- name: ARLAS_ENRICH_PROCESS_STATUS_URL
  value: /aproc/jobs
{{- end }}
