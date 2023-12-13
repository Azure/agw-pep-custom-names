variable "resource_group_name" {}
variable "location" {}
variable "enable_network_policy_for_private_endpoints" {}

variable "hub_address_space" {
  default = []
}

variable "firewall_address_prefixes" {
  default = []
}

variable "dns_address_prefixes" {
  default = []
}

variable "bastion_address_prefixes" {
  default = []
}

variable "hub_jumpbox_address_prefixes" {
  default = []
}

variable "vnet_gateway_address_prefixes" {
  default = []
}

variable "spoke_address_space" {
  default = []
}

variable "gateway_address_prefixes" {
  default = []
}

variable "vnet_integration_address_prefixes" {
  default = []
}

variable "privateendpoints_address_prefixes" {
  default = []
}

variable "jumpbox_address_prefixes" {
  default = []
}

variable "flexible_server_address_prefixes" {
  default = []
}

variable "contoso_address_space" {
  default = []
}

variable "contoso_address_prefixes" {
  default = []
}

variable "contoso_tests_address_prefixes" {
  default = []
}

variable "tags" {
  default = {}
}

