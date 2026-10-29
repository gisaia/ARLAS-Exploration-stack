{{- define "aiasServices.otel" -}}
- name: FASTAPI_OTEL_AUTO_CONFIGURE
  value: "true"
# OTEL CONFIGURATION
- name: OTEL_EXPORTER_OTLP_ENDPOINT
  value: {{ .Values.otel.endpoint | quote }}
- name: OTEL_EXPORTER_OTLP_PROTOCOL
  value: {{ .Values.otel.protocol | quote }}
- name: OTEL_RESOURCE_ATTRIBUTES
  value: {{ tpl .Values.otel.attributes . | quote }}
- name: OTEL_INSTRUMENTATION_HTTP_SERVER_REQUEST_IGNORED_USERAGENTS
  value: {{ .Values.otel.ignoredUserAgents | quote }}
{{- if .Values.otel.auth.enabled }}
- name: OTEL_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ .Values.otel.auth.secretName }}
      key: {{ .Values.otel.auth.secretKey }}
- name: OTEL_EXPORTER_OTLP_HEADERS
  value: "Authorization=Bearer $(OTEL_TOKEN)"
{{- end }}
{{- range $k, $v := .Values.otel.extraEnv }}
- name: {{ $k }}
  value: {{ $v | quote }}
{{- end }}
{{- end }}

{{- define "aproc.encrypt" -}}
- name: APROC_TASK_ENCRYPTION_KEYS
  valueFrom:
    secretKeyRef:
      name: {{ .Values.services.aproc.encryptExistingSecret }}
      key: {{ .Values.services.aproc.encryptExistingKey }}
{{- end }}
