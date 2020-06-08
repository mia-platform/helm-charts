{{/* vim: set filetype=mustache: */}}
{{/*
Fluentd name
*/}}
{{- define "logging.loggingFluentdName" -}}
{{ printf "%s-fluentd" (include "logging.fullname" .) }}
{{- end -}}

{{/*
Logging secret tls data
*/}}
{{- define "logging.loggingSecretData" -}}
{{- $ca := genCA "svc-cat-ca" 3650 -}}
{{- $cn := printf "%s.%s.svc.cluster.local" (include "logging.loggingFluentdName" .) .Release.Namespace -}}
{{- $server := genSignedCert $cn nil nil 365 $ca -}}
{{- $client := genSignedCert "" nil nil 365 $ca -}}
ca.crt: {{ b64enc $ca.Cert | quote }}
tls.crt: {{ b64enc $server.Cert | quote }}
tls.key: {{ b64enc $server.Key | quote }}
{{- end -}}

{{/*
Default stack status for NOTES
*/}}
{{- define "logging.defautLoggingStatus" -}}
{{- if .Values.defaultLogging.enabled -}}
{{- printf "enabled" -}}
{{- else -}}
{{- printf "disabled" -}}
{{- end -}}
{{- end -}}

{{/*
Fluentbit user id config
*/}}
{{- define "logging.fluentbitUserId" -}}
{{- if .Values.defaultLogging.fluentbit.runAsRoot -}}
runAsNonRoot: false
runAsUser: 0
{{- else -}}
runAsNonRoot: true
runAsUser: 10000
{{- end -}}
{{- end -}}

{{/*
Fluentbit custom image
*/}}
{{- define "logging.fluentbitImageName" -}}
{{- $image := .Values.defaultLogging.fluentbit.image -}}
{{- if $image -}}
{{- default "" $image.name -}}
{{- end -}}
{{- end -}}

{{- define "logging.fluentbitImageVersion" -}}
{{- $image := .Values.defaultLogging.fluentbit.image -}}
{{- if $image -}}
{{- default "" $image.version -}}
{{- end -}}
{{- end -}}

{{/*xw
Fluentd custom image
*/}}
{{- define "logging.fluentdImageName" -}}
{{- $image := .Values.defaultLogging.fluentd.image -}}
{{- if $image -}}
{{- default "" $image.name -}}
{{- end -}}
{{- end -}}

{{- define "logging.fluentdImageVersion" -}}
{{- $image := .Values.defaultLogging.fluentd.image -}}
{{- if $image -}}
{{- default "" $image.version -}}
{{- end -}}
{{- end -}}
