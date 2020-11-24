{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "mia-logging.name" -}}
{{- default "logging-operator" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mia-logging.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "logging-operator" .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create Logging Operator version from Chart file and override
*/}}
{{- define "mia-logging.version" -}}
{{- default .Chart.AppVersion .Values.image.version -}}
{{- end -}}

{{/*
Create Logging Operator image url from default or user override
*/}}
{{- define "mia-logging.image" -}}
{{ $version := include "mia-logging.version" . }}
{{- printf "%s:%s" .Values.image.name $version -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mia-logging.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mia-logging.labels" -}}
helm.sh/chart: {{ include "mia-logging.chart" . | quote }}
{{ include "mia-logging.selectorLabels" . }}
app.kubernetes.io/version: {{ include "mia-logging.version" . | quote }}
app.kubernetes.io/component: "logging"
{{- if .Values.applicationName }}
app.kubernetes.io/part-of: {{ .Values.applicationName | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "mia-logging.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mia-logging.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "mia-logging.serviceAccountName" -}}
{{ include "mia-logging.fullname" . }}
{{- end -}}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "mia-logging.roleName" -}}
{{ $name := include "mia-logging.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}
