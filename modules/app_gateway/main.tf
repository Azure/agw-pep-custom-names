resource "azurerm_public_ip" "gateway" {
  count               = var.remove_public_ip ? 0 : 1
  name                = "${var.gateway_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = var.tags
}

data "azurerm_client_config" "current" {}

locals {
  gateway_public_ip_address             = var.private_gateway_enabled ? [] : ["${var.gateway_name}-pip"]
  deploy_sql                            = var.deploy_sql ? [1] : []
  deploy_postgresql                     = var.deploy_postgresql ? [1] : []
  deploy_purview                        = var.deploy_purview ? [1] : []
  deploy_function                       = var.deploy_function ? [1] : []
  deploy_cosmos                         = var.deploy_cosmos ? [1] : []
  deploy_cognitive_services             = var.deploy_cognitive_services ? [1] : []
  enable_gateway_key_vault_integration  = var.enable_gateway_key_vault_integration ? [1] : []
  disable_gateway_key_vault_integration = var.enable_gateway_key_vault_integration ? [] : [1]
  private_ip_address                    = cidrhost(var.gateway_subnet_address_prefix, 254)
  keyvault_secret_id                    = azurerm_key_vault_certificate.enterprise.secret_id

  frontend_ip_configuration_name        = "feip"
  frontend_port_name                    = "feport"
  frontend_public_ip_configuration_name = "fepip"

  sta_backend_address_pool_name = "sta-beap"
  sta_http_setting_name         = "sta-be-htst"
  sta_listener_name             = "sta-httplstn"
  sta_request_routing_rule_name = "sta-rqrt"
  sta_probe_name                = "sta-probe"

  evh_backend_address_pool_name = "evh-beap"
  evh_http_setting_name         = "evh-be-htst"
  evh_listener_name             = "evh-httplstn"
  evh_request_routing_rule_name = "evh-rqrt"
  evh_probe_name                = "evh-probe"

  cdb_backend_address_pool_name = "cdb-beap"
  cdb_http_setting_name         = "cdb-be-htst"
  cdb_listener_name             = "cdb-httplstn"
  cdb_request_routing_rule_name = "cdb-rqrt"
  cdb_probe_name                = "cdb-probe"

  kv_backend_address_pool_name = "kv-beap"
  kv_http_setting_name         = "kv-be-htst"
  kv_listener_name             = "kv-httplstn"
  kv_request_routing_rule_name = "kv-rqrt"
  kv_probe_name                = "kv-probe"

  function_backend_address_pool_name = "fun-beap"
  function_http_setting_name         = "fun-be-htst"
  function_listener_name             = "fun-httplstn"
  function_request_routing_rule_name = "fun-rqrt"
  function_probe_name                = "fun-probe"

  function_scm_backend_address_pool_name = "fun-scm-beap"
  function_scm_http_setting_name         = "fun-scm-be-htst"
  function_scm_listener_name             = "fun-scm-httplstn"
  function_scm_request_routing_rule_name = "fun-scm-rqrt"
  function_scm_probe_name                = "fun-scm-probe"

  purview_portal_backend_address_pool_name = "purview-portal-beap"
  purview_portal_http_setting_name         = "purview-portal-be-htst"
  purview_portal_listener_name             = "purview-portal-httplstn"
  purview_portal_request_routing_rule_name = "purview-portal-rqrt"
  purview_portal_probe_name                = "purview-portal-probe"

  cog_backend_address_pool_name = "cog-beap"
  cog_http_setting_name         = "cog-be-htst"
  cog_listener_name             = "cog-httplstn"
  cog_request_routing_rule_name = "cog-rqrt"
  cog_probe_name                = "cog-probe"

  sql_backend_address_pool_name = "sql-beap"

  postgresql_backend_address_pool_name = "postgresql-beap"

  resource_id_prefix = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers/"
  gateway_id_prefix  = "${local.resource_id_prefix}Microsoft.Network/applicationGateways/${var.gateway_name}/"
}

