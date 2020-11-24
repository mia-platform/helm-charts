{{/* vim: set filetype=mustache: */}}
{{/*
Create the name for prometheus.
*/}}
{{- define "monitoring.prometheus.name" -}}
{{ printf "prometheus" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "monitoring.prometheus.fullname" -}}
{{- $name := (include "monitoring.prometheus.name" . ) }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create Prometheus image url from default or user override
*/}}
{{- define "monitoring.prometheus.image" -}}
{{ $image := .Values.prometheus.image }}
{{- printf "%s:%s" $image.name $image.version -}}
{{- end -}}

{{/*
Prometheus lables
*/}}
{{- define "monitoring.prometheus.labels" -}}
{{ include "monitoring.prometheus.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.prometheus.image.version | quote }}
{{ include "monitoring.common.labels" . }}
{{- end -}}

{{/*
Prometheus Selector labels
*/}}
{{- define "monitoring.prometheus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monitoring.prometheus.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for Prometheus
*/}}
{{- define "monitoring.prometheus.serviceAccountName" -}}
{{ include "monitoring.prometheus.fullname" . }}
{{- end }}

{{/*
Create the name for the cluster role and its binding
*/}}
{{- define "monitoring.prometheus.roleName" -}}
{{ $name := include "monitoring.prometheus.name" . }}
{{- printf "helm:%s:%s" .Release.Name $name | trunc 63 | trimSuffix ":" -}}
{{- end -}}


{{/*
Create the name for the additional scraping config secret
*/}}
{{- define "monitoring.prometheus.scrapeConfigSecret" -}}
{{ $name := include "monitoring.prometheus.fullname" . }}
{{- printf "%s-scrape" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "monitoring.prometheus.scrapeConfigs" -}}
- job_name: "kubelet"
  scheme: "https"
  metrics_path: "/metrics/cadvisor"
  tls_config:
    ca_file: "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
    insecure_skip_verify: true
  bearer_token_file: "/var/run/secrets/kubernetes.io/serviceaccount/token"
  kubernetes_sd_configs:
    - role: "node"
  relabel_configs:
    - action: "labelmap"
      regex: "__meta_kubernetes_node_label_(.+)"
    - source_labels:
        - "__address__"
      target_label: "metrics_path"
      replacement: "/metrics"
{{- end -}}

{{/*
Create the pod affinity section for prometheus
*/}}
{{- define "monitoring.prometheus.podAffinity" -}}
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
    - podAffinityTerm:
        labelSelector:
          matchLabels:
            {{- include "monitoring.prometheus.selectorLabels" . | nindent 12 }}
        {{- if semverCompare "< 1.17" .Capabilities.KubeVersion.GitVersion }}
        topologyKey: "failure-domain.beta.kubernetes.io/zone"
        {{- else }}
        topologyKey: "topology.kubernetes.io/zone"
        {{- end }}
      weight: 100
    - podAffinityTerm:
        labelSelector:
          matchLabels:
            {{- include "monitoring.prometheus.selectorLabels" . | nindent 12 }}
        topologyKey: "kubernetes.io/hostname"
      weight: 50
{{- end -}}
