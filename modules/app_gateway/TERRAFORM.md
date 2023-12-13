# app_gateway

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
| [azurerm_application_gateway.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_key_vault_certificate.enterprise](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_private_dns_a_record.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.contoso](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cosmosdb_fqdn"></a> [cosmosdb\_fqdn](#input\_cosmosdb\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_cosmosdb_private_fqdn"></a> [cosmosdb\_private\_fqdn](#input\_cosmosdb\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_cosmosdb_private_ip_address"></a> [cosmosdb\_private\_ip\_address](#input\_cosmosdb\_private\_ip\_address) | n/a | `any` | n/a | yes |
| <a name="input_deploy_cosmos"></a> [deploy\_cosmos](#input\_deploy\_cosmos) | n/a | `any` | n/a | yes |
| <a name="input_deploy_function"></a> [deploy\_function](#input\_deploy\_function) | n/a | `any` | n/a | yes |
| <a name="input_deploy_postgresql"></a> [deploy\_postgresql](#input\_deploy\_postgresql) | n/a | `any` | n/a | yes |
| <a name="input_deploy_purview"></a> [deploy\_purview](#input\_deploy\_purview) | n/a | `any` | n/a | yes |
| <a name="input_deploy_sql"></a> [deploy\_sql](#input\_deploy\_sql) | n/a | `any` | n/a | yes |
| <a name="input_enable_gateway_key_vault_integration"></a> [enable\_gateway\_key\_vault\_integration](#input\_enable\_gateway\_key\_vault\_integration) | n/a | `any` | n/a | yes |
| <a name="input_eventhub_fqdn"></a> [eventhub\_fqdn](#input\_eventhub\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_eventhub_private_fqdn"></a> [eventhub\_private\_fqdn](#input\_eventhub\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_eventhub_private_ip_address"></a> [eventhub\_private\_ip\_address](#input\_eventhub\_private\_ip\_address) | n/a | `any` | n/a | yes |
| <a name="input_function_fqdn"></a> [function\_fqdn](#input\_function\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_function_private_fqdn"></a> [function\_private\_fqdn](#input\_function\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_function_private_ip_address"></a> [function\_private\_ip\_address](#input\_function\_private\_ip\_address) | n/a | `any` | n/a | yes |
| <a name="input_function_scm_fqdn"></a> [function\_scm\_fqdn](#input\_function\_scm\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_function_scm_private_fqdn"></a> [function\_scm\_private\_fqdn](#input\_function\_scm\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_gateway_identity_id"></a> [gateway\_identity\_id](#input\_gateway\_identity\_id) | n/a | `any` | n/a | yes |
| <a name="input_gateway_name"></a> [gateway\_name](#input\_gateway\_name) | n/a | `any` | n/a | yes |
| <a name="input_gateway_subnet_address_prefix"></a> [gateway\_subnet\_address\_prefix](#input\_gateway\_subnet\_address\_prefix) | n/a | `any` | n/a | yes |
| <a name="input_gateway_subnet_id"></a> [gateway\_subnet\_id](#input\_gateway\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_hub_vnet_id"></a> [hub\_vnet\_id](#input\_hub\_vnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_keyvault_fqdn"></a> [keyvault\_fqdn](#input\_keyvault\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_keyvault_id"></a> [keyvault\_id](#input\_keyvault\_id) | n/a | `any` | n/a | yes |
| <a name="input_keyvault_private_fqdn"></a> [keyvault\_private\_fqdn](#input\_keyvault\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_keyvault_private_ip_address"></a> [keyvault\_private\_ip\_address](#input\_keyvault\_private\_ip\_address) | n/a | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_postgresql_fqdn"></a> [postgresql\_fqdn](#input\_postgresql\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_postgresql_private_fqdn"></a> [postgresql\_private\_fqdn](#input\_postgresql\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_private_gateway_enabled"></a> [private\_gateway\_enabled](#input\_private\_gateway\_enabled) | n/a | `any` | n/a | yes |
| <a name="input_purview_account_fqdn"></a> [purview\_account\_fqdn](#input\_purview\_account\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_purview_account_private_fqdn"></a> [purview\_account\_private\_fqdn](#input\_purview\_account\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_purview_portal_fqdn"></a> [purview\_portal\_fqdn](#input\_purview\_portal\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_purview_portal_private_fqdn"></a> [purview\_portal\_private\_fqdn](#input\_purview\_portal\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_remove_public_ip"></a> [remove\_public\_ip](#input\_remove\_public\_ip) | n/a | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_sql_fqdn"></a> [sql\_fqdn](#input\_sql\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_sql_private_fqdn"></a> [sql\_private\_fqdn](#input\_sql\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_storage_account_fqdn"></a> [storage\_account\_fqdn](#input\_storage\_account\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_storage_account_private_fqdn"></a> [storage\_account\_private\_fqdn](#input\_storage\_account\_private\_fqdn) | n/a | `any` | n/a | yes |
| <a name="input_storage_account_private_ip_address"></a> [storage\_account\_private\_ip\_address](#input\_storage\_account\_private\_ip\_address) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_tls_tcp_proxy_enabled"></a> [tls\_tcp\_proxy\_enabled](#input\_tls\_tcp\_proxy\_enabled) | n/a | `any` | n/a | yes |
| <a name="input_use_public_fqdn"></a> [use\_public\_fqdn](#input\_use\_public\_fqdn) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | n/a |
<!-- END_TF_DOCS -->