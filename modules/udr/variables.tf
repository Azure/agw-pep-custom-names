variable "resource_group_name" {}
variable "location" {}
variable "udr_name" {}
variable "firewall_private_ip_address" {}
variable "firewall_public_ip_address" {}
variable "contoso_subnet_id" {}
variable "contoso_tests_subnet_id" {}
variable "contoso_address_prefixes" {}
variable "spoke_address_prefixes" {}
variable "gateway_subnet_id" {}
variable "enable_gateway_route_to_firewall" {}
variable "tags" {
  default = {}
}