/*
resource "azurerm_lb" "web_public_lb" {
  name = "${local.resource_name_prefix}-public-lb-web"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku = "Standard"
#  edge_zone = "Regional"
  tags = local.common_tags
  
  frontend_ip_configuration {
   name = "${local.resource_name_prefix}-public-lb-web-pip-conf"
   public_ip_address_id = azurerm_public_ip.web_pip.id
  }
}

# LB Backend-pool
resource "azurerm_lb_backend_address_pool" "web_lb_backend_pool" {
  name = "${azurerm_lb.web_public_lb.name}-pool"
  loadbalancer_id = azurerm_lb.web_public_lb.id  
}
*/

/*
resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool_asso" {
  for_each = var.tenant
  network_interface_id = azurerm_network_interface.web_nic[each.key].id
  ip_configuration_name = azurerm_network_interface.web_nic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_pool.id
}
*/

/*
# LB probe for health check
resource "azurerm_lb_probe" "web_lb_probe" {  
  name = "${azurerm_lb.web_public_lb.name}-probe"
  loadbalancer_id = azurerm_lb.web_public_lb.id
  port = "80"
  protocol = "Tcp"
  interval_in_seconds = 5
  number_of_probes = 1
}

#LB probe heath check rule

resource "azurerm_lb_rule" "web_lb_rule" {
  name = "${azurerm_lb.web_public_lb.name}-rule"
  frontend_ip_configuration_name = azurerm_lb.web_public_lb.frontend_ip_configuration[0].name
  frontend_port = "80"
  backend_port = "80"
  loadbalancer_id = azurerm_lb.web_public_lb.id
  probe_id = azurerm_lb_probe.web_lb_probe.id
  disable_outbound_snat = false
  enable_tcp_reset = false
  enable_floating_ip = false
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_backend_pool.id]
  idle_timeout_in_minutes = 5
  protocol = "Tcp"
}
*/

/*
#LB SSH Nat rule
resource "azurerm_lb_nat_rule" "lb_nat_ssh_rule" {
  for_each = var.ssh_nat_lb
  name = "${azurerm_lb.web_public_lb.name}-ssh-nat-rule-${each.key}"
  resource_group_name = azurerm_resource_group.rg.name
  protocol = "Tcp"
  frontend_port = each.value
  backend_port = 22
  loadbalancer_id = azurerm_lb.web_public_lb.id
  frontend_ip_configuration_name = azurerm_lb.web_public_lb.frontend_ip_configuration[0].name
}

resource "azurerm_network_interface_nat_rule_association" "web_nic_nat_rule_asso" {
  for_each = var.ssh_nat_lb
  network_interface_id = azurerm_network_interface.web_nic[each.key].id
  ip_configuration_name = azurerm_network_interface.web_nic[each.key].ip_configuration[0].name
  nat_rule_id = azurerm_lb_nat_rule.lb_nat_ssh_rule[each.key].id 
}
*/