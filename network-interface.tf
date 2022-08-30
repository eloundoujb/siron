# Linux VM Bastion
/*
resource "azurerm_network_interface" "bastion_nic" {
  name = "${azurerm_resource_group.rg.name}-bastion-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  
  ip_configuration {
    name = "${azurerm_resource_group.rg.name}-bastion-nic-config"
    subnet_id = azurerm_subnet.bastion_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "bastion-nic-nsg-asso" {
  network_interface_id = azurerm_network_interface.bastion_nic.id
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
}

# 01 Linux VM 

resource "azurerm_network_interface" "web_nic" {
  name = "${azurerm_resource_group.rg.name}-web-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  
  ip_configuration {
    name = "${azurerm_resource_group.rg.name}-web-nic-config"
    subnet_id = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.web_pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "web-nic-nsg-asso" {
  network_interface_id = azurerm_network_interface.web_nic.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
*/


# 03 Linux VMs base on var.tenant
/*
resource "azurerm_network_interface" "web_nic" {
  for_each = var.tenant
  name = "${azurerm_resource_group.rg.name}-web-nic-${each.value}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  
  ip_configuration {
    name = "${azurerm_resource_group.rg.name}-web-nic-config"
    subnet_id = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id = azurerm_public_ip.web_pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "web-nic-nsg-asso" {
  for_each = var.tenant
  network_interface_id = azurerm_network_interface.web_nic[each.key].id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
*/