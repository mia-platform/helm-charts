# Logging Helm Chart

An opinionated Helm Chart for deploying a logging stack based on [Logging Operator] inside a Kubernetes Cluster.

## Features

This chart will deploy a logging operator that can handle a [fluentbit]/[fluentd] stack for harvesting, parsing,
filtering and sending log from the cluster to one or more outputs.  
The operator will handle all of this via its custom resources, and you can find more information on the official
documentation of the [Logging Operator].

Additionally the chart can deploy a default logging stack via the `logging` custom resource. The stack is setup
to use encryption for communication between [fluentbit] and fluentd, and to keep memories of last parsed logs
and buffers between restarts.

By default all workloads will be harvested by [fluentbit] but you can use the `fluentbit.io/exclude` annotation setting
its value to `"true"`., for processing and transfering your log you have to deploy a `clusterflow`, `flow`, `output` or
`clusteroutput` in your cluster for customize the [fluentd] configuration as you like.

### Caveats

The certificates that ensure the crypted communication between [fluentbit] and [fluentd] are generated on the fly,
and they change every time you will deploy this chart and the valid duration is one year.

[Logging Operator]: https://github.com/banzaicloud/logging-operator (Logging operator for Kubernetes based on Fluentd and Fluentbit)
[fluentbit]: https://fluentbit.io (Cloud Native Log Forwarder)
[fluentd]: https://www.fluentd.org (Fluentd is an open source data collector for unified logging layer)
