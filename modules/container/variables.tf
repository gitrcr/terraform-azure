variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }

variable "subnet_id" {
  type    = string
  default = null
}

variable "dns_name_label" {
  type    = string
  default = null
}

variable "container_name" { type = string }
variable "container_image" { type = string }
variable "container_port" { type = number }

variable "docker_registry" { type = string }
variable "docker_username" { type = string }
variable "docker_password" { type = string }

variable "cpu" { type = string }
variable "memory" { type = number }

