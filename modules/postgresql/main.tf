resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_postgresql_server" "server" {
  name                = var.postgresql_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name = "GP_Gen5_4"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login              = "azureadmin"
  administrator_login_password     = random_password.password.result
  version                          = "11"
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"

  threat_detection_policy {
    disabled_alerts      = []
    email_account_admins = false
    email_addresses      = []
    enabled              = true
    retention_days       = 0
  }
}

resource "azurerm_postgresql_active_directory_administrator" "admin" {
  server_name         = azurerm_postgresql_server.server.name
  resource_group_name = var.resource_group_name
  login               = var.current_user_principal_name
  tenant_id           = var.tenant_id
  object_id           = var.current_user_object_id
}

resource "azurerm_postgresql_database" "db" {
  name                = "exampledb"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "terraform_host" {
  name                = "terraform-host"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  start_ip_address    = var.public_ip
  end_ip_address      = var.public_ip
}

# Create the Private endpoint. This is where the SQL account gets a private IP inside the VNet
resource "azurerm_private_endpoint" "endpoint" {
  name                = "postgresql-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "postgresql-privateserviceconnection"
    private_connection_resource_id = azurerm_postgresql_server.server.id
    is_manual_connection           = false
    subresource_names              = ["postgresqlServer"]
  }

  private_dns_zone_group {
    name                 = "privatelink-postgresql"
    private_dns_zone_ids = [azurerm_private_dns_zone.postgresql.id]
  }
}

# Private DNS Zone
resource "azurerm_private_dns_zone" "postgresql" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "postgresql" {
  name                  = "postgresql"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = var.hub_vnet_id
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "postgresql_flexible_server" {
  name                  = "postgresql_flexible_server"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = var.spoke_vnet_id
}
