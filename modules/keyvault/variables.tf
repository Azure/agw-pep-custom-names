variable "resource_group_name" {}
variable "location" {}
variable "keyvault_name" {}
variable "principal_id" {}
variable "private_endpoints_subnet_id" {}
variable "hub_vnet_id" {}
variable "public_ip" {}
variable "gateway_identity_principal_id" {}
variable "tags" {
  default = {}
}