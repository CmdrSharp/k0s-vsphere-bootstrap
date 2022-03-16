# K0S vSphere Bootstrapper

This is a project which includes the resources needed to completely bootstrap a K0S cluster, including installation of vSphere CPI+CSI, MetalLB and Istio.
Some of these things could be done using k0sctl alone - but some installations (such as Istio) need to be handled in sequential order. This is where Ansible comes into play.

## What it does

- Creates ControlPlane & Worker VM's (as many as specified in the .tfvars file)
- Creates and configures a simple HAProxy if multiple ControlPlane servers are specified
- Templates k0sctl config files
- Installs vSphere CPI CSI
- Installs MetalLB (Can be disabled)
- ~~Installs Istio~~ (ToDo)
- ~~Optionally installs a Cluster Test Application~~ (ToDo)

## What it does NOT

It does NOT do management of existing clusters. It's intended to bootstrap the clusters, not to manage them. For convenience, a play to destroy what was built is included. This however assumes that the state files remain.
**Note**: This play has not been tested on Windows.

## Requirements

**On the machine running the Ansible Playbook**
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [k0sctl](https://github.com/k0sproject/k0sctl#installation)
- An SSH Key for Ansible to connect to its created VM's with

**Other requirements**
- vSphere/vCenter (Licensed, not just ESXi)
- An uploaded OVA in a Content Library (focal-server-cloudimg-amd64 tested, modifications may be needed for other distros)

## Getting started
- Fill out the details in [vault.yaml](ansible/vaults/vault.yaml)
- (Optional, but recommended): Encrypt the vault. `ansible-vault encrypt ansible/vaults/vault.yaml`

| :memo:        | The secrets will be temporarily written in plain-text as part of the Terraform process. This file is deleted when VM's have been created.       |
|---------------|:------------------------|

- Deploy with `ansible-playbook deploy.yaml --ask-vault-pass`
- Destroy with `ansible-playbook destroy.yaml --ask-vault-pass` 

## Variables

| Variable Name | Description | Default |
|--|--|--|
| kubernetes.cluster_name | The name of the K0s Cluster to create | k0s-cluster01 |
| controlplane.count | Number of control plane hosts to deploy | 3 |
| worker.count | Number of worker hosts to deploy | 3 |
| vcenter.host | IP or FQDN to your vCenter Server | vcenter.local |
| vcenter.username | vCenter Username | Administrator@vSphere.local |
| vcenter.password | vCenter Password | changeme |
| datacenter | Which datacenter in vCenter to deploy in | dc01 |
| cluster | Which cluster in vCenter to deploy in | cluster01 |
| resource_pool | The resource pool to deploy in | pool01 |
| metallb.enabled | Whether to deploy MetalLB | true |
| metallb.addresses | List of IP's that MetalLB should ARP | 172.31.1.245-172.31.1.254 |
| host.vm_user | The username to connect to VM's with | ubuntu |
| host.ssh_public_key | A public key that is added to the vm_users authorized_keys file | |
| host.ssh_private_key_path | The matching private key used for Ansible to connect to the VM's | /path/to/your/private/key/id_rsa |
| controlplane/worker/lb.hostname | Starting hostname (automatically appended by the index of the VM) | cp/worker/lb |
| controlplane/worker/lb.domain | Host Domain | k0s.local |
| controlplane/worker/lb.vcpu | Number of vCPU's | 4/4/1 |
| controlplane/worker/lb.ram | Amount of RAM | 4096/8192/1024 |
| controlplane/worker/lb.disk_datastore | Which datastore to use for the VM Disk | datastore1 |
| controlplane/worker/lb.disk_size | Disk Size in GiB | 50 |
| controlplane/worker/lb.network_name | The port group name in vCenter to use for the VM Network | CP-Network/Worker-Network/LoadBalancer-Network |
