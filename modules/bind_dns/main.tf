resource "azurerm_container_group" "containergroup" {
  name                = "ci-bind"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Private"
  os_type             = "Linux"
  subnet_ids          = [var.dns_subnet_id]
  tags                = var.tags

  container {
    name   = "bind"
    image  = "cmendibl3/dnsforwarder"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 53
      protocol = "UDP"
    }
  }
}
