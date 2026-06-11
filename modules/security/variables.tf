variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de los recursos de seguridad"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la VNet donde están las subnets"
  type        = string
}

variable "subnet_ids" {
  description = "Mapa de IDs de subnets (dmz, srv, app, etc.)"
  type        = map(string)
}

variable "subnets_config" {
  description = "Configuración completa de subredes para filtrar las que usan NAT"
  type = map(object({
    address_prefixes        = list(string)
    default_outbound_access = bool
    use_nat_gateway         = bool
  }))
}

variable "admin_ip" {
  description = "IP pública permitida para acceso administrativo"
  type        = string
}

variable "tags" {
  description = "Tags comunes"
  type        = map(string)
  default     = {}
}
