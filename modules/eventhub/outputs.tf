output "private_zone_name" {
  value = azurerm_private_dns_zone.evh.name
}

output "private_zone_id" {
  value = azurerm_private_dns_zone.evh.id
}

output "private_ip_address" {
  value = azurerm_private_endpoint.evh_endpoint.private_service_connection[0].private_ip_address
}

output "private_fqdn" {
  value = azurerm_private_endpoint.evh_endpoint.private_dns_zone_configs[0].record_sets[0].fqdn
}

output "fqdn" {
  value = "${azurerm_eventhub_namespace.evh.name}.servicebus.windows.net"
}

output "name" {
  value = var.eventhub_name
}
