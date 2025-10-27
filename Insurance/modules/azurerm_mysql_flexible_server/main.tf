
data "azurerm_virtual_network" "existing_vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}
resource "azurerm_private_dns_zone" "mydns_zone" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns-link" {
  depends_on = [azurerm_private_dns_zone.mydns_zone]
  name                  = "insurancednszone"
  private_dns_zone_name = azurerm_private_dns_zone.mydns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = var.resource_group_name
}

resource "azurerm_mysql_flexible_server" "mysqlserver" {
  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns-link]
  name                   = var.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.resource_group_location
  administrator_login    = "ankituserdbadmin"
  administrator_password = "Ankit@12345$"
  backup_retention_days  = 7
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.mydns_zone.id
  sku_name               = "GP_Standard_D2ds_v4"

  
}