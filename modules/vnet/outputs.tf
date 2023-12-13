output "subnet_dns_id" {
  value = azurerm_subnet.dns.id
}

output "subnet_bastion_id" {
  value = azurerm_subnet.bastion.id
}

output "subnet_gateway_id" {
  value = azurerm_subnet.gateway.id
}

output "subnet_firewall_id" {
  value = azurerm_subnet.firewall.id
}

output "subnet_gateway_address_prefixes" {
  value = azurerm_subnet.gateway.address_prefixes
}

output "subnet_dns_address_prefixes" {
  value = azurerm_subnet.dns.address_prefixes
}

output "vnet_contoso_address_space" {
  value = azurerm_virtual_network.contoso.address_space
}

output "subnet_contoso_id" {
  value = azurerm_subnet.contoso.id
}

output "subnet_contoso_tests_id" {
  value = azurerm_subnet.contoso_tests.id
}

output "subnet_gatway_id" {
  value = azurerm_subnet.gateway.id
}

output "vnet_spoke_address_space" {
  value = azurerm_virtual_network.spoke.address_space
}

output "subnet_privateendpoints_id" {
  value = azurerm_subnet.privateendpoints.id
}

output "subnet_flexible_server_id" {
  value = azurerm_subnet.flexible_server.id
}

output "vnet_hub_id" {
  value = azurerm_virtual_network.hub.id
}

output "vnet_integration_id" {
  value = azurerm_subnet.vnet_integration.id
}

output "subnet_hub_jumpbox_id" {
  value = azurerm_subnet.hub_jumpbox.id
}

output "subnet_jumpbox_id" {
  value = azurerm_subnet.jumpbox.id
}

output "subnet_vnet_integration_id" {
  value = azurerm_subnet.vnet_integration.id
}

output "vnet_hub_name" {
  value = azurerm_virtual_network.hub.name
}

output "vnet_spoke_id" {
  value = azurerm_virtual_network.spoke.id
}

output "vnet_spoke_name" {
  value = azurerm_virtual_network.spoke.name
}

output "vnet_customer_name" {
  value = azurerm_virtual_network.contoso.name
}

output "vnet_customer_id" {
  value = azurerm_virtual_network.contoso.id
}

output "subnet_vnetgateway_id" {
  value = azurerm_subnet.vnet_gateway.id
}



