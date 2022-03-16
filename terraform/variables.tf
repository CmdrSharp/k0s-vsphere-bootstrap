# Connection details
provider "vsphere" {
  user           = var.vsphere_username
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

variable "vsphere_username" {
  type = string
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "vsphere_server" {
  type = string
}

# Placement
variable "datacenter" {
  type    = string
  default = "dc1"
}

variable "resource_pool" {
  type    = string
  default = "Resources"
}

variable "cluster" {
  type    = string
  default = "cluster1"
}

# Templating
variable "content_library" {
  type    = string
  default = "Templates"
}

variable "template_name" {
  type    = string
  default = "focal-server-cloudimg-amd64"
}

variable "template_properties" {
  type      = map(any)
  sensitive = true
  default   = {}
}

# VM Definition
variable "cp_vm_params" {
  type = object({
    hostname       = string
    domain         = string
    vcpu           = number
    ram            = number
    disk_datastore = string
    disk_size      = number
    network_name   = string
  })

  default = {
    hostname = "cp"
    domain   = "local"

    vcpu = "2"
    ram  = "4096"

    disk_datastore = "my-datastore"
    disk_size      = "50"

    network_name = "VM Network"
  }
}

variable "worker_vm_params" {
  type = object({
    hostname       = string
    domain         = string
    vcpu           = number
    ram            = number
    disk_datastore = string
    disk_size      = number
    network_name   = string
  })

  default = {
    hostname = "worker"
    domain   = "local"

    vcpu = 4
    ram  = 8192

    disk_datastore = "my-datastore"
    disk_size      = 50

    network_name = "VM Network"
  }
}

variable "lb_vm_params" {
  type = object({
    hostname       = string
    domain         = string
    vcpu           = number
    ram            = number
    disk_datastore = string
    disk_size      = number
    network_name   = string
  })

  default = {
    hostname = "lb"
    domain   = "local"

    vcpu = 1
    ram  = 2048

    disk_datastore = "my-datastore"
    disk_size      = 15

    network_name = "VM Network"
  }
}

# VM Counts
variable "cp_vm_count" {
  type    = number
  default = 3
}

variable "worker_vm_count" {
  type    = number
  default = 3
}