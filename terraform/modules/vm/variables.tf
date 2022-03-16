variable "count_index" {
	type = number
}

variable "node_name" {
	type = string
}

variable "vcpu" {
	type = number
}

variable "memory" {
	type = number
}

variable "datastore_id" {}
variable "resource_pool_id" {}
variable "network_id" {}

variable "disk_size" {
	type = number
}

variable "thin_provisioned" {
	type = bool
	default = true
}

variable "template_uuid" {}

variable "hostname" {
	type = string
}

variable "domain" {
	type = string
	default = ""
}

variable "vapp_properties" {
	type = map(any)
	sensitive = true
}