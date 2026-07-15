{{- define "elasticsearch.service.name" -}}
{{- printf "%s" ( include "common.names.fullname" . ) | trunc 63 | trimSuffix "-" -}}
{{- end -}}