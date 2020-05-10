# Mia-Platform Helm Charts Library

An opinionated collection of Helm Charts. We want to focus on adopting a default stance on security for all
the deployed resources and Out of the Box™ support for a `production` cluster, so don’t expect support for
great degrees of configurations available to you.

These charts are created for [Helm v3] and will target [Kubernetes] 1.16+, that is the first version to deprecate most
of the beta version of the commonly used APIs and is therefore a nice line to draw in the sand, we cannot guarantee
that in the future we will move the support forward in step with the evolution of kubernetes.

## How to Use the Charts

To use our helm charts you have to add the helm repository and select the chart you want to use:

```bash
$ helm repo add mia-platform https://mia-platform.github.io/helm-charts
$ helm search repo mia-platform
$ helm install release-name mia-platform/<chart>
```

[Helm v3]: https://helm.sh/docs/intro/install/ (Link for installation guide of Helm v3)
[Kubernetes]: https://kubernetes.io (Production-Grade Container Orchestration)
