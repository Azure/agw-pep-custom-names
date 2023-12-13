# Create the Private endpoint. This is where the Storage account gets a private IP inside the VNet.
resource "azurerm_private_endpoint" "evh_endpoint" {
  name                = "purview-evh"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "purview-evh"
    private_connection_resource_id = azurerm_purview_account.purview.managed_resources[0].event_hub_namespace_id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }

  private_dns_zone_group {
    name                 = "privatelink-purview-evh"
    private_dns_zone_ids = [var.evh_private_dns_zone_id]
  }
}
