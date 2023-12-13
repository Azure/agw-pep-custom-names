resource "azurerm_network_security_group" "gateway" {
  name                = "${var.nsg_name}-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "security_rule" {
    for_each = local.private_gateway_inbound_rules
    content {
      name                       = "AllowListeners"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = [80, 443, 5671, 1433, 5432]
      source_address_prefixes    = concat(var.hub_address_space, var.spoke_address_space, var.contoso_address_space)
      destination_address_prefix = "VirtualNetwork"
    }
  }

  dynamic "security_rule" {
    for_each = local.private_gateway_inbound_rules
    content {
      name                       = "AllowLoadBalancerInBound"
      priority                   = 4095
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    }
  }

  dynamic "security_rule" {
    for_each = local.private_gateway_inbound_rules
    content {
      name                       = "DenyAllIn"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  dynamic "security_rule" {
    for_each = local.gateway_inbound_rules
    content {
      name                       = "AllowGatewayManager"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "65200-65535"
      source_address_prefix      = "GatewayManager"
      destination_address_prefix = "*"
    }
  }

  dynamic "security_rule" {
    for_each = local.gateway_inbound_rules
    content {
      name                       = "AllowLoadBalancerInBound"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    }
  }

  dynamic "security_rule" {
    for_each = local.private_gateway_inbound_rules
    content {
      name                       = "AllowBackendPools"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = [80, 443, 5671, 1433, 5432]
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    }
  }

  dynamic "security_rule" {
    for_each = local.private_gateway_inbound_rules
    content {
      name                         = "AllowDNS"
      priority                     = 101
      direction                    = "Outbound"
      access                       = "Allow"
      protocol                     = "*"
      source_port_range            = "*"
      destination_port_range       = "53"
      source_address_prefix        = "VirtualNetwork"
      destination_address_prefixes = var.hub_address_space
    }
  }

  dynamic "security_rule" {
    for_each = local.private_gateway_inbound_rules
    content {
      name                       = "DenyAllOut"
      priority                   = 4096
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_gateway_association" {
  subnet_id                 = var.gateway_subnet_id
  network_security_group_id = azurerm_network_security_group.gateway.id
}
