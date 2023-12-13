resource "azurerm_key_vault_certificate" "enterprise" {
  name         = "enterprise"
  key_vault_id = var.keyvault_id
  tags         = {}

  certificate {
    contents = filebase64("${path.module}/certs/contoso.corp.pfx")
    password = "123456"
  }

  certificate_policy {
    key_properties {
      exportable = true
      key_type   = "RSA"
      reuse_key  = true
      key_size   = 4096
    }
    issuer_parameters {
      name = "Self"
    }
    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }
}
