output "vm_name" { value = azurerm_windows_virtual_machine.vm[*].name }
output "vm_id" { value = azurerm_windows_virtual_machine.vm[*].id }

output "vm_info" {
  value = {
    name       = azurerm_windows_virtual_machine.vm[*].name
    private_ip = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
    public_ip  = azurerm_public_ip.pip[*].ip_address
  }
}






