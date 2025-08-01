{{- define "aias.aprocEnv" -}}
- name: APROC_CONFIGURATION_FILE
  value: /app/conf/aproc.yaml
- name: CELERY_BROKER_URL
  value: pyamqp://{{ .Values.rabbitmq.login }}:{{ .Values.rabbitmq.password }}@{{ .Release.Name }}-{{ .Values.rabbitmq.host }}:{{ .Values.rabbitmq.port }}//
- name: CELERY_RESULT_BACKEND
  value: "redis://default:secretpassword@aias-redis-master:6379/0"
#                 value: redis://secretpassword@{{ .Release.Name }}-{{ .Values.redis.host }}:{{ .Values.redis.port }}/0
- name: AIRS_ENDPOINT
  value: http://airs-server:{{ .Values.services.servicePort }}/{{ .Values.services.airs.urlPrefix }}
- name: APROC_ENDPOINT_FROM_APROC
  value: http://aproc-service:{{ .Values.services.servicePort }}/{{ .Values.services.aproc.service.urlPrefix }}
- name: ARLAS_URL_SEARCH
  value: {{ .Values.arlasSearchUrl | quote }}
- name: APROC_INDEX_NAME
  value: {{ .Values.download.downloadReportIndex  | quote }}
- name: APROC_INDEX_ENDPOINT_URL
  value: https://{{ .Release.Name }}-elasticsearch:9200
- name: APROC_INDEX_LOGIN
  value: {{ .Values.elastic.login  | quote }}
- name: APROC_INDEX_PWD
  value: {{ .Values.elastic.password  | quote }}
- name: APROC_RESOURCE_ID_HASH_STARTS_AT
  value: {{ .Values.resourceIdHashStartAt  | quote }}
- name: TMP_FOLDER
  value: {{ .Values.download.tmpFolder  | quote }}
- name: DOWNLOAD_S3_ENDPOINT_URL
  value: {{ .Values.download.s3.endpoint  | quote }}
- name: DOWNLOAD_S3_BUCKET
  value: {{ .Values.download.s3.bucket  | quote }}
- name: DOWNLOAD_S3_ACCESS_KEY_ID
  value: {{ .Values.download.s3.key  | quote }}
- name: DOWNLOAD_S3_SECRET_ACCESS_KEY
  value: {{ .Values.download.s3.secret  | quote }}
- name: DOWNLOAD_S3_ASSET_HTTP_ENDPOINT_URL
  value: {{ .Values.download.s3.http  | quote }}
- name: CLEAN_DOWNLOAD_OUTBOX_DIR
  value: {{ .Values.download.cleanAfterUpload  | quote }}
- name: INGESTED_FOLDER
  value: {{ .Values.ingest.folder  | quote }}
- name: APROC_INPUT_STORAGE_TYPE
  value: {{ .Values.ingest.storage.type  | quote }}
- name: APROC_INPUT_STORAGE_BUCKET
  value: {{ .Values.ingest.storage.s3.bucket  | quote }}
- name: APROC_INPUT_STORAGE_FORCE_DOWNLOAD
  value: {{ .Values.ingest.storage.forceDownload  | quote }}
- name: APROC_TASK_TIME_LIMIT
  value: {{ .Values.timeLimit  | quote }}
- name: APROC_TASK_SOFT_TIME_LIMIT
  value: {{ .Values.softTimeLimit  | quote }}

- name: AIRS_COLLECTION_URL
  value: https://raw.githubusercontent.com/gisaia/ARLAS-EO/v0.0.6/collection.json

# INDEX CONFIGURATION
- name: AIRS_INDEX_COLLECTION_PREFIX
  value: "{{ .Values.organization }}@{{ .Values.airsIndexPrefix }}"

# INDEX MAPPING
- name: ARLASEO_MAPPING_URL
  value: {{ .Values.arlasMappingUrl | quote }}

# EMAIL CONFIGURATION
- name: ARLAS_SMTP_ACTIVATED
  value: {{ .Values.smtp.enabled | default "False" | quote  }}
- name: ARLAS_SMTP_HOST
  value: {{ .Values.smtp.host | quote }}
- name: ARLAS_SMTP_PORT
  value: {{ .Values.smtp.port | quote }}
- name: ARLAS_SMTP_USERNAME
  value: {{ .Values.smtp.username | quote }}
- name: ARLAS_SMTP_PASSWORD
  value: {{ .Values.smtp.password | quote }}
- name: ARLAS_SMTP_FROM
  value: {{ .Values.smtp.from | quote }}
- name: APROC_DOWNLOAD_CONTENT_USER
  value: {{ .Values.download.message.done.user.content | quote }}
- name: APROC_DOWNLOAD_SUBJECT_USER
  value: {{ .Values.download.message.done.user.subject | quote }}
- name: APROC_DOWNLOAD_CONTENT_ERROR
  value: {{ .Values.download.message.error.content | quote }}
- name: APROC_DOWNLOAD_SUBJECT_ERROR
  value: {{ .Values.download.message.error.subject | quote }}
- name: APROC_DOWNLOAD_ADMIN_EMAILS
  value:  {{ .Values.download.message.admin.emails | quote }}
- name: APROC_DOWNLOAD_CONTENT_ADMIN
  value: {{ .Values.download.message.done.admin.content | quote }}
- name: APROC_DOWNLOAD_SUBJECT_ADMIN
  value: {{ .Values.download.message.done.admin.subject | quote }}
- name: APROC_DOWNLOAD_REQUEST_SUBJECT_USER
  value: {{ .Values.download.message.request.user.subject | quote }}
- name: APROC_DOWNLOAD_REQUEST_CONTENT_USER
  value: {{ .Values.download.message.request.user.content | quote }}
- name: APROC_DOWNLOAD_REQUEST_SUBJECT_ADMIN
  value: {{ .Values.download.message.request.admin.subject | quote }}
- name: APROC_DOWNLOAD_REQUEST_CONTENT_ADMIN
  value: {{ .Values.download.message.request.admin.content | quote }}
- name: APROC_EMAIL_PATH_PREFIX_ADD
  value: {{ .Values.download.message.path.prefix | quote }}
- name: APROC_PATH_TO_WINDOWS
  value: {{ .Values.download.message.path.windows| default "False" | quote }}
{{- end }}
