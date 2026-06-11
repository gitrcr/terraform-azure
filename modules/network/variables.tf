variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región donde se desplegará la VNet"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la VNet"
  type        = string
}

variable "address_space" {
  description = "Address space de la VNet"
  type        = list(string)
}

# modules/subnets/variables.tf

variable "subnets_map" {
  description = "Mapa de configuración de subnets"
  type = map(object({
    address_prefixes        = list(string)
    default_outbound_access = bool
    use_nat_gateway         = optional(bool, false)
  }))
}


variable "admin_ip" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}





