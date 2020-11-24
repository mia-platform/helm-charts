{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "monitoring.name" -}}
{{- default "prometheus-operator" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "monitoring.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create Prometheus Operator version from Chart file and override
*/}}
{{- define "monitoring.version" -}}
{{- default .Chart.AppVersion .Values.image.version -}}
{{- end -}}

{{/*
Create Prometheus Operator image url from default or user override
*/}}
{{- define "monitoring.image" -}}
{{ $version := include "monitoring.version" . }}
{{- printf "%s:%s" .Values.image.name $version -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "monitoring.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "monitoring.common.labels" -}}
app.kubernetes.io/component: "monitoring"
{{- if .Values.applicationName }}
app.kubernetes.io/part-of: {{ .Values.applicationName | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
helm.sh/chart: {{ include "monitoring.chart" . | quote }}
{{- end -}}

{{/*
Prometheus Operator lables
*/}}
{{- define "monitoring.labels" -}}
{{ include "monitoring.selectorLabels" . }}
app.kubernetes.io/version: {{ include "monitoring.version" . | quote }}
{{ include "monitoring.common.labels" . }}
{{- end -}}

{{/*
Prometheus Operator Selector labels
*/}}
{{- define "monitoring.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monitoring.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "monitoring.serviceAccountName" -}}
{{ include "monitoring.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "monitoring.roleName" -}}
{{ $name := include "monitoring.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}

{{/*
Create the name for the TLS certificate secret
*/}}
{{- define "monitoring.tlsSecretName" -}}
{{ $name := include "monitoring.fullname" . }}
{{- printf "%s-tls" $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}

{{/*
Create the name for admissions webhooks
*/}}
{{- define "monitoring.webhooks.fullname" -}}
{{ $name := include "monitoring.fullname" . }}
{{- printf "%s-webhooks" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name for api server service monitor
*/}}
{{- define "monitoring.apiServer.fullname" -}}
{{ $name := include "monitoring.fullname" . }}
{{- printf "%s-api-server" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name for cluster dns service monitor
*/}}
{{- define "monitoring.dns.fullname" -}}
{{ $name := include "monitoring.fullname" . }}
{{- printf "%s-dns-service" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
