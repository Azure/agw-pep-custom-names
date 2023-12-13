variable "resource_group_name" {}
variable "location" {}
variable "nsg_name" {}
variable "bastion_subnet_id" {}
variable "gateway_subnet_id" {}
variable "remove_gateway_inbound_rules" {}
variable "spoke_address_space" {
  default = []
}
variable "hub_address_space" {
  default = []
}
variable "contoso_address_space" {
  default = []
}
variable "subnet_ids" {
  default = []
}
variable "aci_subnet_ids" {
  default = []
}
variable "tags" {
  default = {}
}
