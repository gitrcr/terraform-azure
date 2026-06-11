variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "vm_name" { type = string }
variable "size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "sku" {
  type    = string
  default = "2022-datacenter-azure-edition"
}

variable "subnet_id" { type = string }
variable "admin_username" { type = string }
variable "admin_password" { type = string }
variable "nsg_id" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}

variable "has_public_ip" {
  type    = bool
  default = false
}