output "id" {
  value = azurerm_key_vault.kv.id
}

output "private_zone_name" {
  value = azurerm_private_dns_zone.kv.name
}

output "private_ip_address" {
  value = azurerm_private_endpoint.kv_endpoint.private_service_connection[0].private_ip_address
}

output "private_fqdn" {
  value = azurerm_private_endpoint.kv_endpoint.private_dns_zone_configs[0].record_sets[0].fqdn
}

output "fqdn" {
  value = "${azurerm_key_vault.kv.name}.vault.azure.net"
}

output "name" {
  value = var.keyvault_name
}
