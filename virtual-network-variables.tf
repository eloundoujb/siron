# Azure Resource Group Name 
variable "vnetwork_name" {
  description = "Virtual Network Name"
  type = string
  default = "vnet"
}

variable vnetwork_address_space {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/16"]
}

variable "db_subnet_name" {
  description = "Default subnet name"
  type = string
  default = "db-subnet"
}

variable db_subnet_address_prefix {
  description = "Default subnet address prefix"
  type = list(string)
  default = ["10.0.1.0/24"]
}

variable "web_subnet_name" {
  description = "Default subnet name"
  type = string
  default = "web-subnet"
}

variable web_subnet_address_prefix {
  description = "Default subnet address prefix"
  type = list(string)
  default = ["10.0.2.0/24"]
}

variable "ws_subnet_name" {
  description = "Default subnet name"
  type = string
  default = "ws-subnet"
}

variable ws_subnet_address_prefix {
  description = "Default subnet address prefix"
  type = list(string)
  default = ["10.0.3.0/24"]
}

variable "bastion_subnet_name" {
  description = "Default subnet name"
  type = string
  default = "bastion-subnet"
}

variable bastion_subnet_address_prefix {
  description = "Default subnet address prefix"
  type = list(string)
  default = ["10.0.4.0/27"]
}

variable "app_gw_subnet_name" {
  description = "Default subnet name"
  type = string
  default = "app-gw-subnet"
}

variable app_gw_subnet_address_prefix {
  description = "Default subnet address prefix"
  type = list(string)
  default = ["10.0.51.0/24"]
}

variable ws_nat_gateway_name {
    description = "Default ws subnet NAT Gateway name"
  type = string
  default = "ws-nat-gateway"
}
