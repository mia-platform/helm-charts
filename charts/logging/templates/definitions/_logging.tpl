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

{{- define "mia-logging.fluentdReplicas" -}}
{{- default 0 .Values.defaultLogging.fluentd.replicas -}}
{{- end -}}

{{- define "mia-logging.fluentbitEnableUpstream" -}}
{{- if gt (int ( include "mia-logging.fluentdReplicas" . )) 1 -}}
{{- print true -}}
{{- else -}}
{{- print false -}}
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
