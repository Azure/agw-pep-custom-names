resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_postgresql_flexible_server" "server" {
  name                   = var.postgresql_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "12"
  delegated_subnet_id    = var.postgresql_flexible_server_subnet_id
  private_dns_zone_id    = var.postgre_sql_dns_zone_id
  administrator_login    = "azureadmin"
  administrator_password = random_password.password.result
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "GP_Standard_D4s_v3"
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = "exampledb"
  server_id = azurerm_postgresql_flexible_server.server.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "terraform_host" {
  name             =  "terraform-host"
  server_id        = azurerm_postgresql_flexible_server.server.id
  start_ip_address = var.public_ip
  end_ip_address   = var.public_ip
}
