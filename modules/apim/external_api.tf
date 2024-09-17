
resource "azurerm_api_management_backend" "backend" {
  name                = "me"
  resource_group_name = var.resource_group_name
  api_management_name = azapi_resource.apim.name
  protocol            = "http"
  url                 = "https://carlos.mendible.com"
}

resource "azurerm_api_management_api" "me" {
  name                = "me"
  resource_group_name = var.resource_group_name
  api_management_name = azapi_resource.apim.name
  revision            = "1"
  display_name        = "me"
  path                = "me"
  protocols           = ["https"]

  subscription_required = false
}

resource "azurerm_api_management_api_operation" "me_operation" {
  operation_id        = "me"
  api_name            = azurerm_api_management_api.me.name
  api_management_name = azapi_resource.apim.name
  resource_group_name = var.resource_group_name
  display_name        = "GET"
  method              = "GET"
  url_template        = "/"
  description         = "me"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation_policy" "me_policy" {
  api_name            = azurerm_api_management_api_operation.me_operation.api_name
  api_management_name = azurerm_api_management_api_operation.me_operation.api_management_name
  resource_group_name = azurerm_api_management_api_operation.me_operation.resource_group_name
  operation_id        = azurerm_api_management_api_operation.me_operation.operation_id

  xml_content = <<XML
<policies>
  <inbound>
        <set-backend-service backend-id="${azurerm_api_management_backend.backend.name}" />
        <base />
    </inbound>
    <outbound>
        <base />
    </outbound>
    <backend>
        <forward-request timeout="60" />
    </backend>
    <on-error>
        <base />
    </on-error>
</policies>
XML
}
