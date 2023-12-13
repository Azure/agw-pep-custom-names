output "contaner_group_name" {
  value = var.contaner_group_name
}

output "container_name" {
  value = azurerm_container_group.tests.container[0].name
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "storage_account_share_name" {
  value = azurerm_storage_share.content_share.name
}

output "storage_account_key" {
  value     = azurerm_storage_account.sa.primary_access_key
  sensitive = true
}

output "test_results_file" {
  value = "TestResults.trx"
}
