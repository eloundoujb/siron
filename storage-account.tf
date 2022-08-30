# Create storage account for boot diagnostics
locals {
  files_list = ["app1.conf"]
}
resource "azurerm_storage_account" "storage_account" {
  name                     = "storage${random_string.myrandom.id}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = var.storage_account_kind

  static_website {
    index_document     = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
}

resource "azurerm_storage_container" "web_container" {
  name = "web-container"
  storage_account_name = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "web_blob" {
  for_each = toset(local.files_list)
  name = each.value
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.web_container.name
  type = "Block"
  source = "${path.module}/app-scripts/${each.value}"
}