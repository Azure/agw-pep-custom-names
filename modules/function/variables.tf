variable "resource_group_name" {}
variable "location" {}
variable "function_name" {}
variable "storage_name" {}
variable "storage_primary_connection_string" {}
variable "storage_primary_access_key" {}
variable "storage_content_share_name" {}
variable "vnet_integration_subnet_id" {}
variable "private_endpoints_subnet_id" {}
variable "hub_vnet_id" {}
variable "name_server_ip" {}
variable "tags" {
  default = {}
}