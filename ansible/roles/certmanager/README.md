# cert-manager

This role deploys [cert-manager](https://cert-manager.io/docs/installation/helm/) for certificate management.

## Variables
- `enabled` Set to true to deploy the application.
- `chart_version` The version of the Helm Chart to install.
- `ca`
  * `enabled` Set true to create a custom CA
  * `issuer_name` The name of the CA Issuer CRD
  * `common_name` CN for the CA
