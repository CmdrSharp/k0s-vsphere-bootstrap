output "node_ip_addr" {
	value = vsphere_virtual_machine.vsphere-vm.default_ip_address
}

output "node_name" {
	value = var.node_name
}