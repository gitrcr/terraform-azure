resource "azurerm_container_group" "container_group" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  #ip_address_type     = "Public"

  #dns_name_label = var.dns_name_label

  # Público o privado
  ip_address_type = var.subnet_id == null ? "Public" : "Private"

  # Solo público
  dns_name_label = var.subnet_id == null ? var.dns_name_label : null

  # Solo privado
  subnet_ids = var.subnet_id != null ? [var.subnet_id] : null

  image_registry_credential {
    server   = "index.docker.io"
    username = var.docker_username # Tu usuario de Docker Hub
    password = var.docker_password # Tu Personal Access Token (NO tu contraseña)
  }

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = var.cpu
    memory = var.memory

    ports {
      port     = var.container_port
      protocol = "TCP"
    }

  }

}


