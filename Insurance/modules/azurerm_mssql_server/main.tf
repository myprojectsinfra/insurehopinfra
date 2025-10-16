data "azurerm_client_config" "current" {}
resource "azurerm_mssql_server" "mySQLServer" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = "12.0"
  administrator_login          = "ankituserdb"
  administrator_login_password = "Ankit@12345$"
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "ankitkumardb"
    object_id      = data.azurerm_client_config.current.object_id
  }


}