{{/* vim: set filetype=mustache: */}}
{{/*
Create the args passed to the Traefik pod.
*/}}
{{- define "traefik-ingress.argsConfigs" -}}
- "--global.checknewversion=false"
- "--global.sendanonymoususage=false"
- "--api.dashboard=true"
- "--ping=true"
- "--log.format=json"
- "--accesslog.format=json"
- "--log.level={{ .Values.logLevel }}"
- "--entryPoints.web.address=:8080"
- "--entryPoints.web.transport.lifecycle.gracetimeout=30"
- "--entrypoints.web.transport.lifecycle.requestacceptgracetimeout=29"
{{- if .Values.service.enableTLS }}
- "--entryPoints.websecure.address=:8443"
- "--entryPoints.websecure.transport.lifecycle.gracetimeout=30"
- "--entrypoints.websecure.transport.lifecycle.requestacceptgracetimeout=29"
- "--entrypoints.websecure.http.tls=true"
{{- end }}
- "--entryPoints.traefik.address=:9000"
- "--entryPoints.traefik.transport.lifecycle.gracetimeout=1"
- "--entrypoints.traefik.transport.lifecycle.requestacceptgracetimeout=0"
- "--providers.kubernetescrd"
- "--providers.kubernetescrd.labelselector={{ include "traefik-ingress.crdLabelSelector" . }}"
- "--metrics=true"
- "--metrics.prometheus=true"
{{- end -}}
