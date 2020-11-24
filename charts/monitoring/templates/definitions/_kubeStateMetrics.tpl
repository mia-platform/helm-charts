{{/* vim: set filetype=mustache: */}}
{{/*
Create the name for kube state metrics.
*/}}
{{- define "monitoring.kubeStateMetrics.name" -}}
{{ printf "kube-state-metrics" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "monitoring.kubeStateMetrics.fullname" -}}
{{- $name := (include "monitoring.kubeStateMetrics.name" . ) }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create Kube State Metrics image url from default or user override
*/}}
{{- define "monitoring.kubeStateMetrics.image" -}}
{{ $image := .Values.kubeStateMetrics.image }}
{{- printf "%s:%s" $image.name $image.version -}}
{{- end -}}

{{/*
Kube State Metrics lables
*/}}
{{- define "monitoring.kubeStateMetrics.labels" -}}
{{ include "monitoring.kubeStateMetrics.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.kubeStateMetrics.image.version | quote }}
{{ include "monitoring.common.labels" . }}
{{- end -}}

{{/*
Kube State Metrics Selector labels
*/}}
{{- define "monitoring.kubeStateMetrics.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monitoring.kubeStateMetrics.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for Kube State Metrics
*/}}
{{- define "monitoring.kubeStateMetrics.serviceAccountName" -}}
{{ include "monitoring.kubeStateMetrics.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "monitoring.kubeStateMetrics.roleName" -}}
{{ $name := include "monitoring.kubeStateMetrics.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}
