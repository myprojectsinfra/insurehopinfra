data "azurerm_storage_account" "myStgAcc" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_storage_container" "tfstcontainer" {
  name                  = var.storagecontainername
  storage_account_id  = data.azurerm_storage_account.myStgAcc.id
  container_access_type = "private"
}
resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}