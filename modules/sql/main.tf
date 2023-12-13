resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@-*$&()?{}<>"
}

# Create the SQL server
resource "azurerm_mssql_server" "sql_server" {
  name                          = var.sql_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  connection_policy             = "Proxy"
  minimum_tls_version           = "1.2"
  tags                          = var.tags
  public_network_access_enabled = false
  administrator_login           = "azureadmin"
  administrator_login_password  = random_password.password.result
  azuread_administrator {
    azuread_authentication_only = false
    login_username              = var.current_user_principal_name
    object_id                   = var.current_user_object_id
  }
}

resource "azurerm_mssql_database" "db" {
  name           = "contoso"
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  sku_name       = "S0"
  zone_redundant = false

  tags = var.tags
}

resource "azurerm_mssql_server_dns_alias" "alias" {
  name            = "${var.sql_name}-alias"
  mssql_server_id = azurerm_mssql_server.sql_server.id
}

# Create the Private endpoint. This is where the SQL account gets a private IP inside the VNet
resource "azurerm_private_endpoint" "endpoint" {
  name                = "sql-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "sql-privateserviceconnection"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group {
    name                 = "privatelink-sql"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql.id]
  }
}

# SQL Private DNS Zone
resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "sql" {
  name                  = "sql"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = var.hub_vnet_id
}

resource "azurerm_role_assignment" "sp_contributor" {
  scope                = azurerm_mssql_server.sql_server.id
  role_definition_name = "SQL DB Contributor"
  principal_id         = var.principal_id
}
