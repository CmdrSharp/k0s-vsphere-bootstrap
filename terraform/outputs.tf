output "controlplane_ip_addresses" {
  value = module.controlplane.*.node_ip_addr
}

output "controlplane_names" {
  value = module.controlplane.*.node_name
}

output "worker_ip_addresses" {
  value = module.worker.*.node_ip_addr
}

output "worker_names" {
  value = module.worker.*.node_name
}

output "lb_ip_addresses" {
  value = module.loadbalancer.*.node_ip_addr
}

output "lb_names" {
  value = module.loadbalancer.*.node_name
}