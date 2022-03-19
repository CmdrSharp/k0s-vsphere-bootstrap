# K0S vSphere Bootstrapper

This is a project which includes the resources needed to completely bootstrap a K0S cluster, including installation of vSphere CPI+CSI, MetalLB and Istio.
Some of these things could be done using k0sctl alone - but some installations (such as Istio) need to be handled in sequential order. This is where Ansible comes into play.

## What it does
Items in italic are optional and can thus be disabled via values.

- Creates ControlPlane & Worker VM's (as many as specified in the .tfvars file)
- Creates and configures a simple HAProxy if multiple ControlPlane servers are specified
- Templates k0sctl config files
- Installs
  - vSphere CPI CSI
  - *MetalLB*
  - *Istio*
  - *Grafana/Prometheus stack*
  - *The cluster test application [hello-kate](https://github.com/CmdrSharp/hello-kate)*

## What it does NOT

It does NOT do management of existing clusters. It's intended to bootstrap the clusters, not to manage them. For convenience, a play to destroy what was built is included. This however assumes that the state files remain. **Note**: This play has not been tested on Windows.

## Requirements

**On the machine running the Ansible Playbook**
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
  - [Helm Module](https://docs.ansible.com/ansible/latest/collections/kubernetes/core/helm_module.html) requires [Helm](https://helm.sh/docs/intro/install/) to be installed, as well as [PyYAML](https://pypi.org/project/PyYAML/).
  - [OpenSSL Module](https://docs.ansible.com/ansible/2.7/modules/openssl_certificate_module.html) requires [pyOpenSSL](https://pypi.org/project/pyOpenSSL/). This is only needed if you plan to deploy with self-signed certificates.
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [k0sctl](https://github.com/k0sproject/k0sctl#installation)
- Python3
- An SSH Key for Ansible to connect to its created VM's with

**Other requirements**
- vSphere/vCenter (Licensed, not just ESXi)
- Portgroups should run DHCP (ToDo: Allow static IP assignment)
- An uploaded OVA in a Content Library (focal-server-cloudimg-amd64 tested, modifications may be needed for other distros)

## Getting started
- Install required Python modules `pip install -r requirements.txt` or `python3 -m pip install -r requirements.txt`
- Install required Ansible modules `ansible-galaxy install -r requirements.yml`
- Copy [vault.yaml.example](ansible/vaults/vault.yaml.example) to vault.yaml, and fill out the details.
- (Optional, but recommended): Encrypt the vault. `ansible-vault encrypt ansible/vaults/vault.yaml`
| :memo:        | The secrets will be temporarily written in plain-text as part of the Terraform process. This file is deleted when VM's have been created.       |
|---------------|:------------------------|

- Deploy with `ansible-playbook deploy.yaml --ask-vault-pass`
- Destroy with `ansible-playbook destroy.yaml --ask-vault-pass`

## TLS Support

With Istio, there is support for deploying with your own certificates, or with self-signed certificates. An example configuration is provided below.
Simply adding more hosts will create additional bindings on the istio gateway.

```
istio:
  enabled: true
  ingress: true
  gateway:
    insecure: true
    secure:
      enabled: true
      tls:
        hosts:
          - { host: your-public-domain.com, create_self_signed_certificate: false, certificate_path: /path/to/domain1-folder/ }
          - { host: your-private-domain.local, create_self_signed_certificate: true }
  injection_namespaces:
  - istio-ingress
  - default
```

## Variables

All variables are documented in [vault.yaml.example](ansible/vaults/vault.yaml.example).