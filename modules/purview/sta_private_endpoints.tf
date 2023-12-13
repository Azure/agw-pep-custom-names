# Create the Private endpoint. This is where the Storage account gets a private IP inside the VNet.sur
resource "azurerm_private_endpoint" "blob" {
  name                = "purview-sta-blob"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "purview-sta-blob"
    private_connection_resource_id = azurerm_purview_account.purview.managed_resources[0].storage_account_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "purview-sta-blob"
    private_dns_zone_ids = [var.sta_private_dns_zone_id]
  }
}

resource "azurerm_private_endpoint" "queue" {
  name                = "purview-sta-queue"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "purview-sta-queue"
    private_connection_resource_id = azurerm_purview_account.purview.managed_resources[0].storage_account_id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  private_dns_zone_group {
    name                 = "purview-sta-queue"
    private_dns_zone_ids = [var.sta_private_dns_zone_id]
  }
}
