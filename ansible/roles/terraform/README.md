# Terraform

This role handles the VM Creation with Terraform.

## vCenter Variables
- `host` FQDN/IP to the vCenter Instance
- `username` Administrative username
- `password` Password to the vCenter User
- `datacenter` Datacenter to deploy resources in
- `cluster` Cluster to deploy resources in
- `resource_pool` Pool to deploy resources in

## Host Variables
- `vm_user` The VM User for Ansible to connect to VM's with
- `ssh_public_key` The SSH Key (ssh-rsa ...) for authorized_keys on the created VM's
- `ssh_private_key_path` Local path to the matching private key for `ssh_public_key`
- `controlplane`
  * `hostname` Starting hostname (automatically followed by a numeric and the domain)
  * `domain` Domain for the hostname
  * `vcpu` Number of vCPU's
  * `ram` Amount of RAM in MB
  * `disk_datastore` The datastore to use
  * `disk_size` Disk size in GB
  * `network_name` The Port Group Name to use
  * `count` Number of control plane nodes to deploy. At least 3 is recommended.
- `worker`
  * `hostname` Starting hostname (automatically followed by a numeric and the domain)
  * `domain` Domain for the hostname
  * `vcpu` Number of vCPU's
  * `ram` Amount of RAM in MB
  * `disk_datastore` The datastore to use
  * `disk_size` Disk size in GB
  * `network_name` The Port Group Name to use
  * `count` Number of control plane nodes to deploy. At least 3 is recommended.
- `lb`
  * `hostname` Starting hostname (automatically followed by a numeric and the domain)
  * `domain` Domain for the hostname
  * `vcpu` Number of vCPU's
  * `ram` Amount of RAM in MB
  * `disk_datastore` The datastore to use
  * `disk_size` Disk size in GB
  * `network_name` The Port Group Name to use. Should have access to the `controlplane` network.