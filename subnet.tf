
 resource "azurerm_subnet" web_subnet {
 name = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
 address_prefixes = var.web_subnet_address_prefix
 virtual_network_name = azurerm_virtual_network.vnet.name
 resource_group_name = azurerm_resource_group.rg.name
}

 resource "azurerm_subnet" ws_subnet {
 name = "${azurerm_virtual_network.vnet.name}-${var.ws_subnet_name}"
 address_prefixes = var.ws_subnet_address_prefix
 virtual_network_name = azurerm_virtual_network.vnet.name
 resource_group_name = azurerm_resource_group.rg.name
}

 resource "azurerm_subnet" db_subnet {
 name = "${azurerm_virtual_network.vnet.name}-${var.db_subnet_name}"
 address_prefixes = var.db_subnet_address_prefix
 virtual_network_name = azurerm_virtual_network.vnet.name
 resource_group_name = azurerm_resource_group.rg.name
}

 resource "azurerm_subnet" bastion_subnet {
 name = "${azurerm_virtual_network.vnet.name}-${var.bastion_subnet_name}"
 address_prefixes = var.bastion_subnet_address_prefix
 virtual_network_name = azurerm_virtual_network.vnet.name
 resource_group_name = azurerm_resource_group.rg.name
}

 resource "azurerm_subnet" app_gw_subnet {
 name = "${azurerm_virtual_network.vnet.name}-${var.app_gw_subnet_name}"
 address_prefixes = var.app_gw_subnet_address_prefix
 virtual_network_name = azurerm_virtual_network.vnet.name
 resource_group_name = azurerm_resource_group.rg.name
}

# Resource-2: Create Network Security Group (NSG)
/*
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${azurerm_subnet.web_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "ws_subnet_nsg" {
  name                = "${azurerm_subnet.ws_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
*/

resource "azurerm_network_security_group" "db_subnet_nsg" {
  name                = "${azurerm_subnet.db_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource-3: Associate NSG and Subnet
/*
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_asso" {
  depends_on = [ azurerm_network_security_rule.web_nsg_rule_inbound ]
  subnet_id = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "ws_subnet_nsg_asso" {
  depends_on = [ azurerm_network_security_rule.ws_nsg_rule_inbound ]
  subnet_id = azurerm_subnet.ws_subnet.id
  network_security_group_id = azurerm_network_security_group.ws_subnet_nsg.id
}
*/

resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_asso" {
  depends_on = [ azurerm_network_security_rule.db_nsg_rule_inbound ]
  subnet_id = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_subnet_nsg.id
}

/*
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each = var.web_inbound_ports_map
  name = "AllowInbound-${each.value}"
  priority = each.key
  source_port_range = "*"
  direction = "Inbound"
  protocol = "Tcp"
  access = "Allow"
  destination_port_range = each.value
  source_address_prefix = "*"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}

resource "azurerm_network_security_rule" "ws_nsg_rule_inbound" {
  for_each = var.ws_inbound_ports_map
  name = "AllowInbound-${each.value}"
  priority = each.key
  source_port_range = "*"
  direction = "Inbound"
  protocol = "Tcp"
  access = "Allow"
  destination_port_range = each.value
  source_address_prefix = "*"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.ws_subnet_nsg.name
}
*/
resource "azurerm_network_security_rule" "db_nsg_rule_inbound" {
  for_each = var.db_inbound_ports_map
  name = "AllowInbound-${each.value}"
  priority = each.key
  source_port_range = "*"
  direction = "Inbound"
  protocol = "Tcp"
  access = "Allow"
  destination_port_range = each.value
  source_address_prefix = "*"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.db_subnet_nsg.name
}

resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${azurerm_subnet.web_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  dynamic "security_rule" {
    for_each = var.web_inbound_ports_map
      content {
        name = "AllowInbound-${security_rule.value}"
        priority = security_rule.key
        source_port_range = "*"
        direction = "Inbound"
        protocol = "Tcp"
        access = "Allow"
        destination_port_range = security_rule.value
        source_address_prefix = "*"
        destination_address_prefix = "*"
      }
    }
}

resource "azurerm_network_security_group" "ws_subnet_nsg" {
  name                = "${azurerm_subnet.ws_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  dynamic "security_rule" {
    for_each = var.ws_inbound_ports_map
      content {
        name = "AllowInbound-${security_rule.value}"
        priority = security_rule.key
        source_port_range = "*"
        direction = "Inbound"
        protocol = "Tcp"
        access = "Allow"
        destination_port_range = security_rule.value
        source_address_prefix = "*"
        destination_address_prefix = "*"
      }
    }
}

resource "azurerm_network_security_group" "bastion_subnet_nsg" {
  name                = "${azurerm_subnet.bastion_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  dynamic "security_rule" {
    for_each = var.bastion_inbound_ports_map
      content {
        name = "AllowInbound-${security_rule.value}"
        priority = security_rule.key
        source_port_range = "*"
        direction = "Inbound"
        protocol = "Tcp"
        access = "Allow"
        destination_port_range = security_rule.value
        source_address_prefix = "160.155.38.221"
        destination_address_prefix = "*"
      }
    }
}


resource "azurerm_network_security_group" "app_gw_subnet_nsg" {
  name                = "${azurerm_subnet.app_gw_subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  dynamic "security_rule" {
    for_each = var.app_gw_inbound_ports_map
      content {
        name = "AllowInbound-${security_rule.value}"
        priority = security_rule.key
        source_port_range = "*"
        direction = "Inbound"
        protocol = "Tcp"
        access = "Allow"
        destination_port_range = security_rule.value
        source_address_prefix = "160.155.38.221"
        destination_address_prefix = "*"
      }
    }
}