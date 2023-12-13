# udr

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
| [azurerm_route_table.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_route_table.restrict](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.restrict_contoso](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.restrict_contoso_tests](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contoso_address_prefixes"></a> [contoso\_address\_prefixes](#input\_contoso\_address\_prefixes) | n/a | `any` | n/a | yes |
| <a name="input_contoso_subnet_id"></a> [contoso\_subnet\_id](#input\_contoso\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_contoso_tests_subnet_id"></a> [contoso\_tests\_subnet\_id](#input\_contoso\_tests\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_enable_gateway_route_to_firewall"></a> [enable\_gateway\_route\_to\_firewall](#input\_enable\_gateway\_route\_to\_firewall) | n/a | `any` | n/a | yes |
| <a name="input_firewall_private_ip_address"></a> [firewall\_private\_ip\_address](#input\_firewall\_private\_ip\_address) | n/a | `any` | n/a | yes |
| <a name="input_firewall_public_ip_address"></a> [firewall\_public\_ip\_address](#input\_firewall\_public\_ip\_address) | n/a | `any` | n/a | yes |
| <a name="input_gateway_subnet_id"></a> [gateway\_subnet\_id](#input\_gateway\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_spoke_address_prefixes"></a> [spoke\_address\_prefixes](#input\_spoke\_address\_prefixes) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_udr_name"></a> [udr\_name](#input\_udr\_name) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->