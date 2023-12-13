# Create the Storage Account.
resource "azurerm_storage_account" "sa" {
  name                            = var.storage_account_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  enable_https_traffic_only       = true
  tags                            = var.tags
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = []
    ip_rules = [
      var.public_ip
    ]
    bypass = [
      "AzureServices"
    ]
  }
}

resource "azurerm_storage_share" "content_share" {
  name                 = var.storage_account_name
  storage_account_name = azurerm_storage_account.sa.name
  quota                = "10"
}

# Create the Private endpoint. This is where the Storage account gets a private IP inside the VNet.sur
resource "azurerm_private_endpoint" "endpoint" {
  name                = "sa-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "sa-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "privatelink-sta"
    private_dns_zone_ids = [azurerm_private_dns_zone.sta.id]
  }
}

resource "azurerm_private_dns_zone" "sta" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "sa" {
  name                  = "sta"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sta.name
  virtual_network_id    = var.hub_vnet_id
}

resource "azurerm_private_endpoint" "table_endpoint" {
  name                = "table-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "table-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "privatelink-table"
    private_dns_zone_ids = [azurerm_private_dns_zone.table_sta.id]
  }
}

resource "azurerm_private_dns_zone" "table_sta" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "table_sa" {
  name                  = "table"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.table_sta.name
  virtual_network_id    = var.hub_vnet_id
}

resource "azurerm_private_endpoint" "queue_endpoint" {
  name                = "queue-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "queue-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  private_dns_zone_group {
    name                 = "privatelink-queue"
    private_dns_zone_ids = [azurerm_private_dns_zone.queue_sta.id]
  }
}

resource "azurerm_private_dns_zone" "queue_sta" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "queue_sa" {
  name                  = "queue"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.queue_sta.name
  virtual_network_id    = var.hub_vnet_id
}

resource "azurerm_private_endpoint" "file_endpoint" {
  name                = "file-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "file-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }

  private_dns_zone_group {
    name                 = "privatelink-file"
    private_dns_zone_ids = [azurerm_private_dns_zone.file_sta.id]
  }
}

resource "azurerm_private_dns_zone" "file_sta" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "file_sa" {
  name                  = "file"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.file_sta.name
  virtual_network_id    = var.hub_vnet_id
}

resource "azurerm_role_assignment" "sp_contributor" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Contributor"
  principal_id         = var.principal_id
}
