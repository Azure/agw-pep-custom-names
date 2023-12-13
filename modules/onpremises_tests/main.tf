resource "azurerm_container_group" "tests" {
  name                = var.contaner_group_name
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_address_type     = "Private"
  os_type             = "Linux"
  subnet_ids          = [var.subnet_id]
  tags                = var.tags
  zones               = []

  dns_config {
    nameservers    = [var.name_server_ip]
    options        = []
    search_domains = []
  }

  container {
    name     = "${var.contaner_group_name}-container"
    image    = "cmendibl3/aurora"
    cpu      = "1.0"
    memory   = "1.0"
    commands = []

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {
      "GATEWAY_IP"                    = var.gateway_private_ip
      "TLS_TCP_PROXY_ENABLED"         = var.tls_tcp_proxy_enabled ? "1" : "0"
      "STORAGE_ACCOUNT_NAME"          = var.storage_account_name
      "EVENT_HUB_NAMESPACE"           = var.eventhub_namespace
      "EVENT_HUB_NAME"                = var.eventhub_name
      "EVENT_HUB_CUSTOM_ENDPOINT"     = var.eventhub_custom_endpoint
      "KEY_VAULT_NAME"                = var.keyvault_name
      "COSMOS_DB_CUSTOM_ENDPOINT"     = var.cosmosdb_custom_endpoint
      "FUNCTION_CUSTOM_ENDPOINT"      = var.function_custom_endpoint
      "FUNCTION_KUDU_CUSTOM_ENDPOINT" = var.function_scm_custom_endpoint
      "SQL_NAME"                      = var.sql_name
      "SQL_SERVER_NAME"               = var.sql_server_name
      "POSTGRESQL_NAME"               = var.postgresql_name
      "POSTGRESQL_SERVER_NAME"        = var.postgresql_server_name
    }

    secure_environment_variables = {
      "AZURE_TENANT_ID"     = var.tenant_id
      "AZURE_CLIENT_ID"     = var.client_id
      "AZURE_CLIENT_SECRET" = var.client_secret
      "COSMOS_DB_KEY"       = var.cosmosdb_key
      "SQL_PASSWORD"        = var.sql_password
      "POSTGRESQL_PASSWORD" = var.postgresql_password
    }

    volume {
      name                 = "filesharevolume"
      mount_path           = "/src/TestResults"
      share_name           = azurerm_storage_share.content_share.name
      storage_account_key  = azurerm_storage_account.sa.primary_access_key
      storage_account_name = azurerm_storage_account.sa.name
    }
  }
}
