variable "resource_group_name" {}
variable "location" {}
variable "postgresql_name" {}
variable "private_endpoints_subnet_id" {}
variable "hub_vnet_id" {}
variable "spoke_vnet_id" {}
variable "public_ip" {}
variable "tenant_id" {}
variable "current_user_object_id" {}
variable "current_user_principal_name" {}
variable "tags" {
  default = {}
}