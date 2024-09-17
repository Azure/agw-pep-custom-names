# function

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
| [azurerm_application_insights.ai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_linux_function_app.func_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_private_dns_zone.azurewebsites](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.azurewebsites](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.azurewebsites_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_service_plan.plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | n/a | `any` | n/a | yes |
| <a name="input_hub_vnet_id"></a> [hub\_vnet\_id](#input\_hub\_vnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_name_server_ip"></a> [name\_server\_ip](#input\_name\_server\_ip) | n/a | `any` | n/a | yes |
| <a name="input_private_endpoints_subnet_id"></a> [private\_endpoints\_subnet\_id](#input\_private\_endpoints\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_storage_content_share_name"></a> [storage\_content\_share\_name](#input\_storage\_content\_share\_name) | n/a | `any` | n/a | yes |
| <a name="input_storage_name"></a> [storage\_name](#input\_storage\_name) | n/a | `any` | n/a | yes |
| <a name="input_storage_primary_access_key"></a> [storage\_primary\_access\_key](#input\_storage\_primary\_access\_key) | n/a | `any` | n/a | yes |
| <a name="input_storage_primary_connection_string"></a> [storage\_primary\_connection\_string](#input\_storage\_primary\_connection\_string) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_vnet_integration_subnet_id"></a> [vnet\_integration\_subnet\_id](#input\_vnet\_integration\_subnet\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appi_id"></a> [appi\_id](#output\_appi\_id) | n/a |
| <a name="output_appi_key"></a> [appi\_key](#output\_appi\_key) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_private_fqdn"></a> [private\_fqdn](#output\_private\_fqdn) | n/a |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | n/a |
| <a name="output_private_zone_name"></a> [private\_zone\_name](#output\_private\_zone\_name) | n/a |
| <a name="output_scm_fqdn"></a> [scm\_fqdn](#output\_scm\_fqdn) | n/a |
| <a name="output_scm_private_fqdn"></a> [scm\_private\_fqdn](#output\_scm\_private\_fqdn) | n/a |
<!-- END_TF_DOCS -->