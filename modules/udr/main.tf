locals {
  routes_to_firewall = var.enable_gateway_route_to_firewall ? [1] : []
  routes_to_internet = var.enable_gateway_route_to_firewall ? [] : [1]
}

# Create UDR for the service subnet
resource "azurerm_route_table" "restrict" {
  name                          = "${var.udr_name}-contoso"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false
  tags                          = var.tags

  route {
    name                   = "to-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip_address
  }

  route {
    name           = "firewall-to-internet"
    address_prefix = "${var.firewall_public_ip_address}/32"
    next_hop_type  = "Internet"
  }
}

# Attach UDR to the contoso subnet
resource "azurerm_subnet_route_table_association" "restrict_contoso" {
  subnet_id      = var.contoso_subnet_id
  route_table_id = azurerm_route_table.restrict.id
}

# Attach UDR to the contoso Tests subnet
resource "azurerm_subnet_route_table_association" "restrict_contoso_tests" {
  subnet_id      = var.contoso_tests_subnet_id
  route_table_id = azurerm_route_table.restrict.id
}

# Create UDR for the gateway subnet
resource "azurerm_route_table" "gateway" {
  name                          = "${var.udr_name}-gateway"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false
  tags                          = var.tags

  dynamic "route" {
    for_each = local.routes_to_firewall
    content {
      name                   = "to-internet"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.firewall_private_ip_address
    }
  }

  dynamic "route" {
    for_each = local.routes_to_internet
    content {
      name                   = "to-internet"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "Internet"
    }
  }

  route {
    name                   = "to-contoso"
    address_prefix         = var.contoso_address_prefixes[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip_address
  }
}

# Attach UDR to the contoso subnet
resource "azurerm_subnet_route_table_association" "gateway" {
  subnet_id      = var.gateway_subnet_id
  route_table_id = azurerm_route_table.gateway.id
}

