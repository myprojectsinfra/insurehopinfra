
data "azurerm_network_interface" "mydatanic" {
  name                = var.network_interface_name
  resource_group_name = var.resource_group_name
}
data "azurerm_network_security_group" "mydatansg" {
  name                = var.network_security_group_name
  resource_group_name = var.resource_group_name
}
resource "azurerm_network_interface_security_group_association" "nsgassociation" {
  network_interface_id      = data.azurerm_network_interface.mydatanic.id
  network_security_group_id = data.azurerm_network_security_group.mydatansg.id

}