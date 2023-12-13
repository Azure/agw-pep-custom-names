variable "resource_group_name" {}
variable "location" {}
variable "firewall_name" {}
variable "firewall_subnet_id" {}
variable "gateway_address_prefixes" {}
variable "dns_address_prefixes" {
  default = []
}
variable "contoso_address_prefixes" {
  default = []
}
variable "tags" {
  default = {}
}