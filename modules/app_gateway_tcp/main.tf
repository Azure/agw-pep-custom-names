data "azurerm_client_config" "current" {}

locals {
  resource_id_prefix = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/"
  gateway_id_prefix  = "${local.resource_id_prefix}Microsoft.Network/applicationGateways/${var.gateway_name}/"

  frontend_ip_configuration_name = "feip"

  evh_backend_address_pool_name = "evh-beap"
  evh_tcp_setting_name          = "evh-be-tcpst"
  evh_tcp_listener_name         = "evh-tcplstn"
  evh_routing_rule_name         = "evh-rt"

  sql_backend_address_pool_name = "sql-beap"
  sql_tcp_setting_name          = "sql-be-tcpst"
  sql_tcp_listener_name         = "sql-tcplstn"
  sql_routing_rule_name         = "sql-rt"

  postgresql_backend_address_pool_name = "postgresql-beap"
  postgresql_tcp_setting_name          = "postgresql-be-tcpst"
  postgresql_tcp_listener_name         = "postgresql-tcplstn"
  postgresql_routing_rule_name         = "postgresql-rt"
}

resource "azapi_update_resource" "gateway_tcp" {
  count                   = var.tls_tcp_proxy_enabled ? 1 : 0
  name                    = var.gateway_name
  parent_id               = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
  type                    = "Microsoft.Network/applicationGateways@2022-05-01"
  ignore_missing_property = false
  body = jsonencode({
    properties = {
      backendSettingsCollection = [
        {
          name = local.evh_tcp_setting_name
          properties = {
            port                           = 5671
            protocol                       = "Tls"
            pickHostNameFromBackendAddress = false
            hostName                       = var.eventhub_fqdn
          }
        },
        {
          name = local.sql_tcp_setting_name
          properties = {
            port                           = 1433
            protocol                       = "Tcp"
            pickHostNameFromBackendAddress = false
            hostName                       = ""
          }
        },
        {
          name = local.postgresql_tcp_setting_name
          properties = {
            port                           = 5432
            protocol                       = "Tcp"
            pickHostNameFromBackendAddress = false
            hostName                       = ""
          }
        }
      ]

      listeners = [
        {
          name = local.evh_tcp_listener_name
          properties = {
            frontendIPConfiguration = {
              id = "${local.gateway_id_prefix}frontendIPConfigurations/${local.frontend_ip_configuration_name}"
            }
            frontendPort = {
              id = "${local.gateway_id_prefix}frontendPorts/port_5671"
            }
            sslCertificate = {
              id = "${local.gateway_id_prefix}sslCertificates/enterprise-certificate"
            }
            protocol = "Tls"
          }
        },
        {
          name = local.sql_tcp_listener_name
          properties = {
            frontendIPConfiguration = {
              id = "${local.gateway_id_prefix}frontendIPConfigurations/${local.frontend_ip_configuration_name}"
            }
            frontendPort = {
              id = "${local.gateway_id_prefix}frontendPorts/port_1433"
            }
            protocol = "Tcp"
          }
        },
        {
          name = local.postgresql_tcp_listener_name
          properties = {
            frontendIPConfiguration = {
              id = "${local.gateway_id_prefix}frontendIPConfigurations/${local.frontend_ip_configuration_name}"
            }
            frontendPort = {
              id = "${local.gateway_id_prefix}frontendPorts/port_5432"
            }
            protocol = "Tcp"
          }
        }
      ]

      routingRules = [
        {
          name = local.evh_routing_rule_name
          properties = {
            ruleType = "Basic"
            priority = 80
            listener = {
              id = "${local.gateway_id_prefix}listeners/${local.evh_tcp_listener_name}"
            }
            backendAddressPool = {
              id = "${local.gateway_id_prefix}backendAddressPools/${local.evh_backend_address_pool_name}"
            }
            backendSettings = {
              id = "${local.gateway_id_prefix}backendSettingsCollection/${local.evh_tcp_setting_name}"
            }
          }
        },
        {
          name = local.sql_routing_rule_name
          properties = {
            ruleType = "Basic"
            priority = 90
            listener = {
              id = "${local.gateway_id_prefix}listeners/${local.sql_tcp_listener_name}"
            }
            backendAddressPool = {
              id = "${local.gateway_id_prefix}backendAddressPools/${local.sql_backend_address_pool_name}"
            }
            backendSettings = {
              id = "${local.gateway_id_prefix}backendSettingsCollection/${local.sql_tcp_setting_name}"
            }
          }
        },
        {
          name = local.postgresql_routing_rule_name
          properties = {
            ruleType = "Basic"
            priority = 100
            listener = {
              id = "${local.gateway_id_prefix}listeners/${local.postgresql_tcp_listener_name}"
            }
            backendAddressPool = {
              id = "${local.gateway_id_prefix}backendAddressPools/${local.postgresql_backend_address_pool_name}"
            }
            backendSettings = {
              id = "${local.gateway_id_prefix}backendSettingsCollection/${local.postgresql_tcp_setting_name}"
            }
          }
        }
      ]
    }
  })
}
