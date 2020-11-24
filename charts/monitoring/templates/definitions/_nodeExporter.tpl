{{/* vim: set filetype=mustache: */}}
{{/*
Create the name for node exporter.
*/}}
{{- define "monitoring.nodeExporter.name" -}}
{{ printf "node-exporter" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "monitoring.nodeExporter.fullname" -}}
{{- $name := (include "monitoring.nodeExporter.name" . ) }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create Node Exporter image url from default or user override
*/}}
{{- define "monitoring.nodeExporter.image" -}}
{{ $image := .Values.nodeExporter.image }}
{{- printf "%s:%s" $image.name $image.version -}}
{{- end -}}

{{/*
Node Exporter lables
*/}}
{{- define "monitoring.nodeExporter.labels" -}}
{{ include "monitoring.nodeExporter.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.nodeExporter.image.version | quote }}
{{ include "monitoring.common.labels" . }}
{{- end -}}

{{/*
Node Exporter Selector labels
*/}}
{{- define "monitoring.nodeExporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monitoring.nodeExporter.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for node exporter
*/}}
{{- define "monitoring.nodeExporter.serviceAccountName" -}}
{{ include "monitoring.nodeExporter.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "monitoring.nodeExporter.roleName" -}}
{{ $name := include "monitoring.nodeExporter.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}
