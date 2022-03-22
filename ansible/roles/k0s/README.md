# K0s Cluster Installation

This role installs k0s via k0sctl, and templates installation of MetalLB (if configured) as well as vsphere-cpi-csi for persistant storage.

# k0s / Kubernetes Variables
- `kubernetes`
  * `cluster_name` The metadata name for the cluster
  * `vsphere_cpi_csi`
    * `enabled` Set to false to disable deploying the vSphere Storage Interface and Cloud Provider
    * `chart_version` The version of the Helm Chart to install.
  * `calico`
    * `podCIDR` The Pod CIDR Calico will use
    * `serviceCIDR` The service CIDR Calico will use
    * `ipAutodetectionMethod` The way for Calico to identify the correct NIC

## MetalLB
- `metallb`
  * `enabled` Set true to deploy MetalLB.
  * `chart_version` The version of the Helm Chart to install.
  * `addresses` List of IP Ranges that MetalLB will respond to ARP's for.

## vSphere CPI CSI
Shares configuration with Terraform for vCenter Details. See [Terraform README.md](ansible/roles/terraform/README.md)