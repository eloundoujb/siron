resource "azurerm_virtual_network" "vnet" {
    name = "${local.resource_name_prefix}-${var.vnetwork_name}"
    address_space = var.vnetwork_address_space
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    tags = local.common_tags
}