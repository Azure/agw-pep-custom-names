data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  tags                        = var.tags

  sku_name = "standard"

  network_acls {
    default_action = "Deny"
    # This is required by Application Gateway for Key Vault references. 
    bypass = "AzureServices"
    ip_rules = [
      var.public_ip
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete",
      "Purge",
    ]

    certificate_permissions = [
      "Backup",
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "Purge",
      "Recover",
      "Restore",
      "SetIssuers",
      "Update"
    ]

    key_permissions     = []
    storage_permissions = []
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.principal_id

    secret_permissions = [
      "Get",
      "Set",
      "List",
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.gateway_identity_principal_id

    secret_permissions = [
      "Get",
      "List",
    ]
  }
}

resource "azurerm_key_vault_secret" "secret" {
  name            = "secret-value"
  value           = "one europe"
  key_vault_id    = azurerm_key_vault.kv.id
  content_type    = "password"
  expiration_date = "2030-12-31T00:00:00Z"
}

resource "azurerm_private_endpoint" "kv_endpoint" {
  name                = "kv-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "kv-privateserviceconnection"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "privatelink-kv"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv.id]
  }
}

# Create the privatelink.file.core.windows.net Private DNS Zone
resource "azurerm_private_dns_zone" "kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "kv" {
  name                  = "kv"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.kv.name
  virtual_network_id    = var.hub_vnet_id
}
