<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_flexible_server.server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_database.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_firewall_rule.terraform_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_current_user_object_id"></a> [current\_user\_object\_id](#input\_current\_user\_object\_id) | n/a | `any` | n/a | yes |
| <a name="input_current_user_principal_name"></a> [current\_user\_principal\_name](#input\_current\_user\_principal\_name) | n/a | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_postgre_sql_dns_zone_id"></a> [postgre\_sql\_dns\_zone\_id](#input\_postgre\_sql\_dns\_zone\_id) | n/a | `any` | n/a | yes |
| <a name="input_postgresql_flexible_server_subnet_id"></a> [postgresql\_flexible\_server\_subnet\_id](#input\_postgresql\_flexible\_server\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_postgresql_name"></a> [postgresql\_name](#input\_postgresql\_name) | n/a | `any` | n/a | yes |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | n/a | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_server_name"></a> [server\_name](#output\_server\_name) | n/a |
<!-- END_TF_DOCS -->