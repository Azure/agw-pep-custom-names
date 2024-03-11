# Resource Group Name
variable "resource_group" {
  default = "rg-agw-pep"
}

# Location
variable "location" {
  default = "westeurope"
}

# Cosmos DB database name
variable "cosmos_name" {
  default = "cosmos"
}

# Storage Account name
variable "sa_name" {
  default = "st"
}

# Azure Key Vault Name
variable "keyvault_name" {
  default = "kv"
}

# Event Hub Name
variable "eventhub_name" {
  default = "evh"
}

# Function App name
variable "func_name" {
  default = "func"
}

# Purview name
variable "purview_name" {
  default = "pview"
}

# SQL name
variable "sql_name" {
  default = "sql"
}

# postgreSQL name
variable "postgresql_name" {
  default = "psql"
}

# true to deploy a VM in the on-premises vnet  
variable "deploy_vm_on_premises" {
  default = false
}

# true to deploy Azure Purview  
variable "deploy_purview" {
  default = false
}

# true to deploy Azure SQL  
variable "deploy_sql" {
  default = true
}

# true to deploy postgreSQL  
variable "deploy_postgresql" {
  default = true
}

variable "deploy_postgresql_flexible" {
  default = false
}

# true to deploy Azure Function  
variable "deploy_function" {
  default = true
}

# true to deploy Cosmos DB
variable "deploy_cosmos" {
  default = true
}

variable "deploy_cognitive_services" {
  default = false
}

# true if TLS/TCP Proxy feature is enabled
variable "tls_tcp_proxy_enabled" {
  default = true
}

# true if Full Private Application Gateway feature is enabled
variable "private_gateway_enabled" {
  default = true
}

# true to delete them App Gateway public IP address
variable "remove_public_ip" {
  default = true
}

# true to use public FQDN for App Gateway's backednd configuration
variable "use_public_fqdn" {
  default = true
}

variable "enable_gateway_route_to_firewall" {
  default = true
}

variable "enable_gateway_key_vault_integration" {
  default = true
}

# true to remove the Gateway Manager and Load Balancer inbound rules from NSGs
variable "remove_gateway_inbound_rules" {
  default = true
}

variable "enable_network_policy_for_private_endpoints" {
  default = true
}

variable "hub_address_space" {
  default = ["10.5.0.0/16"]
}

variable "firewall_address_prefixes" {
  default = ["10.5.0.0/26"]
}

variable "dns_address_prefixes" {
  default = ["10.5.1.0/24"]
}

variable "bastion_address_prefixes" {
  default = ["10.5.2.0/27"]
}

variable "hub_jumpbox_address_prefixes" {
  default = ["10.5.3.0/24"]
}

variable "vnet_gateway_address_prefixes" {
  default = ["10.5.4.0/24"]
}

variable "spoke_address_space" {
  default = ["10.6.0.0/16"]
}

variable "gateway_address_prefixes" {
  default = ["10.6.1.0/24"]
}

variable "vnet_integration_address_prefixes" {
  default = ["10.6.2.0/24"]
}

variable "privateendpoints_address_prefixes" {
  default = ["10.6.3.0/24"]
}

variable "jumpbox_address_prefixes" {
  default = ["10.6.4.0/24"]
}

variable "flexible_server_address_prefixes" {
  default = ["10.6.5.0/24"]
}

variable "contoso_address_space" {
  default = ["192.168.0.0/16"]
}

variable "contoso_address_prefixes" {
  default = ["192.168.1.0/24"]
}

variable "contoso_tests_address_prefixes" {
  default = ["192.168.2.0/24"]
}

# Resource Tags
variable "tags" {
  default = {
    env = "contoso-application-gateway-tests"
  }
}

