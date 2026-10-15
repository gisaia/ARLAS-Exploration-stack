{{/*
JWT provider Keycloak.
*/}}
{{- define "arlas.jwtProvider.keycloak" -}}
- name: keycloak
  remoteJWKS:
    uri: {{ .Values.global.gateway.remoteJWKSuri | quote }}
  extractFrom:
    headers:
      - name: Authorization
        valuePrefix: "bearer "
      - name: Authorization
        valuePrefix: "Bearer "
{{- end -}}