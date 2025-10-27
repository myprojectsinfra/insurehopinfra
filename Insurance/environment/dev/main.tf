
module "rg_group" {
  source                  = "../../modules/aurerm_resource_group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}
module "virtual_network" {
  depends_on               = [module.rg_group]
  source                   = "../../modules/azurerm_virtual_network"
  virtual_network_name     = var.virtual_network_name
  resource_group_name      = var.resource_group_name
  virtual_network_location = var.virtual_network_location
  address_space            = var.address_space

}
module "subnet" {
  depends_on           = [module.rg_group, module.virtual_network]
  source               = "../../modules/azurerm_subnet"
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  subnetsv             = var.subnetsv
}

module "public_ip" {
  depends_on              = [module.rg_group, module.virtual_network]
  source                  = "../../modules/azurerm_public_ip"
  public_ip_name          = var.public_ip_name
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  allocation_method       = var.allocation_method
}
module "network_interface" {
  depends_on                 = [module.rg_group, module.public_ip, module.subnet]
  source                     = "../../modules/azurerm_network_interface"
  subnet_name                = "subnet-web"
  resource_group_name        = var.resource_group_name
  virtual_network_name       = var.virtual_network_name
  public_ip_name             = var.public_ip_name
  network_interface_name     = var.network_interface_name
  network_interface_location = var.network_interface_location

}
module "mysql_server" {
  depends_on              = [module.rg_group, module.virtual_network, module.subnet]
  source                  = "../../modules/azurerm_mysql_flexible_server"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  mysql_server_name       = var.mysql_server_name
  virtual_network_name    = var.virtual_network_name
  subnet_id               = module.subnet.subnet_id

}
module "mysql_database" {
  depends_on          = [module.rg_group, module.virtual_network, module.subnet, module.mysql_server]
  source              = "../../modules/azurerm_mysql_flexible_database"
  resource_group_name = var.resource_group_name
  mysql_server_name   = var.mysql_server_name
  mysql_database_name = var.mysql_database_name

}
module "network_security_group" {
  depends_on                  = [module.rg_group, module.virtual_network, module.subnet, module.public_ip]
  source                      = "../../modules/azurerm_network_security_group"
  resource_group_name         = var.resource_group_name
  resource_group_location     = var.resource_group_location
  network_security_group_name = var.network_security_group_name

}
module "network_security_group_association" {
  depends_on                  = [module.rg_group, module.virtual_network, module.subnet, module.public_ip, module.network_security_group]
  source                      = "../../modules/azurerm_network_security_group_association"
  network_security_group_name = var.network_security_group_name
  resource_group_name         = var.resource_group_name
  network_interface_name      = var.network_interface_name

}
module "key_vault" {
  depends_on              = [module.rg_group]
  source                  = "../../modules/azurerm_key_vault"
  key_vault_name          = var.key_vault_name
  resource_group_location = var.resource_group_location
  resource_group_name     = var.resource_group_name
}

module "vm_username" {

  depends_on          = [module.rg_group, module.key_vault]
  source              = "../../modules/azurerm_key_vault_secret"
  key_vault_name      = var.key_vault_name
  resource_group_name = var.resource_group_name
  secret_name         = "myvmuser"
  secret_value        = "ankitkumar2692"
}

module "vm_password" {
  depends_on          = [module.key_vault]
  source              = "../../modules/azurerm_key_vault_secret"
  key_vault_name      = var.key_vault_name
  resource_group_name = var.resource_group_name
  secret_name         = "mypwd"
  secret_value        = "Ankit@12345$"
}
module "virtual_machine" {
  depends_on               = [module.rg_group, module.virtual_network, module.subnet, module.public_ip, module.network_interface, module.key_vault, module.vm_username, module.vm_password]
  source                   = "../../modules/azurerm_virtual_machine"
  key_vault_name           = var.key_vault_name
  network_interface_name   = var.network_interface_name
  resource_group_name      = var.resource_group_name
  virtual_network_name     = var.virtual_network_name
  virtual_machine_name     = var.virtual_machine_name
  virtual_machine_location = var.virtual_machine_location


}
