{{/* vim: set filetype=mustache: */}}
{{/*
Create a fully qualified app name for the hooks.
*/}}
{{- define "monitoring.hooks.fullname" -}}
{{- printf "%s-tls-job" ( include "monitoring.fullname" . ) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create hooks image url from values
*/}}
{{- define "monitoring.hooks.image" -}}
{{- $image := .Values.deploy.tlsGenerator.image -}}
{{- printf "%s:%s" $image.name $image.version -}}
{{- end }}

{{/*
Hooks labels
*/}}
{{- define "monitoring.hooks.labels" -}}
{{ include "monitoring.hooks.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.deploy.tlsGenerator.image.version | quote }}
{{ include "monitoring.common.labels" . }}
{{- end -}}

{{/*
Hooks Selector labels
*/}}
{{- define "monitoring.hooks.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monitoring.hooks.fullname" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for hooks
*/}}
{{- define "monitoring.hooks.serviceAccountName" -}}
{{ include "monitoring.hooks.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding for the hooks
*/}}
{{- define "monitoring.hooks.roleName" -}}
{{ $name := include "monitoring.name" . }}
{{- printf "helm:%s:%s-tls-job" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}

{{/*
Create TLS hooks arguments
*/}}
{{- define "monitoring.hooks.createArgs" -}}
{{- $namespace := .Release.Namespace -}}
{{- $name := ( include "monitoring.fullname" . ) -}}
- "create"
- "--host={{ $name }},{{ $name }}.{{ $namespace }}.svc"
- "--namespace={{ $namespace }}"
- "--secret-name={{ include "monitoring.tlsSecretName" . }}"
{{- end -}}

{{/*
Patch Webhooks hooks arguments
*/}}
{{- define "monitoring.hooks.patchArgs" -}}
- "patch"
- "--webhook-name={{ include "monitoring.webhooks.fullname" . }}"
- "--namespace={{ .Release.Namespace }}"
- "--secret-name={{ include "monitoring.tlsSecretName" . }}"
- "--patch-failure-policy=Fail"
{{- end -}}
