
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }


}

provider "azurerm" {
  features {}
  subscription_id = "aecd117e-e024-472e-8fd5-826953f3632b"

}