resource "azurerm_cosmosdb_account" "db" {
  name                          = var.cosmosdb_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  offer_type                    = "Standard"
  kind                          = "GlobalDocumentDB"
  enable_automatic_failover     = false
  public_network_access_enabled = false
  tags                          = var.tags

  consistency_policy {
    consistency_level = "Eventual"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

# Create the privatelink.file.core.windows.net Private DNS Zone
resource "azurerm_private_dns_zone" "cosmos" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Create the Private endpoint.
resource "azurerm_private_endpoint" "cosmosdb_endpoint" {
  name                = "cosmos-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "cosmos-privateserviceconnection"
    private_connection_resource_id = azurerm_cosmosdb_account.db.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }

  private_dns_zone_group {
    name                 = "privatelink-cosmosdb"
    private_dns_zone_ids = [azurerm_private_dns_zone.cosmos.id]
  }
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "cosmos" {
  name                  = "cosmos"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.cosmos.name
  virtual_network_id    = var.hub_vnet_id
}

resource "azurerm_role_assignment" "sp_contributor" {
  scope                = azurerm_cosmosdb_account.db.id
  role_definition_name = "Contributor"
  principal_id         = var.principal_id
}
