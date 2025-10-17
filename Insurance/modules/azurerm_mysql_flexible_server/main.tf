resource "azurerm_mysql_flexible_server" "mysqlserver" {
  name                   = var.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.resource_group_location
  administrator_login    = "ankituserdb"
  administrator_password = "Ankit@12345$"
  sku_name               = "B_Standard_B1ms"
  version                = "8.0.21"

  storage {
    size_gb = 32
  }
  backup_retention_days = 7
  geo_redundant_backup_enabled = false

  high_availability {
    mode = "ZoneRedundant"
  }
  maintenance_window {
    day_of_week   = 6
    start_hour    = 1
    start_minute  = 0
  }
}