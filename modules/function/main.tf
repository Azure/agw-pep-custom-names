# Create the Azure Function plan (Elastic Premium) 
resource "azurerm_service_plan" "plan" {
  name                = "asp-${var.function_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  os_type             = "Linux"
  sku_name            = "EP1"
  worker_count        = 1
}

# Create Application Insights
resource "azurerm_application_insights" "ai" {
  name                = "appi-${var.function_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  retention_in_days   = 90
  tags                = var.tags
}

resource "azurerm_linux_function_app" "func_app" {
  name                                           = var.function_name
  location                                       = var.location
  resource_group_name                            = var.resource_group_name
  service_plan_id                                = azurerm_service_plan.plan.id
  storage_account_name                           = var.storage_name
  storage_account_access_key                     = var.storage_primary_access_key
  functions_extension_version                    = "~4"
  https_only                                     = true
  virtual_network_subnet_id                      = var.vnet_integration_subnet_id
  tags                                           = var.tags
  ftp_publish_basic_authentication_enabled       = false
  webdeploy_publish_basic_authentication_enabled = false
  public_network_access_enabled                  = false

  site_config {
    application_insights_key               = azurerm_application_insights.ai.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.ai.connection_string
    remote_debugging_enabled               = false
    remote_debugging_version               = "VS2022"
    vnet_route_all_enabled                 = true
    runtime_scale_monitoring_enabled       = true
    application_stack {
      node_version = "16"
    }
  }

  app_settings = {
    https_only                               = true
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = var.storage_primary_connection_string
    WEBSITE_CONTENTSHARE                     = var.storage_content_share_name
    WEBSITE_CONTENTOVERVNET                  = "1"
    WEBSITE_DNS_SERVER                       = var.name_server_ip
    SCM_DO_BUILD_DURING_DEPLOYMENT           = false
    WEBSITE_RUN_FROM_PACKAGE                 = 1
    # FUNCTIONS_WORKER_PROCESS_COUNT           = "1"
  }
}

# Create the privatelink.azurewebsites.net Private DNS Zone
resource "azurerm_private_dns_zone" "azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Create the Private endpoint.
resource "azurerm_private_endpoint" "azurewebsites_endpoint" {
  name                = "azurewebsites-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "azurewebsites-privateserviceconnection"
    private_connection_resource_id = azurerm_linux_function_app.func_app.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "privatelink-azurewebsites"
    private_dns_zone_ids = [azurerm_private_dns_zone.azurewebsites.id]
  }
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites" {
  name                  = "azurewebsites"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.azurewebsites.name
  virtual_network_id    = var.hub_vnet_id
}
