variable "vm_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "subnet_id" { type = string }
variable "admin_username" { type = string }
variable "admin_password" { type = string }
variable "public_key" { type = string }
variable "nsg_id" { type = string }

variable "tags" { type = map(string) }
variable "has_public_ip" {
  type    = bool
  default = false
}
variable "size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "sku" {
  type    = string
  default = "22_04-lts"
}