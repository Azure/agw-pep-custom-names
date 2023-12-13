variable "resource_group_name" {}
variable "location" {}
variable "postgresql_name" {}
variable "postgresql_flexible_server_subnet_id" {}
variable "postgre_sql_dns_zone_id" {}
variable "public_ip" {}
variable "tenant_id" {}
variable "current_user_object_id" {}
variable "current_user_principal_name" {}
variable "tags" {
  default = {}
}