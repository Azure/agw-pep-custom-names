output "private_zone_name" {
  value = azurerm_private_dns_zone.azurewebsites.name
}

output "private_ip_address" {
  value = azurerm_private_endpoint.azurewebsites_endpoint.private_service_connection[0].private_ip_address
}

output "private_fqdn" {
  value = azurerm_private_endpoint.azurewebsites_endpoint.private_dns_zone_configs[0].record_sets[0].fqdn
}

output "fqdn" {
  value = "${azurerm_linux_function_app.func_app.name}.azurewebsites.net"
}

output "scm_private_fqdn" {
  value = "${azurerm_linux_function_app.func_app.name}.scm.privatelink.azurewebsites.net"
}

output "scm_fqdn" {
  value = "${azurerm_linux_function_app.func_app.name}.scm.azurewebsites.net"
}
