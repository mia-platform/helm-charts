{{/* vim: set filetype=mustache: */}}
{{/*
Create the args passed to the Traefik pod.
*/}}
{{- define "mia-traefik-ingress.argsConfigs" -}}
- "--global.checknewversion=false"
- "--global.sendanonymoususage=false"
- "--api.dashboard=true"
- "--pilot.dashboard=false"
- "--ping=true"
- "--log.format=json"
- "--accesslog.format=json"
- "--log.level={{ .Values.logLevel }}"
- "--entryPoints.web.address=:8080/tcp"
- "--entryPoints.web.transport.lifecycle.gracetimeout=30"
- "--entrypoints.web.transport.lifecycle.requestacceptgracetimeout=29"
{{- if .Values.service.enableTLS }}
- "--entrypoints.web.http.redirections.entryPoint.to=:443"
- "--entrypoints.web.http.redirections.entryPoint.scheme=https"
- "--entrypoints.web.http.redirections.entrypoint.priority=0"
- "--entryPoints.websecure.address=:8443/tcp"
- "--entryPoints.websecure.transport.lifecycle.gracetimeout=30"
- "--entrypoints.websecure.transport.lifecycle.requestacceptgracetimeout=29"
- "--entrypoints.websecure.http.tls=true"
{{- end }}
- "--entryPoints.traefik.address=:9000/tcp"
- "--entryPoints.traefik.transport.lifecycle.gracetimeout=1"
- "--entrypoints.traefik.transport.lifecycle.requestacceptgracetimeout=0"
- "--providers.kubernetesingress"
- "--providers.kubernetesingress.allowexternalnameservices={{ .Values.allowExternalNameServices }}"
- "--providers.kubernetesingress.ingressclass={{ include "mia-traefik-ingress.fullname" . }}"
- "--providers.kubernetescrd"
- "--providers.kubernetescrd.labelselector={{ include "mia-traefik-ingress.crdLabelSelector" . }}"
- "--providers.kubernetescrd.allowcrossnamespace={{ .Values.allowCrossNamespaceResources }}"
- "--providers.kubernetescrd.allowexternalnameservices={{ .Values.allowExternalNameServices }}"
- "--metrics=true"
- "--metrics.prometheus=true"
{{- end -}}
