{{/* vim: set filetype=mustache: */}}
{{/*
Create the args passed to the Prometheus Operator pod.
*/}}
{{- define "monitoring.argsConfigs" -}}
- "--logtostderr=true"
- "--log-level={{ .Values.logLevel }}"
- "--log-format=json"
- "--localhost=127.0.0.1"
- "--web.enable-tls=true"
- "--web.cert-file=/etc/prometheus-operator/tls/cert"
- "--web.key-file=/etc/prometheus-operator/tls/key"
- "--web.listen-address=:8443"
{{- $configReloader := .Values.prometheus.configReloader }}
{{- $configImage := $configReloader.image }}
- "--prometheus-config-reloader={{ $configImage.name }}:{{ $configImage.version }}"
{{- $configResources := $configReloader.resources }}
- "--config-reloader-cpu={{ $configResources.cpu }}"
- "--config-reloader-memory={{ $configResources.memory }}"
- "--prometheus-instance-namespaces={{ .Release.Namespace }}"
- "--alertmanager-instance-namespaces={{ .Release.Namespace }}"
- "--thanos-ruler-instance-namespaces={{ .Release.Namespace }}"
{{- end -}}
