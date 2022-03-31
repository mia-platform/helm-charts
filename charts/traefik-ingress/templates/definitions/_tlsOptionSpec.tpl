{{/* vim: set filetype=mustache: */}}
{{/*
Create the base for the TLSOption that is shared between spec.
*/}}
{{- define "mia-traefik-ingress.baseTlsOptionSpec" -}}
sniStrict: true
curvePreferences:
  - "X25519"
  - "CurveP384"
  - "CurveP256"
{{- end -}}

{{/*
Create the modern TLSOption spec
*/}}
{{- define "mia-traefik-ingress.modernTlsOptionSpec" -}}
{{- include "mia-traefik-ingress.baseTlsOptionSpec" . }}
preferServerCipherSuites: false
minVersion: "VersionTLS13"
cipherSuites:
  - "TLS_AES_128_GCM_SHA256"
  - "TLS_AES_256_GCM_SHA384"
  - "TLS_CHACHA20_POLY1305_SHA256"
{{- end }}

{{/*
Create the intermediate TLSOption spec
*/}}
{{- define "mia-traefik-ingress.intermediateTlsOptionSpec" -}}
{{- include "mia-traefik-ingress.baseTlsOptionSpec" . }}
preferServerCipherSuites: false
minVersion: "VersionTLS12"
cipherSuites:
  - "TLS_AES_128_GCM_SHA256"
  - "TLS_AES_256_GCM_SHA384"
  - "TLS_CHACHA20_POLY1305_SHA256"
  - "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256"
  - "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
  - "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384"
  - "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"
  - "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305"
  - "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305"
  - "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"
{{- end }}

{{/*
Create the old TLSOption spec
*/}}
{{- define "mia-traefik-ingress.oldTlsOptionSpec" -}}
{{- include "mia-traefik-ingress.baseTlsOptionSpec" . }}
preferServerCipherSuites: true
minVersion: "VersionTLS10"
cipherSuites:
  - "TLS_AES_128_GCM_SHA256"
  - "TLS_AES_256_GCM_SHA384"
  - "TLS_CHACHA20_POLY1305_SHA256"
  - "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256"
  - "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
  - "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384"
  - "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"
  - "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305"
  - "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305"
  - "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256"
  - "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256"
  - "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA"
  - "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"
  - "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA"
  - "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA"
  - "TLS_RSA_WITH_AES_128_GCM_SHA256"
  - "TLS_RSA_WITH_AES_256_GCM_SHA384"
  - "TLS_RSA_WITH_AES_128_CBC_SHA256"
  - "TLS_RSA_WITH_AES_128_CBC_SHA"
  - "TLS_RSA_WITH_AES_256_CBC_SHA"
{{- end }}

{{/*
Create the old TLSOption spec
*/}}
{{- define "mia-traefik-ingress.defaultTlsOptionSpec" -}}
{{- if eq .Values.tlsOption "modern" }}
{{- include "mia-traefik-ingress.modernTlsOptionSpec" . }}
{{- else if eq .Values.tlsOption "intermediate" }}
{{- include "mia-traefik-ingress.intermediateTlsOptionSpec" . }}
{{- else if eq .Values.tlsOption "old" }}
{{- include "mia-traefik-ingress.oldTlsOptionSpec" . }}
{{- else }}
{{- fail (printf "You can not choose %s as tlsOption value" .Values.tlsOption) -}}
{{- end }}
{{- end }}
