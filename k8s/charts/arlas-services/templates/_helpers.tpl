{{- define "arlasServices.labels" -}}
# app.kubernetes.io/part-of: arlas-stack
# app.kubernetes.io/managed-by: {{ .Release.Service }}
# app.kubernetes.io/instance: {{ .Release.Name }}
# app.kubernetes.io/version: {{ .Chart.AppVersion }}
# app.kubernetes.io/name: arlas-stack
{{- end }}


{{- define "arlasServices.loggingEnv" -}}
# LOGGING
- name: ARLAS_LOGGING_LEVEL
  value: {{ .Values.logger.loggingLevel }}
- name: ARLAS_LOGGING_CONSOLE_LEVEL
  value: {{ .Values.logger.loggingConsoleLevel }}
- name: ARLAS_LOGGING_FILE_LEVEL
  value: "OFF"
- name: ARLAS_LOGGING_FILE
  value: {{ .Values.logger.loggingFile | quote }}
{{- end }}

{{- define "arlasServices.cacheEnv" -}}
# CACHE CONFIG
- name: ARLAS_CACHE_TIMEOUT
  value: {{ .Values.cacheTimeout | quote }}
- name: ARLAS_CACHE_FACTORY_CLASS
  value: {{ .Values.cacheFactoryClass | quote }}
{{- end }}


{{- define "arlasServices.elasticEnv" -}}
# ELASTICSEARCH CONFIGURATION
- name: ARLAS_ELASTIC_INDEX
  value: .arlas
- name: ARLAS_ELASTIC_CLUSTER
  value: {{ .Values.elastic.cluster| quote }}
- name: ARLAS_ELASTIC_NODES
  value: {{ .Values.elastic.nodes| quote  }}
- name: ARLAS_ELASTIC_CREDENTIALS
  value: "{{ .Values.elastic.login}}:{{ .Values.elastic.password}}"
- name: ARLAS_ELASTIC_SKIP_MASTER
  value: {{ .Values.elastic.skipMaster | quote }}
- name: ARLAS_ELASTIC_SNIFFING
  value: {{ .Values.elastic.sniffing | quote }}
- name: ARLAS_ELASTIC_ENABLE_SSL
  value: {{ .Values.elastic.ssl.enabled | quote }}
{{- end }}

{{- define "arlasServices.keycloakEnv" -}}
{{- if .Values.keycloak.enabled }}
  # -- ARLAS Policy Enforcer
  # -- Policy Enforcer class to use among `io.arlas.filter.impl.NoPolicyEnforcer`, `io.arlas.filter.impl.HTTPPolicyEnforcer`, `io.arlas.filter.impl.KeycloakPolicyEnforcer`
- name: ARLAS_AUTH_POLICY_CLASS
  value: io.arlas.filter.impl.KeycloakPolicyEnforcer
#  value: io.arlas.filter.impl.HTTPPolicyEnforcer
#  value: io.arlas.filter.impl.NoPolicyEnforcer
- name: ARLAS_AUTH_KEYCLOAK_REALM
  value: {{ .Values.keycloak.realm | quote }}
- name: ARLAS_AUTH_KEYCLOAK_RESOURCE
  value: {{ .Values.keycloak.client | quote }}
- name: ARLAS_AUTH_KEYCLOAK_SECRET
  value: {{ .Values.keycloak.secret | quote }}
- name: ARLAS_AUTH_KEYCLOAK_URL
  value: {{ .Values.keycloak.url | quote }}
- name: ARLAS_CHECK_ORGANISATIONS
  value: "false"
{{- end }}
{{- end }}  

{{- define "arlasServices.corsEnv" -}}
- name: ARLAS_CORS_ENABLED
  value: {{ .Values.cors.enabled | quote }}
- name: ARLAS_CORS_ALLOWED_ORIGINS
  value: {{ .Values.cors.allowedOrigins | squote }}
- name: ARLAS_CORS_ALLOWED_HEADERS
  value: {{ .Values.cors.allowedHeaders | quote }}
- name: ARLAS_CORS_ALLOWED_METHODS
  value: {{ .Values.cors.allowedMethods | quote }}
- name: ARLAS_CORS_ALLOWED_CREDENTIALS
  value: {{ .Values.cors.allowedCredentials | quote }}
- name: ARLAS_CORS_EXPOSED_HEADERS
  value: {{ .Values.cors.exposedHeaders | quote }}
{{- end }}


{{- define "arlasServices.mountCertificate" -}}
{{- if .Values.services.mountCertificate }}
            - name: keycloak-certificate-configmap
              mountPath: /opt/app/store/
              readOnly: true
{{- end }}
{{- end }}

{{- define "arlasServices.volumeCertificate" -}}
{{- if .Values.services.mountCertificate }}
        - name: keycloak-certificate-configmap
          configMap:
            name: keycloak-certificate-configmap
{{- end }}
{{- end }}
