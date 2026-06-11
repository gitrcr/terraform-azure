module "rg" {
  source = "../../modules/resource_group"

  name     = local.rg_name
  location = local.location
  tags     = local.tags
}

module "network" {
  source = "../../modules/network"

  resource_group_name = module.rg.name
  location            = local.location
  vnet_name           = local.vnet_name
  address_space       = local.address_space
  admin_ip            = local.admin_ip
  subnets_map         = local.subnets
}

module "security" {
  source = "../../modules/security"

  resource_group_name = module.rg.name
  location            = local.location
  vnet_name           = local.vnet_name
  subnet_ids          = module.network.subnet_ids
  subnets_config      = local.subnets
  admin_ip            = local.admin_ip
  tags                = local.tags
}

module "rdp" {
  source = "../../modules/windows"

  count               = 1
  vm_name             = "rdp${count.index}-${local.environment}-vm"
  location            = local.location
  resource_group_name = module.rg.name
  subnet_id           = module.network.subnet_ids["dmz"]
  has_public_ip       = true
  admin_username      = local.admin_username
  admin_password      = local.password
  nsg_id              = module.security.nsg_rdp_id
  tags                = local.tags
}

module "ssh" {
  source = "../../modules/linux"

  count               = 0
  vm_name             = "ssh${count.index}-${local.environment}-vm"
  location            = local.location
  resource_group_name = module.rg.name
  subnet_id           = module.network.subnet_ids["dmz"]
  has_public_ip       = true
  nsg_id              = module.security.nsg_ssh_id
  admin_username      = local.admin_username
  admin_password      = local.password
  public_key          = local.public_key
  tags                = local.tags
}

module "linux" {
  source = "../../modules/linux"

  count               = 1
  vm_name             = "nx${count.index}-${local.environment}-vm"
  location            = local.location
  resource_group_name = module.rg.name
  size                = "Standard_D2s_v3"
  sku                 = "22_04-lts"
  subnet_id           = module.network.subnet_ids["app"]
  has_public_ip       = false
  nsg_id              = module.security.nsg_ssh_id
  admin_username      = local.admin_username
  admin_password      = local.password
  public_key          = local.public_key
  tags                = local.tags
}

module "windows" {
  source = "../../modules/windows"

  count               = 0
  vm_name             = "wd${count.index}-${local.environment}-vm"
  location            = local.location
  resource_group_name = module.rg.name
  size                = "Standard_D2s_v3"
  sku                 = "2022-datacenter-azure-edition"
  subnet_id           = module.network.subnet_ids["srv"]
  has_public_ip       = false
  admin_username      = local.admin_username
  admin_password      = local.password
  nsg_id              = module.security.nsg_rdp_id
  tags                = local.tags
}

module "webpub" {
  source = "../../modules/container"

  count               = 0
  name                = lower("${local.app_name}${count.index}")
  location            = local.location
  resource_group_name = module.rg.name

  subnet_id      = null
  dns_name_label = lower("${local.app_name}${count.index}fqdn")

  container_image = "guanadoo/web-python:latest"
  container_name  = lower("${local.app_name}${count.index}artf")
  container_port  = 80
  cpu             = "1"
  memory          = 2

  docker_registry = "docker.io"
  docker_username = local.docker_id
  docker_password = local.docker_secret
}