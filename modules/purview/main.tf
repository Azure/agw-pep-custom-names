resource "azurerm_purview_account" "purview" {
  name                   = var.purview_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  public_network_enabled = false
  tags                   = var.tags

  identity {
    type = "SystemAssigned"
  }
}
