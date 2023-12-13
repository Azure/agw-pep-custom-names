# Resource Group
output "resource_group" {
  value = azurerm_resource_group.rg.name
}

# Password for the Windows Jump Box 
output "windows_password" {
  value     = var.deploy_vm_on_premises ? module.contoso_vm[0].windows_password : ""
  sensitive = true
}

# Container Group that runs the .NET tests
output "contaner_group_name" {
  value = module.onpremises_tests.contaner_group_name
}

# Container that runs the .NET tests
output "container_name" {
  value = module.onpremises_tests.container_name
}

output "results_account_name" {
  value = module.onpremises_tests.storage_account_name
}

output "results_share_name" {
  value = module.onpremises_tests.storage_account_share_name
}

output "results_share_key" {
  value     = module.onpremises_tests.storage_account_key
  sensitive = true
}

output "results_file" {
  value = module.onpremises_tests.test_results_file
}
