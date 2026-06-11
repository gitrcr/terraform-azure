########################
# Locals
########################

locals {
  project     = "labs"
  environment = "qa"
  location    = "spaincentral"
  rg_name     = "${local.environment}-rg"
  vnet_name   = "${local.environment}-vnet"
  app_name    = "${local.environment}${random_string.suffix.result}app"
  address_space = [
    "10.2.0.0/16"
  ]

  subnets = {
    dmz = {
      address_prefixes        = ["10.2.1.0/24"]
      default_outbound_access = true
      use_nat_gateway         = false
    }
    srv = {
      address_prefixes        = ["10.2.2.0/24"]
      default_outbound_access = false
      use_nat_gateway         = true
    }
    app = {
      address_prefixes        = ["10.2.3.0/24"]
      default_outbound_access = false
      use_nat_gateway         = true
    }
  }

  admin_ip       = "0.0.0.0/0" # tu IP
  admin_username = "azureadmin"
  password       = "aZ&Adm${random_string.suffix.result}"
  public_key     = ""
  # public_key      = file("~/.ssh/id_rsa.pub")
  # Tocken RO access public repo
  docker_id     = ""
  docker_secret = ""

  tags = {
    project = "${local.project}"
    site    = "${local.location}"
    env     = "${local.environment}"
  }
}

########################
# Random suffix
########################

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}


