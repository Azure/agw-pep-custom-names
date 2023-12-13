data "azurerm_client_config" "current" {}

resource "azuread_application" "sp" {
  display_name = var.sp_name
  owners = [
    data.azurerm_client_config.current.object_id
  ]
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application.sp.client_id
  owners = [
    data.azurerm_client_config.current.object_id
  ]
}

resource "azuread_service_principal_password" "sp" {
  service_principal_id = azuread_service_principal.sp.id
  end_date             = "2099-01-01T00:00:00Z"
}
