{{/* vim: set filetype=mustache: */}}
{{/*
Fluentd name
*/}}
{{- define "logging.loggingFluentdName" -}}
{{ printf "%s-fluentd" (include "logging.fullname" .) }}
{{- end -}}

{{/*
Fluentbit name
*/}}
{{- define "logging.loggingFluentbitName" -}}
{{ printf "%s-fluentbit" (include "logging.fullname" .) }}
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

{{/*
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

{{/*
Fluentd TLS secret name
*/}}
{{- define "logging.loggingFluentdSecretName" -}}
{{ printf "%s-secret" (include "logging.loggingFluentdName" .) }}
{{- end -}}

{{/*
Fluentbit TLS secret name
*/}}
{{- define "logging.loggingFluentbitSecretName" -}}
{{ printf "%s-secret" (include "logging.loggingFluentbitName" .) }}
{{- end -}}
