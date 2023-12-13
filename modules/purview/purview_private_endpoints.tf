resource "azurerm_private_endpoint" "portal" {
  name                = "purview-portal"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "purview-portal"
    private_connection_resource_id = azurerm_purview_account.purview.id
    is_manual_connection           = false
    subresource_names              = ["portal"]
  }

  private_dns_zone_group {
    name                 = "privatelink-purview-portal"
    private_dns_zone_ids = [azurerm_private_dns_zone.portal.id]
  }
}

resource "azurerm_private_dns_zone" "portal" {
  name                = "privatelink.purviewstudio.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "portal" {
  name                  = "portal"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.portal.name
  virtual_network_id    = var.hub_vnet_id
}

resource "azurerm_private_endpoint" "account" {
  name                = "purview-account"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "purview-account"
    private_connection_resource_id = azurerm_purview_account.purview.id
    is_manual_connection           = false
    subresource_names              = ["account"]
  }

  private_dns_zone_group {
    name                 = "privatelink-purview-account"
    private_dns_zone_ids = [azurerm_private_dns_zone.account.id]
  }
}

resource "azurerm_private_dns_zone" "account" {
  name                = "privatelink.purview.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "account" {
  name                  = "account"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.account.name
  virtual_network_id    = var.hub_vnet_id
}
