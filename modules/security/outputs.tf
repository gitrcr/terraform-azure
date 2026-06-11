output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = azurerm_nat_gateway.nat.id
}

output "nat_public_ip" {
  description = "IP pública del NAT Gateway"
  value       = azurerm_public_ip.nat_ip.ip_address
}

output "nsg_rdp_id" {
  description = "ID del NSG para RDP"
  value       = azurerm_network_security_group.nsg_rdp.id
}

output "nsg_ssh_id" {
  description = "ID del NSG para SSH"
  value       = azurerm_network_security_group.nsg_ssh.id
}
