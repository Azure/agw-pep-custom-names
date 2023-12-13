output "private_zone_name" {
  value = azurerm_private_dns_zone.cosmos.name
}

output "private_ip_address" {
  value = azurerm_private_endpoint.cosmosdb_endpoint.private_service_connection[0].private_ip_address
}

output "private_fqdn" {
  value = azurerm_private_endpoint.cosmosdb_endpoint.private_dns_zone_configs[0].record_sets[0].fqdn
}

output "fqdn" {
  value = "${azurerm_cosmosdb_account.db.name}.documents.azure.com"
}

output "key" {
  value = azurerm_cosmosdb_account.db.primary_key
}
