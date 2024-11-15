{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "mia-monitoring.name" -}}
{{- default "prometheus-operator" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mia-monitoring.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "prometheus-operator" .Values.nameOverride }}
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
{{- define "mia-monitoring.version" -}}
{{- default .Chart.AppVersion .Values.image.version -}}
{{- end -}}

{{/*
Create Prometheus Operator image url from default or user override
*/}}
{{- define "mia-monitoring.image" -}}
{{ $version := include "mia-monitoring.version" . }}
{{- printf "%s:%s" .Values.image.name $version -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mia-monitoring.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mia-monitoring.common.labels" -}}
app.kubernetes.io/component: "monitoring"
{{- if .Values.applicationName }}
app.kubernetes.io/part-of: {{ .Values.applicationName | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
helm.sh/chart: {{ include "mia-monitoring.chart" . | quote }}
{{- end -}}

{{/*
Prometheus Operator lables
*/}}
{{- define "mia-monitoring.labels" -}}
{{ include "mia-monitoring.selectorLabels" . }}
app.kubernetes.io/version: {{ include "mia-monitoring.version" . | quote }}
{{ include "mia-monitoring.common.labels" . }}
{{- end -}}

{{/*
Prometheus Operator Selector labels
*/}}
{{- define "mia-monitoring.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mia-monitoring.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mia-monitoring.serviceAccountName" -}}
{{ include "mia-monitoring.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "mia-monitoring.roleName" -}}
{{ $name := include "mia-monitoring.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}

{{/*
Create the name for the TLS certificate secret
*/}}
{{- define "mia-monitoring.tlsSecretName" -}}
{{ $name := include "mia-monitoring.fullname" . }}
{{- printf "%s-tls" $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}

{{/*
Create the name for admissions webhooks
*/}}
{{- define "mia-monitoring.webhooks.fullname" -}}
{{ $name := include "mia-monitoring.fullname" . }}
{{- printf "%s-webhooks" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name for api server service monitor
*/}}
{{- define "mia-monitoring.apiServer.fullname" -}}
{{ $name := include "mia-monitoring.fullname" . }}
{{- printf "%s-api-server" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name for cluster dns service monitor
*/}}
{{- define "mia-monitoring.dns.fullname" -}}
{{ $name := include "mia-monitoring.fullname" . }}
{{- printf "%s-dns-service" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name for cluster kubelet service monitor
*/}}
{{- define "mia-monitoring.kubelet.fullname" -}}
{{ $name := include "mia-monitoring.fullname" . }}
{{- printf "%s-kubelet" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
