# Create a public Ip for the firewall
resource "azurerm_public_ip" "firewall_public_ip" {
  name                = "fw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_tags             = {}
  zones               = ["1", "2", "3"]
  tags                = var.tags
}

# Create the firewall
resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  firewall_policy_id  = azurerm_firewall_policy.policy.id
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  tags                = var.tags
  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
  depends_on = [
    azurerm_firewall_policy_rule_collection_group.policies
  ]
}

resource "azurerm_firewall_policy" "policy" {
  name                = "firewall-policy"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  dns {
    proxy_enabled = true
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "policies" {
  name               = "contoso"
  firewall_policy_id = azurerm_firewall_policy.policy.id
  priority           = 100

  network_rule_collection {
    name     = "to-dns"
    priority = 100
    action   = "Allow"
    rule {
      name                  = "dns"
      source_addresses      = ["*"]
      destination_ports     = [53]
      destination_addresses = var.dns_address_prefixes
      protocols             = ["TCP"]
    }
  }

  network_rule_collection {
    name     = "to-app-gateway"
    priority = 200
    action   = "Allow"
    rule {
      name                  = "to-app-gateway"
      source_addresses      = var.contoso_address_prefixes
      destination_ports     = [80, 443, 5671, 5672, 1433, 5432]
      destination_addresses = var.gateway_address_prefixes
      protocols             = ["TCP"]
    }
  }

  network_rule_collection {
    name     = "to-internet"
    priority = 300
    action   = "Allow"
    rule {
      name                  = "to-internet"
      source_addresses      = var.contoso_address_prefixes
      destination_ports     = ["*"]
      destination_addresses = ["0.0.0.0/0"]
      protocols             = ["TCP"]
    }
  }
}
