/*resource "azurerm_public_ip" "web_pip" {
  name =  "${local.resource_name_prefix}-web-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_public_ip" "ws_pip" {
  name =  "${local.resource_name_prefix}-natgw-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_public_ip" "bastion_pip" {
  name =  "${local.resource_name_prefix}-bastion-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
}
*/
resource "azurerm_public_ip" "app_gw_pip" {
  name =  "${local.resource_name_prefix}-app-gw-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
}