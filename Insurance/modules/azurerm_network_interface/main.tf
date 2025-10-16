data "azurerm_subnet" "mydevSubnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}
data "azurerm_public_ip" "myPublicIP" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}
resource "azurerm_network_interface" "nic" {
  name                = var.network_interface_name
  location            = var.network_interface_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.mydevSubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.myPublicIP.id
  }
}