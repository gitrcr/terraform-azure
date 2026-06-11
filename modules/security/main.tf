########################
# NAT Gateway
########################

resource "azurerm_public_ip" "nat_ip" {
  name                = "${var.vnet_name}-nat-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "nat" {
  name                = "${var.vnet_name}-nat"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.nat_ip.id
}

# Asociación NAT → subnet app
resource "azurerm_subnet_nat_gateway_association" "app_nat_assoc" {
  for_each = {
    for name, config in var.subnets_config : name => config
    if config.use_nat_gateway == true
  }


  # Aquí está la magia: usamos el ID venido de 'network' basado en la clave del filtro
  subnet_id      = var.subnet_ids[each.key]
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

########################
# NSG RDP (Windows)
########################

resource "azurerm_network_security_group" "nsg_rdp" {
  name                = "rdp-${var.vnet_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.admin_ip
    destination_address_prefix = "*"
  }
}

########################
# NSG SSH (Linux)
########################

resource "azurerm_network_security_group" "nsg_ssh" {
  name                = "ssh-${var.vnet_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.admin_ip
    destination_address_prefix = "*"
  }
}
