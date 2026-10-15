
{{/*
Returns (in JSON) the map of instances merged with the defaults.
Usage: {{ range $key, $inst := (include "elastic.instances" . | fromJson) }}
*/}}
{{- define "elastic.instances" -}}
{{- $out := dict -}}
{{- range $key, $inst := .Values.elastic.instances -}}
  {{- $_ := set $out $key (mergeOverwrite (deepCopy $.Values.elastic.defaults) (deepCopy $inst)) -}}
{{- end -}}
{{- toJson $out -}}
{{- end -}}