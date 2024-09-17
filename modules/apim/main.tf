locals {
  logger_name = "openai-appi-logger"
}

resource "azapi_resource" "apim" {
  type      = "Microsoft.ApiManagement/service@2023-03-01-preview"
  name      = var.apim_name
  parent_id = var.resource_group_id
  location  = var.location
  identity {
    type = "SystemAssigned"
  }
  schema_validation_enabled = false # requiered for now
  body = {
    sku = {
      name     = "StandardV2"
      capacity = 1
    }
    zones = []
    properties = {
      publisherEmail        = var.publisher_email
      publisherName         = var.publisher_name
      apiVersionConstraint  = {}
      developerPortalStatus = "Disabled"
      virtualNetworkType    = "External"
      virtualNetworkConfiguration = {
        subnetResourceId = var.apim_subnet_id
      }
    }
  }
  response_export_values = [
    "identity.principalId",
    "properties.gatewayUrl"
  ]
}

resource "azurerm_api_management_logger" "appi_logger" {
  name                = local.logger_name
  api_management_name = azapi_resource.apim.name
  resource_group_name = var.resource_group_name
  resource_id         = var.appi_resource_id

  application_insights {
    instrumentation_key = var.appi_instrumentation_key
  }
}
