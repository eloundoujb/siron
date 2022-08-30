# 1.0 : EJB : 22/07/2022 : Creation variables globales

variable "platforme" {
  description = "Prefix pour indiquer la plateforme OBA ou EME"
  type = string
  default = "eme"
}

variable "environnement" {
  description = "Prefix pour indiquer l'environnement Production ou PréProduction ou Developpement"
  type = string
  default = "prod"
}

variable "module" {
  description = "Prefix pour indiquer le module AML, KYC, EMBARGO, KYCRT"
  type = string
  default = "aml"
}

variable "datacenter" {
  description = "Prefix pour indiquer le data center d'hébergement KM4, VITIB, Rufisque"
  type = string
  default = "azure"
}

# Azure Resource Group Name 
variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "rg"  
}

# Azure Resources Location
variable "resource_group_location" {
  description = "Region in which Azure Resources to be created"
  type = string
  default = "eastus2"  
}

variable "tenant" {
  description = "Tenant to be created"
  type = map
  default = {
    "01"  = "ci",
    "02"  = "cm",
    "03"  = "ma"
  }
}

variable "ssh_nat_lb" {
  description = "NAT of ssh port via lb"
  type = map
  default = {
    "01" : "1022",
    "02" : "2022",
    "03" : "3022"
  }
}

variable "web_inbound_ports_map" {
  description = "NSG security rule web"
  type = map
  default = {
    "100" : "80", 
    "110" : "443",
    "120" : "22"
  } 
}

variable "ws_inbound_ports_map" {
  description = "NSG security rule ws"
  type = map
  default = {
    "100" : "80", 
    "110" : "443",
    "120" : "22"
  } 
}

variable "db_inbound_ports_map" {
  description = "NSG security rule ws"
  type = map
  default = {
    "100" : "3306", 
    "110" : "1521",
    "120" : "5432",
    "130" : "1433",
    "140" : "27017"
  } 
}

variable "bastion_inbound_ports_map" {
  description = "NSG security rule ws"
  type = map
  default = {
    "100" : "22"
  } 
}

variable "app_gw_inbound_ports_map" {
  description = "NSG security rule ws"
  type = map
  default = {
    "100" : "443"
    "110" : "80"
  } 
}

# Azure web VM Scale Set instance number Location
variable "web_vmss_instance" {
  description = "Region in which Azure Resources to be created"
  type = number
  default = 2
}

variable "ws_vmss_instance" {
  description = "Region in which Azure Resources to be created"
  type = number
  default = 2
}

variable "sku_web_instance" {
  description = "Sku of wb VM or VMSS to be created"
  type = string
  default = "Standard_B2s"
}

variable "sku_ws_instance" {
  description = "Sku of wb VM or VMSS to be created"
  type = string
  default = "Standard_B2s"
}

variable "upgrade_mode" {
  description = "Upgrade mode should by automatic for VMSS behind LB"
  type = string
  default = "Automatic"
}

variable "admin_username" {
  description = "Admin user account other than root "
  type = string
  default = "cecom"
}

variable "username" {
  description = "user account"
  type = string
  default = "cecom"
}

variable "admin_password" {
  description = "Password should be in secret or key vault"
  type = string
  default = "Albatres$2014"
}

variable "caching" {
  description = "Disk caching"
  type = string
  default = "ReadWrite"
}

variable "storage_account_type" {
  description = "storage account redundancy - Local Red Storage"
  type = string
  default = "Standard_LRS"
}

variable "disk_size_gb" {
  description = "Dsik size"
  type = number
  default = 100
}

variable "pwd_auth" {
  description = "Password authentication to be enabled"
  type = string
  default = "false"
}

variable "publisher" {
  description = "OS publish"
  type = string
  default = "RedHat"
}

variable "offer" {
  description = "OS publisher short name"
  type = string
  default = "RHEL"
}

variable "sku_image" {
  description = "OS generation"
  type = string
  default = "83-gen2"
}

variable "vers" {
  description = "OS version"
  type = string
  default = "latest"
}
 
variable "storage_account_kind" {
  description = "Storage Account Kind"
  type        = string
  default     = "StorageV2"
}
variable "static_website_index_document" {
  description = "static website index document"
  type        = string
  default     = "index.html"
}
variable "static_website_error_404_document" {
  description = "static website error 404 document"
  type        = string
  default     = "error.html"
}