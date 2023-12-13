resource "azurerm_eventhub_namespace" "evh" {
  name                = var.eventhub_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1
  tags                = var.tags

  network_rulesets {
    default_action                 = "Deny"
    trusted_service_access_enabled = true
    ip_rule {
      ip_mask = "0.0.0.0"
    }
  }

  lifecycle {
    ignore_changes = [
      network_rulesets
    ]
  }
}

resource "azurerm_eventhub" "hub" {
  name                = "acceptancetesteventhub"
  namespace_name      = azurerm_eventhub_namespace.evh.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}

# Create the Private endpoint. This is where the Storage account gets a private IP inside the VNet.
resource "azurerm_private_endpoint" "evh_endpoint" {
  name                = "evh-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "evh-privateserviceconnection"
    private_connection_resource_id = azurerm_eventhub_namespace.evh.id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }

  private_dns_zone_group {
    name                 = "privatelink-evh"
    private_dns_zone_ids = [azurerm_private_dns_zone.evh.id]
  }
}

# Create the privatelink.file.core.windows.net Private DNS Zone
resource "azurerm_private_dns_zone" "evh" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "evh" {
  name                  = "evh"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.evh.name
  virtual_network_id    = var.hub_vnet_id
}

resource "azurerm_role_assignment" "sp_contributor" {
  scope                = azurerm_eventhub_namespace.evh.id
  role_definition_name = "Azure Event Hubs Data Owner"
  principal_id         = var.principal_id
}
