resource "random_id" "random" {
  byte_length = 8
}

data "azuread_client_config" "current" {}

data "azuread_user" "current" {
  object_id = data.azuread_client_config.current.object_id
}

module "current_public_ip" {
  source = "./modules/public_ip"
}

locals {
  name_sufix                      = substr(lower(random_id.random.hex), 1, 4)
  resource_group                  = "${var.resource_group}-${local.name_sufix}"
  storage_account_name            = "${var.sa_name}${local.name_sufix}"
  aci_storage_account_name        = "${var.sa_name}aci${local.name_sufix}"
  function_name                   = "${var.func_name}-${local.name_sufix}"
  purview_name                    = "${var.purview_name}-${local.name_sufix}"
  keyvault_name                   = "${var.keyvault_name}-${local.name_sufix}"
  cosmosdb_name                   = "${var.cosmos_name}-${local.name_sufix}"
  eventhub_name                   = "${var.eventhub_name}-${local.name_sufix}"
  sql_name                        = "${var.sql_name}-${local.name_sufix}"
  postgresql_name                 = "${var.postgresql_name}-${local.name_sufix}"
  postgresql_flexible_server_name = "${var.postgresql_name}-fs-${local.name_sufix}"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group
  location = var.location
}

module "service_principal" {
  source  = "./modules/service_principal"
  sp_name = "sp-${local.name_sufix}"
}

# Create VNETs
module "vnet" {
  source                                      = "./modules/vnet"
  resource_group_name                         = azurerm_resource_group.rg.name
  location                                    = azurerm_resource_group.rg.location
  enable_network_policy_for_private_endpoints = var.enable_network_policy_for_private_endpoints
  hub_address_space                           = var.hub_address_space
  firewall_address_prefixes                   = var.firewall_address_prefixes
  dns_address_prefixes                        = var.dns_address_prefixes
  bastion_address_prefixes                    = var.bastion_address_prefixes
  hub_jumpbox_address_prefixes                = var.hub_jumpbox_address_prefixes
  vnet_gateway_address_prefixes               = var.vnet_gateway_address_prefixes
  spoke_address_space                         = var.spoke_address_space
  gateway_address_prefixes                    = var.gateway_address_prefixes
  vnet_integration_address_prefixes           = var.vnet_integration_address_prefixes
  privateendpoints_address_prefixes           = var.privateendpoints_address_prefixes
  jumpbox_address_prefixes                    = var.jumpbox_address_prefixes
  contoso_address_space                       = var.contoso_address_space
  contoso_address_prefixes                    = var.contoso_address_prefixes
  contoso_tests_address_prefixes              = var.contoso_tests_address_prefixes
  flexible_server_address_prefixes            = var.flexible_server_address_prefixes
  tags                                        = var.tags
}

# Create DNS
module "dns" {
  source              = "./modules/bind_dns"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  bind_dns_name       = "binddns"
  dns_subnet_id       = module.vnet.subnet_dns_id
  tags                = var.tags
  depends_on = [
    module.vnet
  ]
}

# Create NSGs
module "nsg" {
  source                       = "./modules/nsg"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  nsg_name                     = "default-nsg"
  bastion_subnet_id            = module.vnet.subnet_bastion_id
  gateway_subnet_id            = module.vnet.subnet_gateway_id
  remove_gateway_inbound_rules = var.remove_gateway_inbound_rules
  hub_address_space            = var.hub_address_space
  spoke_address_space          = var.spoke_address_space
  contoso_address_space        = var.contoso_address_space
  subnet_ids = [
    module.vnet.subnet_vnet_integration_id,
    module.vnet.subnet_privateendpoints_id,
    module.vnet.subnet_jumpbox_id,
    module.vnet.subnet_hub_jumpbox_id,
    module.vnet.subnet_contoso_id,
  ]
  aci_subnet_ids = [
    module.vnet.subnet_dns_id,
    module.vnet.subnet_contoso_tests_id
  ]
  tags = var.tags
}

# Create VNET Gateway
module "vnet_gateway" {
  source              = "./modules/vnet_gateway"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = module.vnet.subnet_vnetgateway_id
  tags                = var.tags
  depends_on = [
    module.vnet,
    module.nsg
  ]
}

# Create Hub Spoke Peerings
module "hub_spoke_peering" {
  source              = "./modules/peering"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  source_network_name = module.vnet.vnet_hub_name
  source_network_id   = module.vnet.vnet_hub_id
  remote_network_name = module.vnet.vnet_spoke_name
  remote_network_id   = module.vnet.vnet_spoke_id
  depends_on = [
    module.vnet_gateway
  ]
}

