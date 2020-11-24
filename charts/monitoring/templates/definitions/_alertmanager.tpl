{{/* vim: set filetype=mustache: */}}
{{/*
Create the name for alertmanager.
*/}}
{{- define "monitoring.alertmanager.name" -}}
{{ printf "alertmanager" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "monitoring.alertmanager.fullname" -}}
{{- $name := (include "monitoring.alertmanager.name" . ) }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create Alertmanager image url from default or user override
*/}}
{{- define "monitoring.alertmanager.image" -}}
{{ $image := .Values.alertmanager.image }}
{{- printf "%s:%s" $image.name $image.version -}}
{{- end -}}

{{/*
Alertmanager lables
*/}}
{{- define "monitoring.alertmanager.labels" -}}
{{ include "monitoring.alertmanager.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.alertmanager.image.version | quote }}
{{ include "monitoring.common.labels" . }}
{{- end -}}

{{/*
Alertmanager Selector labels
*/}}
{{- define "monitoring.alertmanager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monitoring.alertmanager.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name for che config secret to use for alertmanager
*/}}
{{- define "monitoring.alertmanager.configSecret" -}}
{{- include "monitoring.alertmanager.fullname" . -}}
{{- end -}}

{{/*
Create the name of the service account to use for alertmanager
*/}}
{{- define "monitoring.alertmanager.serviceAccountName" -}}
{{ include "monitoring.alertmanager.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "monitoring.alertmanager.roleName" -}}
{{ $name := include "monitoring.alertmanager.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}

{{/*
Create the pod affinity section for alertmanager
*/}}
{{- define "monitoring.alertmanager.podAffinity" -}}
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
    - podAffinityTerm:
        labelSelector:
          matchLabels:
            {{- include "monitoring.alertmanager.selectorLabels" . | nindent 12 }}
        {{- if semverCompare "< 1.17" .Capabilities.KubeVersion.GitVersion }}
        topologyKey: "failure-domain.beta.kubernetes.io/zone"
        {{- else }}
        topologyKey: "topology.kubernetes.io/zone"
        {{- end }}
      weight: 100
    - podAffinityTerm:
        labelSelector:
          matchLabels:
            {{- include "monitoring.alertmanager.selectorLabels" . | nindent 12 }}
        topologyKey: "kubernetes.io/hostname"
      weight: 50
{{- end -}}
