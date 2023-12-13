output "private_ip_address" {
  value = local.private_ip_address
}

output "name" {
  value = azurerm_application_gateway.gateway.name
}
