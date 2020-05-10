{{/* vim: set filetype=mustache: */}}
{{/*
Create the default TLSOption based on the chart value.
*/}}
{{- define "traefik-ingress.tlsOptionSpec" -}}
sniStrict: true
{{- if eq .Values.tlsOption "intermediate" }}
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
{{- else if eq .Values.tlsOption "old" }}
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
{{- else }}
{{- fail (printf "You can not choose %s as tlsOption value" .Values.tlsOption) -}}
{{- end }}
curvePreferences:
  - "X25519"
  - "CurveP384"
  - "CurverP256"
{{- end }}
