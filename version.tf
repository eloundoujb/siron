terraform {
  required_providers {
    azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
  }

  required_version = "~> 1.2.0"
}

provider "azurerm" {
    features {}
    subscription_id = "69cb30dd-c5cb-4d1c-810f-ebf712bcbadb"
    tenant_id       = "37112b6c-e542-459a-b01e-48d54fe35d50"

}