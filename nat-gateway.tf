# NAT Gateway for private ws_subnet 
/*
resource "azurerm_nat_gateway" "ws_nat_gateway" {
    name = "${local.resource_name_prefix}-${var.ws_nat_gateway_name}"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    sku_name = "Standard"
    tags = local.common_tags
}

resource "azurerm_nat_gateway_public_ip_association" "ws_nat_gateway_pip_asso" {
  nat_gateway_id = azurerm_nat_gateway.ws_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.ws_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "ws_nat_gateway_ws_subnet_asso" {
  nat_gateway_id = azurerm_nat_gateway.ws_nat_gateway.id
  subnet_id = azurerm_subnet.ws_subnet.id
}

*/