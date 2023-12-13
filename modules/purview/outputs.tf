output "portal_private_fqdn" {
  value = "web.privatelink.purviewstudio.azure.com"
}

output "portal_fqdn" {
  value = "web.purviewstudio.azure.com"
}

output "account_private_fqdn" {
  value = "${azurerm_purview_account.purview.name}.privatelink.purview.azure.com"
}

output "account_fqdn" {
  value = "${azurerm_purview_account.purview.name}.purview.azure.com"
}