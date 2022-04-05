# Istio Service Mesh

This role installs the [Istio](https://istio.io/latest/docs/setup/install/helm/) helm charts.

## Ingress Gateways
When deploying with Istio Ingress, two ingress gateways are deployed, along with two default gateways.

### istio-internal-ingress
This ingress handles access to cluster resources such as Grafana, Prometheus and Kiali. **It should not be exposed to the internet**. There are currently no policies to control traffic hitting it, to allow for easier debugging.
The gateway `system-gateway` is deployed to this ingress by default, and is where the monitoring virtual services are tied to.

### istio-external-ingress
This ingress is for applications that should be exposed publicly. The gateway `external-gateway` is deployed by default.

## TLS Support
With Istio, there is support for deploying with your own certificates, or with self-signed certificates. An example configuration is provided below.
Simply adding more hosts will create additional bindings on the relevant istio gateway.

This requires cert-manager to also be enabled.

```
istio:
  enabled: true
  chart_version: 1.13.2
  ingress: true
  internal_gateway:
    insecure:
      enabled: true
      hosts:
        - example-domain.local
    secure:
      enabled: false
      tls:
        hosts: {}
  external_gateway:
    insecure:
      enabled: true
      hosts:
        - your-public-domain.com
    secure:
      enabled: true
      tls:
        hosts:
          - { host: your-public-domain.com, create_self_signed_certificate: false, certificate_path: /path/to/domain1-folder/ }
          - { host: your-public-domain.dev, create_self_signed_certificate: true }
```

## Variables

- `enabled` Whether to deploy Istio Base / Istiod
- `chart_version` The version of the Helm Chart to install.
- `ingress` Whether to deploy the Istio Ingresses
- `internal_gateway`
  * `insecure`
    * `enabled` Set to true to enable HTTP (Port 80)
    * `hosts` A flat list of hosts for the gateway to listen to.
  * `secure`
    * `enabled` Set to true to enable host-specific gateways at port 443
    * `tls`
      * `hosts` List of dictionaries, each containing the following keys
        * `host` The hostname
        * `create_self_signed_certificate` Set to true to generate a self-signed certificate
        * `certificate_path` Full path to a folder containing a host.crt and host.key pair of files for the host.
