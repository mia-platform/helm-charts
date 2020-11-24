{{/* vim: set filetype=mustache: */}}
{{/*
Create the name for node exporter.
*/}}
{{- define "mia-monitoring.nodeExporter.name" -}}
{{ printf "node-exporter" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mia-monitoring.nodeExporter.fullname" -}}
{{- $name := (include "mia-monitoring.nodeExporter.name" . ) }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create Node Exporter image url from default or user override
*/}}
{{- define "mia-monitoring.nodeExporter.image" -}}
{{ $image := .Values.nodeExporter.image }}
{{- printf "%s:%s" $image.name $image.version -}}
{{- end -}}

{{/*
Node Exporter lables
*/}}
{{- define "mia-monitoring.nodeExporter.labels" -}}
{{ include "mia-monitoring.nodeExporter.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.nodeExporter.image.version | quote }}
{{ include "mia-monitoring.common.labels" . }}
{{- end -}}

{{/*
Node Exporter Selector labels
*/}}
{{- define "mia-monitoring.nodeExporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mia-monitoring.nodeExporter.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for node exporter
*/}}
{{- define "mia-monitoring.nodeExporter.serviceAccountName" -}}
{{ include "mia-monitoring.nodeExporter.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "mia-monitoring.nodeExporter.roleName" -}}
{{ $name := include "mia-monitoring.nodeExporter.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}