# Create Hub Customer Peerings
module "hub_customer_peering" {
  source              = "./modules/peering"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  source_network_name = module.vnet.vnet_hub_name
  source_network_id   = module.vnet.vnet_hub_id
  remote_network_name = module.vnet.vnet_customer_name
  remote_network_id   = module.vnet.vnet_customer_id
  depends_on = [
    module.vnet_gateway,
    module.hub_spoke_peering
  ]
}

# Create Firewall
module "firewall" {
  source                   = "./modules/firewall"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  firewall_name            = "afw-contoso"
  firewall_subnet_id       = module.vnet.subnet_firewall_id
  gateway_address_prefixes = module.vnet.subnet_gateway_address_prefixes
  dns_address_prefixes     = module.vnet.subnet_dns_address_prefixes
  contoso_address_prefixes = module.vnet.vnet_contoso_address_space
  tags                     = var.tags
  depends_on = [
    module.nsg,
    module.hub_spoke_peering,
    module.hub_customer_peering,
  ]
}

# Create UDRs
module "udr" {
  source                           = "./modules/udr"
  resource_group_name              = azurerm_resource_group.rg.name
  location                         = azurerm_resource_group.rg.location
  udr_name                         = "udr"
  firewall_private_ip_address      = module.firewall.firewall_private_ip_address
  firewall_public_ip_address       = module.firewall.firewall_public_ip_address
  contoso_subnet_id                = module.vnet.subnet_contoso_id
  contoso_tests_subnet_id          = module.vnet.subnet_contoso_tests_id
  contoso_address_prefixes         = module.vnet.vnet_contoso_address_space
  gateway_subnet_id                = module.vnet.subnet_gateway_id
  spoke_address_prefixes           = module.vnet.vnet_spoke_address_space
  enable_gateway_route_to_firewall = var.enable_gateway_route_to_firewall
  tags                             = var.tags
}

# Create Azure Bastion
module "bastion" {
  count                  = var.deploy_vm_on_premises ? 1 : 0
  source                 = "./modules/bastion"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  azurebastion_name      = "bas-contoso"
  azurebastion_subnet_id = module.vnet.subnet_bastion_id
  tags                   = var.tags
  depends_on = [
    module.vnet,
    module.firewall
  ]
}

# Create Azure Key Vault 
module "keyvault" {
  source                        = "./modules/keyvault"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  principal_id                  = module.service_principal.object_id
  keyvault_name                 = local.keyvault_name
  private_endpoints_subnet_id   = module.vnet.subnet_privateendpoints_id
  hub_vnet_id                   = module.vnet.vnet_hub_id
  public_ip                     = module.current_public_ip.ip
  gateway_identity_principal_id = module.app_gateway_identity.principal_id
  tags                          = var.tags
  depends_on = [
    module.dns,
    module.nsg
  ]
}

# Create CosmosDB
module "cosmosdb" {
  count                       = var.deploy_cosmos ? 1 : 0
  source                      = "./modules/cosmosdb"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  principal_id                = module.service_principal.object_id
  cosmosdb_name               = local.cosmosdb_name
  private_endpoints_subnet_id = module.vnet.subnet_privateendpoints_id
  hub_vnet_id                 = module.vnet.vnet_hub_id
  tags                        = var.tags
  depends_on = [
    module.dns,
    module.nsg
  ]
}

# Create Storage Account
module "storage" {
  source                      = "./modules/storage"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  principal_id                = module.service_principal.object_id
  storage_account_name        = local.storage_account_name
  private_endpoints_subnet_id = module.vnet.subnet_privateendpoints_id
  hub_vnet_id                 = module.vnet.vnet_hub_id
  public_ip                   = module.current_public_ip.ip
  tags                        = var.tags
  depends_on = [
    module.dns,
    module.nsg
  ]
}

# Create Event Hub
module "eventhub" {
  source                      = "./modules/eventhub"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  principal_id                = module.service_principal.object_id
  eventhub_name               = local.eventhub_name
  private_endpoints_subnet_id = module.vnet.subnet_privateendpoints_id
  hub_vnet_id                 = module.vnet.vnet_hub_id
  tags                        = var.tags
  depends_on = [
    module.dns,
    module.nsg
  ]
}

# Create Function
module "function" {
  count                             = var.deploy_function ? 1 : 0
  source                            = "./modules/function"
  resource_group_name               = azurerm_resource_group.rg.name
  location                          = azurerm_resource_group.rg.location
  function_name                     = local.function_name
  storage_name                      = module.storage.name
  storage_primary_connection_string = module.storage.primary_connection_string
  storage_primary_access_key        = module.storage.primary_access_key
  storage_content_share_name        = module.storage.content_share_name
  vnet_integration_subnet_id        = module.vnet.vnet_integration_id
  private_endpoints_subnet_id       = module.vnet.subnet_privateendpoints_id
  hub_vnet_id                       = module.vnet.vnet_hub_id
  name_server_ip                    = module.dns.ip_address
  tags                              = var.tags
  depends_on = [
    module.dns,
    module.nsg
  ]
}

