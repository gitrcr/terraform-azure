########################
# Virtual Network
########################

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

########################
# Subnets
########################

resource "azurerm_subnet" "subnets" {
  for_each = var.subnets_map

  name                            = each.key
  resource_group_name             = var.resource_group_name
  virtual_network_name            = azurerm_virtual_network.vnet.name
  address_prefixes                = each.value.address_prefixes
  default_outbound_access_enabled = each.value.default_outbound_access

  lifecycle {
    # Ignorar cambios en este campo evita la destrucción de la subred
    # Terraform aplicará el cambio in-place (sin downtime)
    ignore_changes = [
      default_outbound_access_enabled
    ]
  }
}