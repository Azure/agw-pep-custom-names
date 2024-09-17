locals {
  gateway_inbound_rules         = var.remove_gateway_inbound_rules ? [] : [1]
  private_gateway_inbound_rules = var.remove_gateway_inbound_rules ? [1] : []
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "AllowPrivateEndpoints"
    priority                   = 3096
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = ["10.6.2.0/24", "10.6.6.0/24"]
    destination_address_prefix = "10.6.3.0/24"
  }

  security_rule {
    name                       = "DenyPrivateEndpoints"
    priority                   = 4096
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.6.3.0/24"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count                     = length(var.subnet_ids)
  subnet_id                 = var.subnet_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}
