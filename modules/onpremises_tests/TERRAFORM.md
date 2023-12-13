# onpremises_tests

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_group.tests](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_share.content_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aci_storage_account_name"></a> [aci\_storage\_account\_name](#input\_aci\_storage\_account\_name) | n/a | `any` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_contaner_group_name"></a> [contaner\_group\_name](#input\_contaner\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_cosmosdb_custom_endpoint"></a> [cosmosdb\_custom\_endpoint](#input\_cosmosdb\_custom\_endpoint) | n/a | `any` | n/a | yes |
| <a name="input_cosmosdb_key"></a> [cosmosdb\_key](#input\_cosmosdb\_key) | n/a | `any` | n/a | yes |
| <a name="input_eventhub_custom_endpoint"></a> [eventhub\_custom\_endpoint](#input\_eventhub\_custom\_endpoint) | n/a | `any` | n/a | yes |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | n/a | `any` | n/a | yes |
| <a name="input_eventhub_namespace"></a> [eventhub\_namespace](#input\_eventhub\_namespace) | n/a | `any` | n/a | yes |
| <a name="input_function_custom_endpoint"></a> [function\_custom\_endpoint](#input\_function\_custom\_endpoint) | n/a | `any` | n/a | yes |
| <a name="input_function_scm_custom_endpoint"></a> [function\_scm\_custom\_endpoint](#input\_function\_scm\_custom\_endpoint) | n/a | `any` | n/a | yes |
| <a name="input_gateway_private_ip"></a> [gateway\_private\_ip](#input\_gateway\_private\_ip) | n/a | `any` | n/a | yes |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | n/a | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_name_server_ip"></a> [name\_server\_ip](#input\_name\_server\_ip) | n/a | `any` | n/a | yes |
| <a name="input_postgresql_name"></a> [postgresql\_name](#input\_postgresql\_name) | n/a | `any` | n/a | yes |
| <a name="input_postgresql_password"></a> [postgresql\_password](#input\_postgresql\_password) | n/a | `any` | n/a | yes |
| <a name="input_postgresql_server_name"></a> [postgresql\_server\_name](#input\_postgresql\_server\_name) | n/a | `any` | n/a | yes |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | n/a | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_sql_name"></a> [sql\_name](#input\_sql\_name) | n/a | `any` | n/a | yes |
| <a name="input_sql_password"></a> [sql\_password](#input\_sql\_password) | n/a | `any` | n/a | yes |
| <a name="input_sql_server_name"></a> [sql\_server\_name](#input\_sql\_server\_name) | n/a | `any` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `any` | n/a | yes |
| <a name="input_tls_tcp_proxy_enabled"></a> [tls\_tcp\_proxy\_enabled](#input\_tls\_tcp\_proxy\_enabled) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_name"></a> [container\_name](#output\_container\_name) | n/a |
| <a name="output_contaner_group_name"></a> [contaner\_group\_name](#output\_contaner\_group\_name) | n/a |
| <a name="output_storage_account_key"></a> [storage\_account\_key](#output\_storage\_account\_key) | n/a |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | n/a |
| <a name="output_storage_account_share_name"></a> [storage\_account\_share\_name](#output\_storage\_account\_share\_name) | n/a |
| <a name="output_test_results_file"></a> [test\_results\_file](#output\_test\_results\_file) | n/a |
<!-- END_TF_DOCS -->