# Create Purview
module "purview" {
  count                       = var.deploy_purview ? 1 : 0
  source                      = "./modules/purview"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  purview_name                = local.purview_name
  private_endpoints_subnet_id = module.vnet.subnet_privateendpoints_id
  hub_vnet_id                 = module.vnet.vnet_hub_id
  evh_private_dns_zone_id     = module.eventhub.private_zone_id
  sta_private_dns_zone_id     = module.storage.private_zone_id
  tags                        = var.tags
  depends_on = [
    module.dns,
    module.nsg
  ]
}

# Create SQL
module "sql" {
  count                       = var.deploy_sql ? 1 : 0
  source                      = "./modules/sql"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  sql_name                    = local.sql_name
  private_endpoints_subnet_id = module.vnet.subnet_privateendpoints_id
  hub_vnet_id                 = module.vnet.vnet_hub_id
  principal_id                = module.service_principal.object_id
  current_user_object_id      = data.azuread_client_config.current.object_id
  current_user_principal_name = data.azuread_user.current.user_principal_name
  tags                        = var.tags
  depends_on = [
    module.dns,
    module.nsg
  ]
}

# Create postgreSQL
module "postgresql" {
  count                       = var.deploy_postgresql ? 1 : 0
  source                      = "./modules/postgresql"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  postgresql_name             = local.postgresql_name
  private_endpoints_subnet_id = module.vnet.subnet_privateendpoints_id
  hub_vnet_id                 = module.vnet.vnet_hub_id
  spoke_vnet_id               = module.vnet.vnet_spoke_id
  public_ip                   = module.current_public_ip.ip
  tenant_id                   = data.azuread_client_config.current.tenant_id
  current_user_object_id      = data.azuread_client_config.current.object_id
  current_user_principal_name = data.azuread_user.current.user_principal_name
  tags                        = var.tags
  depends_on = [
    module.dns,
    module.nsg
  ]
}

# Create postgreSQL Flexible Server
module "postgresql_flexible_server" {
  count                                = var.deploy_postgresql_flexible ? 1 : 0
  source                               = "./modules/postgresql_flexible_server"
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  postgresql_name                      = local.postgresql_flexible_server_name
  postgresql_flexible_server_subnet_id = module.vnet.subnet_flexible_server_id
  postgre_sql_dns_zone_id              = var.deploy_postgresql_flexible ? module.postgresql[0].private_zone_id : ""
  public_ip                            = module.current_public_ip.ip
  tenant_id                            = data.azuread_client_config.current.tenant_id
  current_user_object_id               = data.azuread_client_config.current.object_id
  current_user_principal_name          = data.azuread_user.current.user_principal_name
  tags                                 = var.tags
  depends_on = [
    module.dns,
    module.nsg,
    module.postgresql
  ]
}

# Create App Gateway Identity
module "app_gateway_identity" {
  source                = "./modules/managed_identity"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  managed_identity_name = "appgateway"
}

