# Hub VNET
resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub"
  address_space       = var.hub_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Firewall subnet
resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.firewall_address_prefixes
}

# DNS subnet
resource "azurerm_subnet" "dns" {
  name                 = "dns"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.dns_address_prefixes

  delegation {
    name = "acidelegationservice"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.bastion_address_prefixes
}

resource "azurerm_subnet" "hub_jumpbox" {
  name                 = "jumpbox"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.hub_jumpbox_address_prefixes
}

resource "azurerm_subnet" "vnet_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.vnet_gateway_address_prefixes
}

# Create spoke
resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-spoke"
  address_space       = var.spoke_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_servers         = [cidrhost(azurerm_subnet.dns.address_prefixes[0], 4)]
  tags                = var.tags
}

# Create the Subnet for Application Gateway
resource "azurerm_subnet" "gateway" {
  name                 = "gateway"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = var.gateway_address_prefixes
}

# Create the Subnet for VNET Integration
resource "azurerm_subnet" "vnet_integration" {
  name                 = "appservices"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = var.vnet_integration_address_prefixes

  private_link_service_network_policies_enabled = false

  # Delegate the subnet to "Microsoft.Web/serverFarms"
  delegation {
    name = "acctestdelegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# Create the Subnet for Private Endpoints
resource "azurerm_subnet" "privateendpoints" {
  name                                          = "privateendpoints"
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.spoke.name
  address_prefixes                              = var.privateendpoints_address_prefixes
  private_link_service_network_policies_enabled = var.enable_network_policy_for_private_endpoints
}

# Create the Subnet for Private Endpoints
resource "azurerm_subnet" "jumpbox" {
  name                                          = "jumpbox"
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.spoke.name
  address_prefixes                              = var.jumpbox_address_prefixes
  private_link_service_network_policies_enabled = false
}

# Create the Subnet for Flexible Server
resource "azurerm_subnet" "flexible_server" {
  name                                          = "flexible-server"
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.spoke.name
  address_prefixes                              = var.flexible_server_address_prefixes
  private_link_service_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Storage"
  ]

  # Delegate the subnet to "Microsoft.DBforPostgreSQL/flexibleServers"
  delegation {
    name = "flexibleserver"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# Create on-premises
resource "azurerm_virtual_network" "contoso" {
  name                = "vnet-contoso"
  address_space       = var.contoso_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_servers         = [cidrhost(azurerm_subnet.dns.address_prefixes[0], 4)]
  tags                = var.tags
}

# Create the Corp subnet
resource "azurerm_subnet" "contoso" {
  name                                          = "contoso-corp"
  virtual_network_name                          = azurerm_virtual_network.contoso.name
  resource_group_name                           = var.resource_group_name
  address_prefixes                              = var.contoso_address_prefixes
  private_link_service_network_policies_enabled = false
}

resource "azurerm_subnet" "contoso_tests" {
  name                 = "contoso-corp-tests"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.contoso.name
  address_prefixes     = var.contoso_tests_address_prefixes
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "acidelegationservice"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
