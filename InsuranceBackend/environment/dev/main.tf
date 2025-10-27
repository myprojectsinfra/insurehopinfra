module "rg_group" {

  # for_each = var.resource_group_name
  source                  = "../../modules/aurerm_resource_group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}

module "az_storage" {
  depends_on              = [module.rg_group]
  source                  = "../../modules/azurerm_storage_account"
  storage_account_name    = var.storage_account_name
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}
module "az_storage_container" {
  depends_on           = [module.rg_group, module.az_storage]
  source               = "../../modules/azurerm_storage_container"
  storagecontainername = var.storagecontainername
  storage_account_name = var.storage_account_name
  resource_group_name  = var.resource_group_name
}