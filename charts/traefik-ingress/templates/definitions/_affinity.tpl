{{/* vim: set filetype=mustache: */}}
{{/*
Create the pod affinity section for the traefik deployment
*/}}
{{- define "traefik-ingress.podAffinity" -}}
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
    - podAffinityTerm:
        labelSelector:
          matchExpressions:
            - key: "app.kubernetes.io/name"
              operator: In
              values:
                - {{ include "traefik-ingress.name" . | quote }}
            - key: "app.kubernetes.io/instance"
              operator: In
              values:
                - {{ .Release.Name | quote }}
        topologyKey: {{ include "traefik-ingress.topologyZoneLabel" . | quote }}
      weight: 100
    - podAffinityTerm:
        labelSelector:
          matchExpressions:
            - key: "app.kubernetes.io/name"
              operator: In
              values:
                - {{ include "traefik-ingress.name" . | quote }}
            - key: "app.kubernetes.io/instance"
              operator: In
              values:
                - {{ .Release.Name | quote }}
        topologyKey: "kubernetes.io/hostname"
      weight: 50
{{- end -}}