resource "azurerm_application_gateway" "gateway" {
  name                = var.gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = merge(
    var.tags,
    {
      EnhancedNetworkControl = "True"
    },
  )

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.gateway_subnet_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.gateway_identity_id]
  }

  dynamic "ssl_certificate" {
    for_each = local.disable_gateway_key_vault_integration
    content {
      name     = "enterprise-certificate"
      data     = filebase64("${path.module}/certs/contoso.corp.pfx")
      password = "123456"
    }
  }

  dynamic "ssl_certificate" {
    for_each = local.enable_gateway_key_vault_integration
    content {
      name                = "enterprise-certificate"
      key_vault_secret_id = local.keyvault_secret_id
    }
  }

  frontend_port {
    name = local.frontend_port_name
    port = 443
  }

  frontend_port {
    name = "port_5671"
    port = 5671
  }

  frontend_port {
    name = "port_1433"
    port = 1433
  }

  frontend_port {
    name = "port_5432"
    port = 5432
  }

  dynamic "frontend_ip_configuration" {
    for_each = local.gateway_public_ip_address
    content {
      name                 = local.frontend_public_ip_configuration_name
      public_ip_address_id = azurerm_public_ip.gateway[0].id
    }
  }

  frontend_ip_configuration {
    name                          = local.frontend_ip_configuration_name
    subnet_id                     = var.gateway_subnet_id
    private_ip_address            = local.private_ip_address
    private_ip_address_allocation = "Static"
  }

  waf_configuration {
    enabled                  = false
    file_upload_limit_mb     = 100
    firewall_mode            = "Prevention"
    max_request_body_size_kb = 128
    request_body_check       = true
    rule_set_type            = "OWASP"
    rule_set_version         = "3.1"
  }

  backend_address_pool {
    name = local.sta_backend_address_pool_name
    fqdns = [
      var.use_public_fqdn ? var.storage_account_fqdn : var.storage_account_private_fqdn
    ]
  }

  probe {
    name                                      = local.sta_probe_name
    protocol                                  = "Https"
    pick_host_name_from_backend_http_settings = true
    path                                      = "/"
    match {
      body        = ""
      status_code = ["400-409"]
    }
    port                = 443
    timeout             = 30
    interval            = 30
    unhealthy_threshold = 3
  }

  backend_http_settings {
    name                  = local.sta_http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
    host_name             = var.storage_account_fqdn
    probe_name            = local.sta_probe_name
  }

  http_listener {
    name                           = local.sta_listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name           = "enterprise-certificate"
    host_name                      = "sta.contoso.corp"
  }

  request_routing_rule {
    name                       = local.sta_request_routing_rule_name
    rule_type                  = "Basic"
    priority                   = 10
    http_listener_name         = local.sta_listener_name
    backend_address_pool_name  = local.sta_backend_address_pool_name
    backend_http_settings_name = local.sta_http_setting_name
  }

  backend_address_pool {
    name = local.evh_backend_address_pool_name
    fqdns = [
      var.use_public_fqdn ? var.eventhub_fqdn : var.eventhub_private_fqdn
    ]
  }

  probe {
    name                                      = local.evh_probe_name
    protocol                                  = "Https"
    pick_host_name_from_backend_http_settings = true
    path                                      = "/"
    match {
      body        = ""
      status_code = ["200"]
    }
    port                = 443
    timeout             = 30
    interval            = 30
    unhealthy_threshold = 3
  }

  backend_http_settings {
    name                  = local.evh_http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
    host_name             = var.eventhub_fqdn
    probe_name            = local.evh_probe_name
  }

  http_listener {
    name                           = local.evh_listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name           = "enterprise-certificate"
    host_name                      = "evh.contoso.corp"
  }

  request_routing_rule {
    name                       = local.evh_request_routing_rule_name
    rule_type                  = "Basic"
    priority                   = 20
    http_listener_name         = local.evh_listener_name
    backend_address_pool_name  = local.evh_backend_address_pool_name
    backend_http_settings_name = local.evh_http_setting_name
  }

  dynamic "backend_address_pool" {
    for_each = local.deploy_cosmos
    content {
      name = local.cdb_backend_address_pool_name
      fqdns = [
        var.use_public_fqdn ? var.cosmosdb_fqdn : var.cosmosdb_private_fqdn
      ]
    }
  }

  dynamic "probe" {
    for_each = local.deploy_cosmos
    content {
      name                                      = local.cdb_probe_name
      protocol                                  = "Https"
      pick_host_name_from_backend_http_settings = true
      path                                      = "/"
      match {
        body        = ""
        status_code = ["401"]
      }
      port                = 443
      timeout             = 30
      interval            = 30
      unhealthy_threshold = 3
    }
  }

  dynamic "backend_http_settings" {
    for_each = local.deploy_cosmos
    content {
      name                  = local.cdb_http_setting_name
      cookie_based_affinity = "Disabled"
      path                  = "/"
      port                  = 443
      protocol              = "Https"
      request_timeout       = 60
      host_name             = var.cosmosdb_fqdn
      probe_name            = local.cdb_probe_name
    }
  }

  dynamic "http_listener" {
    for_each = local.deploy_cosmos
    content {
      name                           = local.cdb_listener_name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name
      frontend_port_name             = local.frontend_port_name
      protocol                       = "Https"
      ssl_certificate_name           = "enterprise-certificate"
      host_name                      = "cosmos.contoso.corp"
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.deploy_cosmos
    content {
      name                       = local.cdb_request_routing_rule_name
      rule_type                  = "Basic"
      priority                   = 30
      http_listener_name         = local.cdb_listener_name
      backend_address_pool_name  = local.cdb_backend_address_pool_name
      backend_http_settings_name = local.cdb_http_setting_name
    }
  }

  backend_address_pool {
    name = local.kv_backend_address_pool_name
    fqdns = [
      var.use_public_fqdn ? var.keyvault_fqdn : var.keyvault_private_fqdn
    ]
  }

  probe {
    name                                      = local.kv_probe_name
    protocol                                  = "Https"
    pick_host_name_from_backend_http_settings = true
    path                                      = "/"
    match {
      body        = ""
      status_code = ["403"]
    }
    port                = 443
    timeout             = 30
    interval            = 30
    unhealthy_threshold = 3
  }

  backend_http_settings {
    name                  = local.kv_http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
    host_name             = var.keyvault_fqdn
    probe_name            = local.kv_probe_name
  }

  http_listener {
    name                           = local.kv_listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name           = "enterprise-certificate"
    host_name                      = "kv.contoso.corp"
  }

  request_routing_rule {
    name                       = local.kv_request_routing_rule_name
    rule_type                  = "Basic"
    priority                   = 40
    http_listener_name         = local.kv_listener_name
    backend_address_pool_name  = local.kv_backend_address_pool_name
    backend_http_settings_name = local.kv_http_setting_name
  }

  dynamic "backend_address_pool" {
    for_each = local.deploy_cognitive_services
    content {
      name = local.cog_backend_address_pool_name
      fqdns = [
        var.use_public_fqdn ? var.cognitive_services_fqdn : var.cognitive_services_private_fqdn
      ]
    }
  }

  dynamic "probe" {
    for_each = local.deploy_cognitive_services
    content {
      name                                      = local.cog_probe_name
      protocol                                  = "Https"
      pick_host_name_from_backend_http_settings = true
      path                                      = "/"
      match {
        body        = ""
        status_code = ["404"]
      }
      port                = 443
      timeout             = 30
      interval            = 30
      unhealthy_threshold = 3
    }
  }

  dynamic "backend_http_settings" {
    for_each = local.deploy_cognitive_services
    content {
      name                  = local.cog_http_setting_name
      cookie_based_affinity = "Disabled"
      path                  = "/"
      port                  = 443
      protocol              = "Https"
      request_timeout       = 60
      host_name             = var.cognitive_services_fqdn
      probe_name            = local.cog_probe_name
    }
  }

  dynamic "http_listener" {
    for_each = local.deploy_cognitive_services
    content {
      name                           = local.cog_listener_name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name
      frontend_port_name             = local.frontend_port_name
      protocol                       = "Https"
      ssl_certificate_name           = "enterprise-certificate"
      host_name                      = "cog.contoso.corp"
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.deploy_cognitive_services
    content {
      name                       = local.cog_request_routing_rule_name
      rule_type                  = "Basic"
      priority                   = 110
      http_listener_name         = local.cog_listener_name
      backend_address_pool_name  = local.cog_backend_address_pool_name
      backend_http_settings_name = local.cog_http_setting_name
    }
  }

  dynamic "backend_address_pool" {
    for_each = local.deploy_function
    content {
      name = local.function_backend_address_pool_name
      fqdns = [
        var.use_public_fqdn ? var.function_fqdn : var.function_private_fqdn
      ]
    }
  }

  dynamic "probe" {
    for_each = local.deploy_function
    content {
      name                                      = local.function_probe_name
      protocol                                  = "Https"
      pick_host_name_from_backend_http_settings = true
      path                                      = "/"
      match {
        body        = ""
        status_code = ["200"]
      }
      port                = 443
      timeout             = 30
      interval            = 30
      unhealthy_threshold = 3
    }
  }

  dynamic "backend_http_settings" {
    for_each = local.deploy_function
    content {
      name                  = local.function_http_setting_name
      cookie_based_affinity = "Disabled"
      path                  = "/"
      port                  = 443
      protocol              = "Https"
      request_timeout       = 60
      host_name             = var.function_fqdn
      probe_name            = local.function_probe_name
    }
  }

  dynamic "http_listener" {
    for_each = local.deploy_function
    content {
      name                           = local.function_listener_name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name
      frontend_port_name             = local.frontend_port_name
      protocol                       = "Https"
      ssl_certificate_name           = "enterprise-certificate"
      host_name                      = "function.contoso.corp"
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.deploy_function
    content {
      name                       = local.function_request_routing_rule_name
      rule_type                  = "Basic"
      priority                   = 50
      http_listener_name         = local.function_listener_name
      backend_address_pool_name  = local.function_backend_address_pool_name
      backend_http_settings_name = local.function_http_setting_name
    }
  }

  dynamic "backend_address_pool" {
    for_each = local.deploy_function
    content {
      name = local.function_scm_backend_address_pool_name
      fqdns = [
        var.use_public_fqdn ? var.function_scm_fqdn : var.function_scm_private_fqdn
      ]
    }
  }

  dynamic "probe" {
    for_each = local.deploy_function
    content {
      name                                      = local.function_scm_probe_name
      protocol                                  = "Https"
      pick_host_name_from_backend_http_settings = true
      path                                      = "/"
      match {
        body        = ""
        status_code = ["401"]
      }
      port                = 443
      timeout             = 30
      interval            = 30
      unhealthy_threshold = 3
    }
  }

  dynamic "backend_http_settings" {
    for_each = local.deploy_function
    content {
      name                  = local.function_scm_http_setting_name
      cookie_based_affinity = "Disabled"
      path                  = "/"
      port                  = 443
      protocol              = "Https"
      request_timeout       = 60
      host_name             = var.function_scm_fqdn
      probe_name            = local.function_scm_probe_name
    }
  }

  dynamic "http_listener" {
    for_each = local.deploy_function
    content {
      name                           = local.function_scm_listener_name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name
      frontend_port_name             = local.frontend_port_name
      protocol                       = "Https"
      ssl_certificate_name           = "enterprise-certificate"
      host_name                      = "functionscm.contoso.corp"
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.deploy_function
    content {
      name                       = local.function_scm_request_routing_rule_name
      rule_type                  = "Basic"
      priority                   = 60
      http_listener_name         = local.function_scm_listener_name
      backend_address_pool_name  = local.function_scm_backend_address_pool_name
      backend_http_settings_name = local.function_scm_http_setting_name
    }
  }

  dynamic "backend_address_pool" {
    for_each = local.deploy_purview
    content {
      name = local.purview_portal_backend_address_pool_name
      fqdns = [
        var.use_public_fqdn ? var.purview_portal_fqdn : var.purview_portal_private_fqdn
      ]
    }
  }

  dynamic "probe" {
    for_each = local.deploy_purview
    content {
      name                                      = local.purview_portal_probe_name
      protocol                                  = "Https"
      pick_host_name_from_backend_http_settings = false
      host                                      = "ms.web.purview.azure.com"
      path                                      = "/"
      match {
        body        = ""
        status_code = ["200"]
      }
      port                = 443
      timeout             = 30
      interval            = 30
      unhealthy_threshold = 3
    }
  }

  dynamic "backend_http_settings" {
    for_each = local.deploy_purview
    content {
      name                  = local.purview_portal_http_setting_name
      cookie_based_affinity = "Disabled"
      path                  = "/"
      port                  = 443
      protocol              = "Https"
      request_timeout       = 60
      host_name             = var.purview_portal_fqdn
      probe_name            = local.purview_portal_probe_name
    }
  }

  dynamic "http_listener" {
    for_each = local.deploy_purview
    content {
      name                           = local.purview_portal_listener_name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name
      frontend_port_name             = local.frontend_port_name
      protocol                       = "Https"
      ssl_certificate_name           = "enterprise-certificate"
      host_name                      = "purviewportal.contoso.corp"
    }
  }

  dynamic "request_routing_rule" {
    for_each = local.deploy_purview
    content {
      name                       = local.purview_portal_request_routing_rule_name
      rule_type                  = "Basic"
      priority                   = 70
      http_listener_name         = local.purview_portal_listener_name
      backend_address_pool_name  = local.purview_portal_backend_address_pool_name
      backend_http_settings_name = local.purview_portal_http_setting_name
    }
  }

  dynamic "backend_address_pool" {
    for_each = local.deploy_sql
    content {
      name = local.sql_backend_address_pool_name
      fqdns = [
        var.use_public_fqdn ? var.sql_fqdn : var.sql_private_fqdn
      ]
    }
  }

  dynamic "backend_address_pool" {
    for_each = local.deploy_postgresql
    content {
      name = local.postgresql_backend_address_pool_name
      fqdns = [
        var.use_public_fqdn ? var.postgresql_fqdn : var.postgresql_private_fqdn
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "contoso" {
  name                = "contoso.corp"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_a_record" "gateway" {
  name                = "*"
  zone_name           = azurerm_private_dns_zone.contoso.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [local.private_ip_address]
  tags                = {}
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "gateway" {
  name                  = "gateway"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.contoso.name
  virtual_network_id    = var.hub_vnet_id
  tags                  = {}
}
