/*
resource "azurerm_lb" "ws_private_lb" {
  name = "${local.resource_name_prefix}-private-lb-ws"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku = "Standard"
  tags = local.common_tags
  
  frontend_ip_configuration {
   name = "${local.resource_name_prefix}-private-lb-ws-conf"
   subnet_id = azurerm_subnet.ws_subnet.id
   private_ip_address_allocation = "Static"
   private_ip_address_version = "IPv4"
   private_ip_address = "10.0.3.241"
  }
}

# LB Backend-pool
resource "azurerm_lb_backend_address_pool" "ws_lb_backend_pool" {
  name = "${azurerm_lb.ws_private_lb.name}-pool"
  loadbalancer_id = azurerm_lb.ws_private_lb.id  
}
*/
/*
resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool_asso" {
  for_each = var.tenant
  network_interface_id = azurerm_network_interface.ws_nic[each.key].id
  ip_configuration_name = azurerm_network_interface.ws_nic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.ws_lb_backend_pool.id
}
*/

/*
# LB probe for health check
resource "azurerm_lb_probe" "ws_lb_probe" {  
  name = "${azurerm_lb.ws_private_lb.name}-probe"
  loadbalancer_id = azurerm_lb.ws_private_lb.id
  port = "80"
  protocol = "Tcp"
  interval_in_seconds = 5
  number_of_probes = 1
}

#LB probe heath check rule

resource "azurerm_lb_rule" "ws_lb_rule" {
  name = "${azurerm_lb.ws_private_lb.name}-rule"
  frontend_ip_configuration_name = azurerm_lb.ws_private_lb.frontend_ip_configuration[0].name
  frontend_port = "80"
  backend_port = "80"
  loadbalancer_id = azurerm_lb.ws_private_lb.id
  probe_id = azurerm_lb_probe.ws_lb_probe.id
  disable_outbound_snat = false
  enable_tcp_reset = false
  enable_floating_ip = false
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.ws_lb_backend_pool.id]
  idle_timeout_in_minutes = 5
  protocol = "Tcp"
}
*/