# Create Application Gateway 
module "app_gateway" {
  source                               = "./modules/app_gateway"
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  gateway_identity_id                  = module.app_gateway_identity.id
  hub_vnet_id                          = module.vnet.vnet_hub_id
  gateway_name                         = "agw-contoso"
  gateway_subnet_id                    = module.vnet.subnet_gatway_id
  gateway_subnet_address_prefix        = module.vnet.subnet_gateway_address_prefixes[0]
  private_gateway_enabled              = var.private_gateway_enabled
  remove_public_ip                     = var.remove_public_ip
  use_public_fqdn                      = var.use_public_fqdn
  enable_gateway_key_vault_integration = var.enable_gateway_key_vault_integration
  storage_account_fqdn                 = module.storage.fqdn
  storage_account_private_fqdn         = module.storage.private_fqdn
  storage_account_private_ip_address   = module.storage.private_ip_address
  eventhub_fqdn                        = module.eventhub.fqdn
  eventhub_private_fqdn                = module.eventhub.private_fqdn
  eventhub_private_ip_address          = module.eventhub.private_ip_address
  cosmosdb_fqdn                        = var.deploy_cosmos ? module.cosmosdb[0].fqdn : ""
  cosmosdb_private_fqdn                = var.deploy_cosmos ? module.cosmosdb[0].private_fqdn : ""
  cosmosdb_private_ip_address          = var.deploy_cosmos ? module.cosmosdb[0].private_ip_address : ""
  deploy_cosmos                        = var.deploy_cosmos
  keyvault_id                          = module.keyvault.id
  keyvault_fqdn                        = module.keyvault.fqdn
  keyvault_private_fqdn                = module.keyvault.private_fqdn
  keyvault_private_ip_address          = module.keyvault.private_ip_address
  function_fqdn                        = var.deploy_function ? module.function[0].fqdn : ""
  function_private_fqdn                = var.deploy_function ? module.function[0].private_fqdn : ""
  function_scm_fqdn                    = var.deploy_function ? module.function[0].scm_fqdn : ""
  function_scm_private_fqdn            = var.deploy_function ? module.function[0].scm_private_fqdn : ""
  function_private_ip_address          = var.deploy_function ? module.function[0].private_ip_address : ""
  deploy_function                      = var.deploy_function
  purview_account_fqdn                 = var.deploy_purview ? module.purview[0].account_fqdn : ""
  purview_account_private_fqdn         = var.deploy_purview ? module.purview[0].account_private_fqdn : ""
  purview_portal_fqdn                  = var.deploy_purview ? module.purview[0].portal_fqdn : ""
  purview_portal_private_fqdn          = var.deploy_purview ? module.purview[0].portal_private_fqdn : ""
  deploy_purview                       = var.deploy_purview
  sql_fqdn                             = var.deploy_sql ? module.sql[0].fqdn : ""
  sql_private_fqdn                     = var.deploy_sql ? module.sql[0].private_fqdn : ""
  deploy_sql                           = var.deploy_sql
  postgresql_fqdn                      = var.deploy_postgresql ? module.postgresql[0].fqdn : ""
  postgresql_private_fqdn              = var.deploy_postgresql ? module.postgresql[0].private_fqdn : ""
  deploy_postgresql                    = var.deploy_postgresql
  tls_tcp_proxy_enabled                = var.tls_tcp_proxy_enabled
  tags                                 = var.tags
  depends_on = [
    module.hub_spoke_peering,
    module.hub_customer_peering,
    module.udr
  ]
}

# Create TCP Listeners
module "app_gateway_tcp" {
  source                = "./modules/app_gateway_tcp"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  tls_tcp_proxy_enabled = var.tls_tcp_proxy_enabled
  gateway_name          = module.app_gateway.name
  eventhub_fqdn         = module.eventhub.fqdn
  sql_fqdn              = var.deploy_sql ? module.sql[0].fqdn : ""
  postgresql_fqdn       = var.deploy_postgresql ? module.postgresql[0].fqdn : ""
}

# Create VM
module "contoso_vm" {
  count               = var.deploy_vm_on_premises ? 1 : 0
  source              = "./modules/win_vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_name             = "dc01"
  contoso_subnet_id   = module.vnet.subnet_contoso_id
  tags                = var.tags
  depends_on = [
    module.bastion
  ]
}

# Create on-premises test container
module "onpremises_tests" {
  source                       = "./modules/onpremises_tests"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  contaner_group_name          = "ci-onpremises-tests"
  aci_storage_account_name     = local.aci_storage_account_name
  tenant_id                    = module.service_principal.tenant_id
  client_id                    = module.service_principal.client_id
  client_secret                = module.service_principal.client_secret
  subnet_id                    = module.vnet.subnet_contoso_tests_id
  name_server_ip               = module.dns.ip_address
  public_ip                    = module.current_public_ip.ip
  tls_tcp_proxy_enabled        = var.tls_tcp_proxy_enabled
  tags                         = var.tags
  gateway_private_ip           = module.app_gateway.private_ip_address
  storage_account_name         = "sta.contoso.corp"
  eventhub_namespace           = module.eventhub.fqdn
  eventhub_name                = "acceptancetesteventhub"
  eventhub_custom_endpoint     = "evh.contoso.corp"
  keyvault_name                = "kv.contoso.corp"
  cosmosdb_key                 = var.deploy_cosmos ? module.cosmosdb[0].key : ""
  cosmosdb_custom_endpoint     = var.deploy_cosmos ? "cosmos.contoso.corp" : ""
  function_custom_endpoint     = var.deploy_function ? "function.contoso.corp" : ""
  function_scm_custom_endpoint = var.deploy_function ? "functionscm.contoso.corp" : ""
  sql_name                     = var.deploy_sql ? "sql.contoso.corp" : ""
  sql_server_name              = var.deploy_sql ? module.sql[0].server_name : ""
  sql_password                 = var.deploy_sql ? module.sql[0].password : ""
  postgresql_name              = var.deploy_postgresql ? "postgresql.contoso.corp" : ""
  postgresql_password          = var.deploy_postgresql ? module.postgresql[0].password : ""
  postgresql_server_name       = var.deploy_postgresql ? module.postgresql[0].server_name : ""

  depends_on = [
    module.app_gateway,
    module.app_gateway_tcp,
    module.udr
  ]
}
