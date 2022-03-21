# Hello-Kate Cluster Test Application

This role deploys [hello-kate](https://github.com/CmdrSharp/hello-kate) to test cluster capabilities.

## Variables
- `enabled` Set to true to deploy the application.
- `chart_version` The version of the Helm Chart to install.
- `pvc`
  * `storage_class` The storageclass to use for the MongoDB PVC
