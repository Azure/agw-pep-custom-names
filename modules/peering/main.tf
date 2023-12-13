# Azure Virtual Network peering between Virtual Network A and B
resource "azurerm_virtual_network_peering" "peer_a_to_b" {
  name                         = "${var.source_network_name}-${var.remote_network_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.source_network_name
  remote_virtual_network_id    = var.remote_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

# Azure Virtual Network peering between Virtual Network B and A
resource "azurerm_virtual_network_peering" "peer_b_to_a" {
  name                         = "${var.remote_network_name}-${var.source_network_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.remote_network_name
  remote_virtual_network_id    = var.source_network_id
  allow_virtual_network_access = true
  use_remote_gateways          = true
  depends_on = [
    azurerm_virtual_network_peering.peer_a_to_b
  ]
}
