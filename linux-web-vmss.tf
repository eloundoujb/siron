locals {
web_vm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to stacksimplify - WebVM App1 - App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
CUSTOM_DATA  
}

resource "azurerm_linux_virtual_machine_scale_set" "web_linux_vmss" {
  
  name = "${local.resource_name_prefix}-${local.module}-web-vmss"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku = var.sku_web_instance
  instances = var.web_vmss_instance
  
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
    name = "${azurerm_resource_group.rg.name}-web-vmss-nic"
    primary = "true"
    network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
    
    ip_configuration {
        name = "${azurerm_resource_group.rg.name}-web-vmss-nic-config"
        primary = "true"
        subnet_id = azurerm_subnet.web_subnet.id
        #load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_backend_pool.id]
        #application_gateway_backend_address_pool_ids = one(azurerm_application_gateway.app_gateway.backend_address_pool[*].id)
        application_gateway_backend_address_pool_ids = ["${azurerm_application_gateway.app_gateway.id}/backendAddressPools/app-gw-backend-name1"]
    }
  } 

  #health_probe_id = azurerm_lb_probe.web_lb_probe.id
  
  admin_ssh_key {
    username = var.username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  tags = local.web_common_tags

  //custom_data = encodebase64("${path.module}/app-scripts/redhat-webvm-script.sh")
  custom_data = base64encode(local.web_vm_custom_data)
  
}

/*locals {
web_vm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/webvm
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/webvm/hostname.html
sudo echo "Welcome to stacksimplify - WebVM App1 - App Status Page" > /var/www/html/webvm/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Joseph Barel ELOUNDOU - Siron AML & KYC </h1> <p>CECOM - Orange</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/webvm/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/webvm/metadata.html
sudo sh -c 'echo -e "[azure-cli] 
name=Azure CLI 
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install -y azure-cli
sudo cd /etc/httpd/conf.d
sudo az storage blob download -c ${azurerm_storage_container.web_container.name} -f /etc/httpd/conf.d/app1.conf -n app1.conf --account-name ${azurerm_storage_account.storage_account.name} --account-key ${azurerm_storage_account.storage_account.primary_access_key}
sudo systemctl reload httpd
/usr/sbin/setsebool -P httpd_can_network_connect 1 
CUSTOM_DATA  
}
*/