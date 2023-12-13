variable "resource_group_name" {}
variable "location" {}
variable "purview_name" {}
variable "private_endpoints_subnet_id" {}
variable "hub_vnet_id" {}
variable "evh_private_dns_zone_id" {}
variable "sta_private_dns_zone_id" {}
variable "tags" {
  default = {}
}