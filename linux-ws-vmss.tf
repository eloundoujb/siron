/*resource "azurerm_linux_virtual_machine_scale_set" "ws_linux_vmss" {
  
  name = "${local.resource_name_prefix}-${local.module}-ws-vmss"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = var.sku_ws_instance
  instances = var.ws_vmss_instance
  
  #upgrade_mode Automatic en when vmss associate with LB
  upgrade_mode = var.upgrade_mode

  admin_username = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = var.pwd_auth
  
  os_disk {    
    caching = var.caching
    storage_account_type = var.storage_account_type
    disk_size_gb = var.disk_size_gb
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku_image
    version   = var.vers
  }

  network_interface {
    name = "${azurerm_resource_group.rg.name}-ws-vmss-nic"
    primary = "true"
    network_security_group_id = azurerm_network_security_group.ws_subnet_nsg.id
    
    ip_configuration {
        name = "${azurerm_resource_group.rg.name}-ws-vmss-nic-config"
        primary = "true"
        subnet_id = azurerm_subnet.ws_subnet.id
        load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.ws_lb_backend_pool.id]
    }
  } 

  health_probe_id = azurerm_lb_probe.ws_lb_probe.id
  
  admin_ssh_key {
    username = var.username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  tags = local.ws_common_tags

  custom_data = filebase64("${path.module}/app-scripts/redhat-appvm-script.sh")

}
*/