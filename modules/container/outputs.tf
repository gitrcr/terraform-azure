output "container_group_id" {
  value = azurerm_container_group.container_group[*].id
}

output "container_info" {
  value = {
    name      = azurerm_container_group.container_group[*].name
    fqdn      = azurerm_container_group.container_group[*].fqdn
    public_ip = azurerm_container_group.container_group[*].ip_address
  }
}

