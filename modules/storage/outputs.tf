output "name" {
  value = azurerm_storage_account.sa.name
}

output "primary_access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}

output "primary_connection_string" {
  value = azurerm_storage_account.sa.primary_connection_string
}

output "content_share_name" {
  value = azurerm_storage_share.content_share.name
}

output "private_zone_name" {
  value = azurerm_private_dns_zone.sta.name
}

output "private_zone_id" {
  value = azurerm_private_dns_zone.sta.id
}

output "private_ip_address" {
  value = azurerm_private_endpoint.endpoint.private_service_connection[0].private_ip_address
}

output "private_fqdn" {
  value = azurerm_private_endpoint.endpoint.private_dns_zone_configs[0].record_sets[0].fqdn
}

output "fqdn" {
  value = "${azurerm_storage_account.sa.name}.blob.core.windows.net"
}
