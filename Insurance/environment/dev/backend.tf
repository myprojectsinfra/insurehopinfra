
terraform {

  backend "azurerm" {
    resource_group_name  = "mybackendrg"
    storage_account_name = "mybackendstorageacc"
    container_name       = "myblobcontainer"
    key                  = "terraform.tfstate"
  }

}

