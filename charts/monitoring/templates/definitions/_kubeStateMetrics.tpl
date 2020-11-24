{{/* vim: set filetype=mustache: */}}
{{/*
Create the name for kube state metrics.
*/}}
{{- define "mia-monitoring.kubeStateMetrics.name" -}}
{{ printf "kube-state-metrics" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mia-monitoring.kubeStateMetrics.fullname" -}}
{{- $name := (include "mia-monitoring.kubeStateMetrics.name" . ) }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create Kube State Metrics image url from default or user override
*/}}
{{- define "mia-monitoring.kubeStateMetrics.image" -}}
{{ $image := .Values.kubeStateMetrics.image }}
{{- printf "%s:%s" $image.name $image.version -}}
{{- end -}}

{{/*
Kube State Metrics lables
*/}}
{{- define "mia-monitoring.kubeStateMetrics.labels" -}}
{{ include "mia-monitoring.kubeStateMetrics.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.kubeStateMetrics.image.version | quote }}
{{ include "mia-monitoring.common.labels" . }}
{{- end -}}

{{/*
Kube State Metrics Selector labels
*/}}
{{- define "mia-monitoring.kubeStateMetrics.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mia-monitoring.kubeStateMetrics.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for Kube State Metrics
*/}}
{{- define "mia-monitoring.kubeStateMetrics.serviceAccountName" -}}
{{ include "mia-monitoring.kubeStateMetrics.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "mia-monitoring.kubeStateMetrics.roleName" -}}
{{ $name := include "mia-monitoring.kubeStateMetrics.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}
