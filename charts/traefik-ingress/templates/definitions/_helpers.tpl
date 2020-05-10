{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "traefik-ingress.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "traefik-ingress.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified internal service name.
We start from the default fully qulified app name, truncate some more and add -dashboard to it
*/}}
{{- define "traefik-ingress.internalServiceName" -}}
{{- $name:= include "traefik-ingress.fullname" . | trunc 53 | trimSuffix "-" -}}
{{- printf "%s-dashboard" $name -}}
{{- end -}}

{{/*
Create a default fully qualified treafik dashboard ingressroute name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "traefik-ingress.dashboardIngressRouteName" -}}
{{- printf "%s-traefik-dashboard" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified treafik default tlsoption name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "traefik-ingress.defaultTLSOptionName" -}}
{{- printf "%s-%s-tls" .Release.Name .Values.tlsOption | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified treafik http to https redirection ingressroute name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "traefik-ingress.redirectIngressRouteName" -}}
{{- printf "%s-https-redirect" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create Traefik version from Chart file and override
*/}}
{{- define "traefik-ingress.version" -}}
{{- default .Chart.AppVersion .Values.image.version -}}
{{- end -}}

{{/*
Create Traefik image url from default or user override
*/}}
{{- define "traefik-ingress.image" -}}
{{ $version := include "traefik-ingress.version" . }}
{{- printf "%s:%s" .Values.image.name $version -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "traefik-ingress.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "traefik-ingress.labels" -}}
helm.sh/chart: {{ include "traefik-ingress.chart" . | quote }}
{{ include "traefik-ingress.selectorLabels" . }}
app.kubernetes.io/version: {{ include "traefik-ingress.version" . | quote }}
app.kubernetes.io/component: "ingress"
{{- if .Values.applicationName }}
app.kubernetes.io/part-of: {{ .Values.applicationName | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "traefik-ingress.selectorLabels" -}}
app.kubernetes.io/name: {{ include "traefik-ingress.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Traefik ingress class
*/}}
{{- define "traefik-ingress.crdLabelSelector" -}}
{{- printf "app.kubernetes.io/instance=%s" .Release.Name -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "traefik-ingress.serviceAccountName" -}}
{{ include "traefik-ingress.fullname" . }}
{{- end -}}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "traefik-ingress.roleName" -}}
{{ $name := include "traefik-ingress.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}

{{/*
Kubernetes topology zone label based on kubernetes version
*/}}
{{- define "traefik-ingress.topologyZoneLabel" -}}
{{- if semverCompare "< 1.17" .Capabilities.KubeVersion.GitVersion -}}
failure-domain.beta.kubernetes.io/zone
{{- else -}}
topology.kubernetes.io/zone
{{- end -}}
{{- end -}}
