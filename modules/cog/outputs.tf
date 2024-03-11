output "cognitive_service_endpoint" {
  value = azurerm_cognitive_account.this.endpoint
}

output "cognitive_service_key" {
  value = azurerm_cognitive_account.this.primary_access_key
}

output "private_zone_name" {
  value = azurerm_private_dns_zone.this.name
}

output "private_ip_address" {
  value = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
}

output "private_fqdn" {
  value = azurerm_private_endpoint.this.private_dns_zone_configs[0].record_sets[0].fqdn
}

output "fqdn" {
  value = "${azurerm_cognitive_account.this.name}.cognitiveservices.azure.com"
}