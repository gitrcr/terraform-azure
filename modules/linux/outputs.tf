output "vm_info" {
  value = {
    name       = azurerm_linux_virtual_machine.vm[*].name
    private_ip = azurerm_network_interface.nic.ip_configuration[*].private_ip_address
    public_ip  = azurerm_public_ip.pip[*].ip_address
  }
}

