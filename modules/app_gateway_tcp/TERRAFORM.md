# app_gateway_tcp

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 0.14 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | = 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.83.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | = 1.0.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | = 3.83.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.gateway_tcp](https://registry.terraform.io/providers/azure/azapi/1.0.0/docs/resources/update_resource) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.83.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eventhub_fqdn"></a> [eventhub\_fqdn](#input\_eventhub\_fqdn) | Event Hub FQDN | `any` | n/a | yes |
| <a name="input_gateway_name"></a> [gateway\_name](#input\_gateway\_name) | Application Gateway name | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | location | `any` | n/a | yes |
| <a name="input_postgresql_fqdn"></a> [postgresql\_fqdn](#input\_postgresql\_fqdn) | postgreSQL FQDN | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resopurce group name | `any` | n/a | yes |
| <a name="input_sql_fqdn"></a> [sql\_fqdn](#input\_sql\_fqdn) | SQL FQDN | `any` | n/a | yes |
| <a name="input_tls_tcp_proxy_enabled"></a> [tls\_tcp\_proxy\_enabled](#input\_tls\_tcp\_proxy\_enabled) | true if TLS TCP Proxy feature is enabled" | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->