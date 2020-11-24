{{/* vim: set filetype=mustache: */}}
{{/*
Fluentd name
*/}}
{{- define "mia-logging.loggingFluentdName" -}}
{{ printf "%s-fluentd" (include "mia-logging.fullname" .) }}
{{- end -}}

{{/*
Fluentbit name
*/}}
{{- define "mia-logging.loggingFluentbitName" -}}
{{ printf "%s-fluentbit" (include "mia-logging.fullname" .) }}
{{- end -}}

{{/*
Default stack status for NOTES
*/}}
{{- define "mia-logging.defautLoggingStatus" -}}
{{- if .Values.defaultLogging.enabled -}}
{{- printf "enabled" -}}
{{- else -}}
{{- printf "disabled" -}}
{{- end -}}
{{- end -}}

{{/*
Fluentbit user id config
*/}}
{{- define "mia-logging.fluentbitUserId" -}}
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
{{- define "mia-logging.fluentbitImageName" -}}
{{- $image := .Values.defaultLogging.fluentbit.image -}}
{{- if $image -}}
{{- default "" $image.name -}}
{{- end -}}
{{- end -}}

{{- define "mia-logging.fluentbitImageVersion" -}}
{{- $image := .Values.defaultLogging.fluentbit.image -}}
{{- if $image -}}
{{- default "" $image.version -}}
{{- end -}}
{{- end -}}

{{/*
Fluentd custom image
*/}}
{{- define "mia-logging.fluentdImageName" -}}
{{- $image := .Values.defaultLogging.fluentd.image -}}
{{- if $image -}}
{{- default "" $image.name -}}
{{- end -}}
{{- end -}}

{{- define "mia-logging.fluentdImageVersion" -}}
{{- $image := .Values.defaultLogging.fluentd.image -}}
{{- if $image -}}
{{- default "" $image.version -}}
{{- end -}}
{{- end -}}

{{/*
Fluentd TLS secret name
*/}}
{{- define "mia-logging.loggingFluentdSecretName" -}}
{{ printf "%s-secret" (include "mia-logging.loggingFluentdName" .) }}
{{- end -}}

{{/*
Fluentbit TLS secret name
*/}}
{{- define "mia-logging.loggingFluentbitSecretName" -}}
{{ printf "%s-secret" (include "mia-logging.loggingFluentbitName" .) }}
{{- end -}}
