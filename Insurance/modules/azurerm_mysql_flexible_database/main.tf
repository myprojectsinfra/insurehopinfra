#data "azurerm_mssql_server" "sql_server" {
#  name                = var.sql_server_name
#  resource_group_name = var.resource_group_name
#}

#resource "azurerm_mssql_database" "sql_database" {
#  name         = var.sql_database_name
#  server_id    = data.azurerm_mssql_server.sql_server.id
#  collation    = "SQL_Latin1_General_CP1_CI_AS"
#  license_type = "LicenseIncluded"
#  max_size_gb  = 2
# sku_name     = "S0"
#}

resource "azurerm_mysql_flexible_database" "mysql_database" {
  name                = var.mysql_database_name
  resource_group_name = var.resource_group_name
  server_name         = var.mysql_server_name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}