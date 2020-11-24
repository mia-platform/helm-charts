{{/* vim: set filetype=mustache: */}}
{{/*
Create a fully qualified app name for the hooks.
*/}}
{{- define "mia-monitoring.hooks.fullname" -}}
{{- printf "%s-tls-job" ( include "mia-monitoring.fullname" . ) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create hooks image url from values
*/}}
{{- define "mia-monitoring.hooks.image" -}}
{{- $image := .Values.deploy.tlsGenerator.image -}}
{{- printf "%s:%s" $image.name $image.version -}}
{{- end }}

{{/*
Hooks labels
*/}}
{{- define "mia-monitoring.hooks.labels" -}}
{{ include "mia-monitoring.hooks.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.deploy.tlsGenerator.image.version | quote }}
{{ include "mia-monitoring.common.labels" . }}
{{- end -}}

{{/*
Hooks Selector labels
*/}}
{{- define "mia-monitoring.hooks.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mia-monitoring.hooks.fullname" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for hooks
*/}}
{{- define "mia-monitoring.hooks.serviceAccountName" -}}
{{ include "mia-monitoring.hooks.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding for the hooks
*/}}
{{- define "mia-monitoring.hooks.roleName" -}}
{{ $name := include "mia-monitoring.name" . }}
{{- printf "helm:%s:%s-tls-job" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}

{{/*
Create TLS hooks arguments
*/}}
{{- define "mia-monitoring.hooks.createArgs" -}}
{{- $namespace := .Release.Namespace -}}
{{- $name := ( include "mia-monitoring.fullname" . ) -}}
- "create"
- "--host={{ $name }},{{ $name }}.{{ $namespace }}.svc"
- "--namespace={{ $namespace }}"
- "--secret-name={{ include "mia-monitoring.tlsSecretName" . }}"
{{- end -}}

{{/*
Patch Webhooks hooks arguments
*/}}
{{- define "mia-monitoring.hooks.patchArgs" -}}
- "patch"
- "--webhook-name={{ include "mia-monitoring.webhooks.fullname" . }}"
- "--namespace={{ .Release.Namespace }}"
- "--secret-name={{ include "mia-monitoring.tlsSecretName" . }}"
- "--patch-failure-policy=Fail"
{{- end -}}
