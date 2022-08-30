/*
resource "azurerm_linux_virtual_machine" "bastion_linux_vm" {
  name = "${local.resource_name_prefix}-${local.module}-bastion"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  size = "Standard_B2s"
  
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  
  os_disk {
    name = "bastion-linux-os-disk-${random_string.myrandom.id}"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = 75
  }

  admin_ssh_key {
    username = "cecom"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  admin_username = "cecom"
  admin_password = "Albatres$2014"
  disable_password_authentication = false
  custom_data = filebase64("${path.module}/app-scripts/redhat-bastion-script.sh")
  tags = local.bastion_common_tags  
}
*/