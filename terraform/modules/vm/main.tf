resource "vsphere_virtual_machine" "vsphere-vm" {
  name             = var.node_name
  num_cpus         = var.vcpu
  memory           = var.memory
  datastore_id     = var.datastore_id
  resource_pool_id = var.resource_pool_id

  network_interface {
    network_id = var.network_id
  }

  disk {
    label            = "disk0"
    size             = var.disk_size
    thin_provisioned = true
  }

  clone {
    template_uuid = var.template_uuid

    customize {
      linux_options {
        host_name = var.hostname
        domain    = var.domain
      }

      network_interface {}
    }
  }

  cdrom {
    client_device = true
  }

  vapp {
    properties = merge({
      hostname = "${var.hostname}${var.count_index}"
    }, var.vapp_properties)
  }
}