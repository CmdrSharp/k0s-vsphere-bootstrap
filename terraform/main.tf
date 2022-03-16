module "controlplane" {
  source      = "./modules/vm"
  count       = var.cp_vm_count
  count_index = count.index + 1

  node_name = "${var.cp_vm_params.hostname}${count.index + 1}.${var.cp_vm_params.domain}"
  hostname  = "${var.cp_vm_params.hostname}${count.index + 1}"
  domain    = var.cp_vm_params.domain

  vcpu      = var.cp_vm_params["vcpu"]
  memory    = var.cp_vm_params["ram"]
  disk_size = var.cp_vm_params["disk_size"]

  datastore_id     = data.vsphere_datastore.cp_datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id       = data.vsphere_network.cp_network.id

  template_uuid = data.vsphere_content_library_item.vm_template.id

  vapp_properties = var.template_properties
}

module "worker" {
  source      = "./modules/vm"
  count       = var.worker_vm_count
  count_index = count.index + 1

  node_name = "${var.worker_vm_params.hostname}${count.index + 1}.${var.worker_vm_params.domain}"
  hostname  = "${var.worker_vm_params.hostname}${count.index + 1}"
  domain    = var.worker_vm_params.domain

  vcpu      = var.worker_vm_params["vcpu"]
  memory    = var.worker_vm_params["ram"]
  disk_size = var.worker_vm_params["disk_size"]

  datastore_id     = data.vsphere_datastore.cp_datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id       = data.vsphere_network.cp_network.id

  template_uuid = data.vsphere_content_library_item.vm_template.id

  vapp_properties = var.template_properties
}

module "loadbalancer" {
  source      = "./modules/vm"
  count       = var.cp_vm_count > 1 ? 1 : 0
  count_index = count.index + 1

  node_name = "${var.lb_vm_params.hostname}${count.index + 1}.${var.lb_vm_params.domain}"
  hostname  = "${var.lb_vm_params.hostname}${count.index + 1}"
  domain    = var.worker_vm_params.domain

  vcpu      = var.lb_vm_params["vcpu"]
  memory    = var.lb_vm_params["ram"]
  disk_size = var.lb_vm_params["disk_size"]

  datastore_id     = data.vsphere_datastore.lb_datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id       = data.vsphere_network.lb_network.id

  template_uuid = data.vsphere_content_library_item.vm_template.id

  vapp_properties = var.template_properties
}