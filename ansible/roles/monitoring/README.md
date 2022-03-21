# Monitoring Stack

This role installs Loki, Grafana and Prometheus by the [loki-stack](https://github.com/grafana/helm-charts/tree/main/charts/loki-stack) helm chart and optionally [Kiali](https://kiali.io/docs/installation/installation-guide/install-with-helm/).

## Accessing Grafana

In order to access the Grafana instance, go to https://monitoring_domain/basepath/
By default, the instance is provisioned with `admin`/`admin` as username and password - and has anonymous access enabled.

## Accessing Kiali

Accessing Kiali is done via https://monitoring_domain/kiali
The instance is provisioned with anonymous access.

## Variables

- `domain` The domain to serve monitoring behind. Can be unique, or shared with other internal services. Ignored if not using Istio Ingress.
- `loki_grafana`
  * `enabled` Whether to deploy the Grafana/Prometheus stack.
  * `chart_version` The version of the Helm Chart to install.
  * `basepath` The base path to serve behind
- `kiali`
  * `enabled` Whether to deploy Kiali. Ignored if Istio is not enabled.
  * `chart_version` The version of the Helm Chart to install.
  * `auth`
    * `strategy` The sauth strategy (anonymous by default)
