# vnet

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
| [azurerm_subnet.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.contoso](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.contoso_tests](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.hub_jumpbox](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.jumpbox](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.privateendpoints](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.vnet_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.contoso](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_address_prefixes"></a> [bastion\_address\_prefixes](#input\_bastion\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_contoso_address_prefixes"></a> [contoso\_address\_prefixes](#input\_contoso\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_contoso_address_space"></a> [contoso\_address\_space](#input\_contoso\_address\_space) | n/a | `list` | `[]` | no |
| <a name="input_contoso_tests_address_prefixes"></a> [contoso\_tests\_address\_prefixes](#input\_contoso\_tests\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_dns_address_prefixes"></a> [dns\_address\_prefixes](#input\_dns\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_enable_network_policy_for_private_endpoints"></a> [enable\_network\_policy\_for\_private\_endpoints](#input\_enable\_network\_policy\_for\_private\_endpoints) | n/a | `any` | n/a | yes |
| <a name="input_firewall_address_prefixes"></a> [firewall\_address\_prefixes](#input\_firewall\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_flexible_server_address_prefixes"></a> [flexible\_server\_address\_prefixes](#input\_flexible\_server\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_gateway_address_prefixes"></a> [gateway\_address\_prefixes](#input\_gateway\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_hub_address_space"></a> [hub\_address\_space](#input\_hub\_address\_space) | n/a | `list` | `[]` | no |
| <a name="input_hub_jumpbox_address_prefixes"></a> [hub\_jumpbox\_address\_prefixes](#input\_hub\_jumpbox\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_jumpbox_address_prefixes"></a> [jumpbox\_address\_prefixes](#input\_jumpbox\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_privateendpoints_address_prefixes"></a> [privateendpoints\_address\_prefixes](#input\_privateendpoints\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_spoke_address_space"></a> [spoke\_address\_space](#input\_spoke\_address\_space) | n/a | `list` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_vnet_gateway_address_prefixes"></a> [vnet\_gateway\_address\_prefixes](#input\_vnet\_gateway\_address\_prefixes) | n/a | `list` | `[]` | no |
| <a name="input_vnet_integration_address_prefixes"></a> [vnet\_integration\_address\_prefixes](#input\_vnet\_integration\_address\_prefixes) | n/a | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_bastion_id"></a> [subnet\_bastion\_id](#output\_subnet\_bastion\_id) | n/a |
| <a name="output_subnet_contoso_id"></a> [subnet\_contoso\_id](#output\_subnet\_contoso\_id) | n/a |
| <a name="output_subnet_contoso_tests_id"></a> [subnet\_contoso\_tests\_id](#output\_subnet\_contoso\_tests\_id) | n/a |
| <a name="output_subnet_dns_address_prefixes"></a> [subnet\_dns\_address\_prefixes](#output\_subnet\_dns\_address\_prefixes) | n/a |
| <a name="output_subnet_dns_id"></a> [subnet\_dns\_id](#output\_subnet\_dns\_id) | n/a |
| <a name="output_subnet_firewall_id"></a> [subnet\_firewall\_id](#output\_subnet\_firewall\_id) | n/a |
| <a name="output_subnet_flexible_server_id"></a> [subnet\_flexible\_server\_id](#output\_subnet\_flexible\_server\_id) | n/a |
| <a name="output_subnet_gateway_address_prefixes"></a> [subnet\_gateway\_address\_prefixes](#output\_subnet\_gateway\_address\_prefixes) | n/a |
| <a name="output_subnet_gateway_id"></a> [subnet\_gateway\_id](#output\_subnet\_gateway\_id) | n/a |
| <a name="output_subnet_gatway_id"></a> [subnet\_gatway\_id](#output\_subnet\_gatway\_id) | n/a |
| <a name="output_subnet_hub_jumpbox_id"></a> [subnet\_hub\_jumpbox\_id](#output\_subnet\_hub\_jumpbox\_id) | n/a |
| <a name="output_subnet_jumpbox_id"></a> [subnet\_jumpbox\_id](#output\_subnet\_jumpbox\_id) | n/a |
| <a name="output_subnet_privateendpoints_id"></a> [subnet\_privateendpoints\_id](#output\_subnet\_privateendpoints\_id) | n/a |
| <a name="output_subnet_vnet_integration_id"></a> [subnet\_vnet\_integration\_id](#output\_subnet\_vnet\_integration\_id) | n/a |
| <a name="output_subnet_vnetgateway_id"></a> [subnet\_vnetgateway\_id](#output\_subnet\_vnetgateway\_id) | n/a |
| <a name="output_vnet_contoso_address_space"></a> [vnet\_contoso\_address\_space](#output\_vnet\_contoso\_address\_space) | n/a |
| <a name="output_vnet_customer_id"></a> [vnet\_customer\_id](#output\_vnet\_customer\_id) | n/a |
| <a name="output_vnet_customer_name"></a> [vnet\_customer\_name](#output\_vnet\_customer\_name) | n/a |
| <a name="output_vnet_hub_id"></a> [vnet\_hub\_id](#output\_vnet\_hub\_id) | n/a |
| <a name="output_vnet_hub_name"></a> [vnet\_hub\_name](#output\_vnet\_hub\_name) | n/a |
| <a name="output_vnet_integration_id"></a> [vnet\_integration\_id](#output\_vnet\_integration\_id) | n/a |
| <a name="output_vnet_spoke_address_space"></a> [vnet\_spoke\_address\_space](#output\_vnet\_spoke\_address\_space) | n/a |
| <a name="output_vnet_spoke_id"></a> [vnet\_spoke\_id](#output\_vnet\_spoke\_id) | n/a |
| <a name="output_vnet_spoke_name"></a> [vnet\_spoke\_name](#output\_vnet\_spoke\_name) | n/a |
<!-- END_TF_DOCS -->