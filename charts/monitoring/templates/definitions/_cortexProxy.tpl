{{/* vim: set filetype=mustache: */}}

{{- define "mia-monitoring.cortexProxy.image" -}}
{{ $image := .Values.cortexProxy.image }}
{{- printf "%s:%s" $image.name $image.version -}}
{{- end -}}
