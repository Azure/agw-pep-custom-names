## Terraform Modules

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 0.14 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.44.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.83.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.44.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.83.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_gateway"></a> [app\_gateway](#module\_app\_gateway) | ./modules/app_gateway | n/a |
| <a name="module_app_gateway_identity"></a> [app\_gateway\_identity](#module\_app\_gateway\_identity) | ./modules/managed_identity | n/a |
| <a name="module_app_gateway_tcp"></a> [app\_gateway\_tcp](#module\_app\_gateway\_tcp) | ./modules/app_gateway_tcp | n/a |
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/bastion | n/a |
| <a name="module_contoso_vm"></a> [contoso\_vm](#module\_contoso\_vm) | ./modules/win_vm | n/a |
| <a name="module_cosmosdb"></a> [cosmosdb](#module\_cosmosdb) | ./modules/cosmosdb | n/a |
| <a name="module_current_public_ip"></a> [current\_public\_ip](#module\_current\_public\_ip) | ./modules/public_ip | n/a |
| <a name="module_dns"></a> [dns](#module\_dns) | ./modules/bind_dns | n/a |
| <a name="module_eventhub"></a> [eventhub](#module\_eventhub) | ./modules/eventhub | n/a |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_function"></a> [function](#module\_function) | ./modules/function | n/a |
| <a name="module_hub_customer_peering"></a> [hub\_customer\_peering](#module\_hub\_customer\_peering) | ./modules/peering | n/a |
| <a name="module_hub_spoke_peering"></a> [hub\_spoke\_peering](#module\_hub\_spoke\_peering) | ./modules/peering | n/a |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ./modules/keyvault | n/a |
| <a name="module_nsg"></a> [nsg](#module\_nsg) | ./modules/nsg | n/a |
| <a name="module_onpremises_tests"></a> [onpremises\_tests](#module\_onpremises\_tests) | ./modules/onpremises_tests | n/a |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | ./modules/postgresql | n/a |
| <a name="module_postgresql_flexible_server"></a> [postgresql\_flexible\_server](#module\_postgresql\_flexible\_server) | ./modules/postgresql_flexible_server | n/a |
| <a name="module_purview"></a> [purview](#module\_purview) | ./modules/purview | n/a |
| <a name="module_service_principal"></a> [service\_principal](#module\_service\_principal) | ./modules/service_principal | n/a |
| <a name="module_sql"></a> [sql](#module\_sql) | ./modules/sql | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/storage | n/a |
| <a name="module_udr"></a> [udr](#module\_udr) | ./modules/udr | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |
| <a name="module_vnet_gateway"></a> [vnet\_gateway](#module\_vnet\_gateway) | ./modules/vnet_gateway | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.83.0/docs/resources/resource_group) | resource |
| [random_id.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.44.0/docs/data-sources/client_config) | data source |
| [azuread_user.current](https://registry.terraform.io/providers/hashicorp/azuread/2.44.0/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_address_prefixes"></a> [bastion\_address\_prefixes](#input\_bastion\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.5.2.0/27"<br>]</pre> | no |
| <a name="input_contoso_address_prefixes"></a> [contoso\_address\_prefixes](#input\_contoso\_address\_prefixes) | n/a | `list` | <pre>[<br>  "192.168.1.0/24"<br>]</pre> | no |
| <a name="input_contoso_address_space"></a> [contoso\_address\_space](#input\_contoso\_address\_space) | n/a | `list` | <pre>[<br>  "192.168.0.0/16"<br>]</pre> | no |
| <a name="input_contoso_tests_address_prefixes"></a> [contoso\_tests\_address\_prefixes](#input\_contoso\_tests\_address\_prefixes) | n/a | `list` | <pre>[<br>  "192.168.2.0/24"<br>]</pre> | no |
| <a name="input_cosmos_name"></a> [cosmos\_name](#input\_cosmos\_name) | Cosmos DB database name | `string` | `"cosmos"` | no |
| <a name="input_deploy_cosmos"></a> [deploy\_cosmos](#input\_deploy\_cosmos) | true to deploy Cosmos DB | `bool` | `true` | no |
| <a name="input_deploy_function"></a> [deploy\_function](#input\_deploy\_function) | true to deploy Azure Function | `bool` | `true` | no |
| <a name="input_deploy_postgresql"></a> [deploy\_postgresql](#input\_deploy\_postgresql) | true to deploy postgreSQL | `bool` | `true` | no |
| <a name="input_deploy_postgresql_flexible"></a> [deploy\_postgresql\_flexible](#input\_deploy\_postgresql\_flexible) | n/a | `bool` | `false` | no |
| <a name="input_deploy_purview"></a> [deploy\_purview](#input\_deploy\_purview) | true to deploy Azure Purview | `bool` | `false` | no |
| <a name="input_deploy_sql"></a> [deploy\_sql](#input\_deploy\_sql) | true to deploy Azure SQL | `bool` | `true` | no |
| <a name="input_deploy_vm_on_premises"></a> [deploy\_vm\_on\_premises](#input\_deploy\_vm\_on\_premises) | true to deploy a VM in the on-premises vnet | `bool` | `false` | no |
| <a name="input_dns_address_prefixes"></a> [dns\_address\_prefixes](#input\_dns\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.5.1.0/24"<br>]</pre> | no |
| <a name="input_enable_gateway_key_vault_integration"></a> [enable\_gateway\_key\_vault\_integration](#input\_enable\_gateway\_key\_vault\_integration) | n/a | `bool` | `true` | no |
| <a name="input_enable_gateway_route_to_firewall"></a> [enable\_gateway\_route\_to\_firewall](#input\_enable\_gateway\_route\_to\_firewall) | n/a | `bool` | `true` | no |
| <a name="input_enable_network_policy_for_private_endpoints"></a> [enable\_network\_policy\_for\_private\_endpoints](#input\_enable\_network\_policy\_for\_private\_endpoints) | n/a | `bool` | `true` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | Event Hub Name | `string` | `"evh"` | no |
| <a name="input_firewall_address_prefixes"></a> [firewall\_address\_prefixes](#input\_firewall\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.5.0.0/26"<br>]</pre> | no |
| <a name="input_flexible_server_address_prefixes"></a> [flexible\_server\_address\_prefixes](#input\_flexible\_server\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.6.5.0/24"<br>]</pre> | no |
| <a name="input_func_name"></a> [func\_name](#input\_func\_name) | Function App name | `string` | `"func"` | no |
| <a name="input_gateway_address_prefixes"></a> [gateway\_address\_prefixes](#input\_gateway\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.6.1.0/24"<br>]</pre> | no |
| <a name="input_hub_address_space"></a> [hub\_address\_space](#input\_hub\_address\_space) | n/a | `list` | <pre>[<br>  "10.5.0.0/16"<br>]</pre> | no |
| <a name="input_hub_jumpbox_address_prefixes"></a> [hub\_jumpbox\_address\_prefixes](#input\_hub\_jumpbox\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.5.3.0/24"<br>]</pre> | no |
| <a name="input_jumpbox_address_prefixes"></a> [jumpbox\_address\_prefixes](#input\_jumpbox\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.6.4.0/24"<br>]</pre> | no |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | Azure Key Vault Name | `string` | `"kv"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location | `string` | `"westeurope"` | no |
| <a name="input_postgresql_name"></a> [postgresql\_name](#input\_postgresql\_name) | postgreSQL name | `string` | `"psql"` | no |
| <a name="input_private_gateway_enabled"></a> [private\_gateway\_enabled](#input\_private\_gateway\_enabled) | true if Full Private Application Gateway feature is enabled | `bool` | `true` | no |
| <a name="input_privateendpoints_address_prefixes"></a> [privateendpoints\_address\_prefixes](#input\_privateendpoints\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.6.3.0/24"<br>]</pre> | no |
| <a name="input_purview_name"></a> [purview\_name](#input\_purview\_name) | Purview name | `string` | `"pview"` | no |
| <a name="input_remove_gateway_inbound_rules"></a> [remove\_gateway\_inbound\_rules](#input\_remove\_gateway\_inbound\_rules) | true to remove the Gateway Manager and Load Balancer inbound rules from NSGs | `bool` | `true` | no |
| <a name="input_remove_public_ip"></a> [remove\_public\_ip](#input\_remove\_public\_ip) | true to delete them App Gateway public IP address | `bool` | `true` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource Group Name | `string` | `"rg-agw-pep"` | no |
| <a name="input_sa_name"></a> [sa\_name](#input\_sa\_name) | Storage Account name | `string` | `"st"` | no |
| <a name="input_spoke_address_space"></a> [spoke\_address\_space](#input\_spoke\_address\_space) | n/a | `list` | <pre>[<br>  "10.6.0.0/16"<br>]</pre> | no |
| <a name="input_sql_name"></a> [sql\_name](#input\_sql\_name) | SQL name | `string` | `"sql"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource Tags | `map` | <pre>{<br>  "env": "contoso-application-gateway-tests"<br>}</pre> | no |
| <a name="input_tls_tcp_proxy_enabled"></a> [tls\_tcp\_proxy\_enabled](#input\_tls\_tcp\_proxy\_enabled) | true if TLS/TCP Proxy feature is enabled | `bool` | `true` | no |
| <a name="input_use_public_fqdn"></a> [use\_public\_fqdn](#input\_use\_public\_fqdn) | true to use public FQDN for App Gateway's backednd configuration | `bool` | `true` | no |
| <a name="input_vnet_gateway_address_prefixes"></a> [vnet\_gateway\_address\_prefixes](#input\_vnet\_gateway\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.5.4.0/24"<br>]</pre> | no |
| <a name="input_vnet_integration_address_prefixes"></a> [vnet\_integration\_address\_prefixes](#input\_vnet\_integration\_address\_prefixes) | n/a | `list` | <pre>[<br>  "10.6.2.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_name"></a> [container\_name](#output\_container\_name) | Container that runs the .NET tests |
| <a name="output_contaner_group_name"></a> [contaner\_group\_name](#output\_contaner\_group\_name) | Container Group that runs the .NET tests |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | Resource Group |
| <a name="output_results_account_name"></a> [results\_account\_name](#output\_results\_account\_name) | n/a |
| <a name="output_results_file"></a> [results\_file](#output\_results\_file) | n/a |
| <a name="output_results_share_key"></a> [results\_share\_key](#output\_results\_share\_key) | n/a |
| <a name="output_results_share_name"></a> [results\_share\_name](#output\_results\_share\_name) | n/a |
| <a name="output_windows_password"></a> [windows\_password](#output\_windows\_password) | Password for the Windows Jump Box |
<!-- END_TF_DOCS -->