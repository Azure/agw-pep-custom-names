locals {
  logger_name = "openai-appi-logger"
}

resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = "Developer_1"
  identity {
    type = "SystemAssigned"
  }
  virtual_network_type = "External"
  virtual_network_configuration {
    subnet_id = var.apim_subnet_id
  }
}

resource "azurerm_api_management_logger" "appi_logger" {
  name                = local.logger_name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name
  resource_id         = var.appi_resource_id

  application_insights {
    instrumentation_key = var.appi_instrumentation_key
  }
}
