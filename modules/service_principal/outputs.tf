output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "client_id" {
  value = azuread_service_principal.sp.client_id
}

output "client_secret" {
  value = azuread_service_principal_password.sp.value
}

output "object_id" {
  value = azuread_service_principal.sp.object_id
}
