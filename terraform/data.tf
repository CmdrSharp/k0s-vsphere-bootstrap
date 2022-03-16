# vSphere Placement
data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# vSphere Storage
data "vsphere_datastore" "cp_datastore" {
  name          = var.cp_vm_params["disk_datastore"]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "worker_datastore" {
  name          = var.worker_vm_params["disk_datastore"]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "lb_datastore" {
  name          = var.lb_vm_params["disk_datastore"]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# Network
data "vsphere_network" "cp_network" {
  name          = var.cp_vm_params["network_name"]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "worker_network" {
  name          = var.worker_vm_params["network_name"]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "lb_network" {
  name          = var.lb_vm_params["network_name"]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# Templating
data "vsphere_content_library" "content_library" {
  name = var.content_library
}

data "vsphere_content_library_item" "vm_template" {
  name       = var.template_name
  type       = "ovf"
  library_id = data.vsphere_content_library.content_library.id
}