# Traefik Ingress Helm Chart

An opinionated Helm Chart for deploying a Traefik Ingress Controller inside a Kubernetes Cluster.

## Features

This repository by default will deploy a three replicas deployment exposed via a LoadBalancer service.  
The ports that the service will listen to will be the default http/s ports, `80` and `443`, and they will
redirect the traffic on the unprivileged ports `8080` and `8443` exposed by the traefik pods.

The traefik instance will deploy three entrypoints named: `web`, `websecure` and `traefik`.
The `traefik` entrypoint it is only exposed internally to the cluster and not to the public, and is used for
routing the traefik dashboard and the metrics endpoints.

The `web` entrypoint is open only to serve redirects to the `websecure` entrypoint via a default route.  
The `websecure` entrypoint is the one where you are encourage to attach all your custom routes and by default will
use a standard `TLSOption` resource that you can set between two settings.  
For generating certificates for your `https` endpoints we reccomend to use the [cert-manager] project that can
satisfy every need you can have for x509 certificates and can be setup to work seamlessly with the Traefik CRDs.

### TLSOption

The chart will deploy four different preconfigured `TLSOption`, plus a fourth one named `default`.
The three main options follow the `modern`, `intermediate` and `old` configurations that you can find
in the [Mozilla wiki].  
With the `tlsOption` value you can switch the `default` one between the three available configurations and it will be
the one that Traefik will apply to all the route registered under the `websecure` entrypoint.  
The `intermediate` configuration is optimal for gaining the `A+` rating on the [SSLLabs] test, the `old` configuration
can be used if you cannot drop support for TLS 1.0 clients, and the `modern` configuration is best suited if you
can drop support for older clients and can expose only **TLS1.3** configurations.

You can always assign one of the others or a custom configuration with the appropriate section fo the
`IngressRoute` resource.

### Kubernetes CRDs

This installation of Traefik will only load configurations expressed via the Traefik CRDs like `IngressRoute`,
`IngressRouteTCP`, `Middleware` etc.  
In addition to that to allow multiple installations inside the same cluster (for now limited between installation
with the same CRDs support), you have to add the `app.kubernetes.io/instance` label to them with the Helm relese
name used to deploy the installation.

[cert-manager]: https://cert-manager.io (x509 certificate management for Kubernetes)
[Mozilla wiki]: https://wiki.mozilla.org/Security/Server_Side_TLS (Security/Server Side TLS wiki page)
[SSLLabs]: https://www.ssllabs.com/ssltest/ (Bringing you the best SSL/TLS and PKI testing tools and documentation.)
