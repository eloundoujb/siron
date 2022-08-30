/*resource "azurerm_private_dns_zone" "private_dns_zone" {
    name = "eloundou.com"
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_network_asso" {
  name = "${local.resource_name_prefix}-dns-${var.vnetwork_name}-asso"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

#attention prendre azurerm_private_dns_a_record et Non #####azurerm_private_dns_a_record########""
resource "azurerm_private_dns_a_record" "ws_private_lb_dns_rec" {
  depends_on = [azurerm_lb.ws_private_lb]
  name = "barel"
  zone_name = azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl = 300
  records = ["${azurerm_lb.ws_private_lb.frontend_ip_configuration[0].private_ip_address}"]  
  # records = ["10.0.3.241"]
}

*/