resource_group_name      = "insurance_rg"
resource_group_location  = "brazilsouth"
virtual_network_name     = "insurancevnet"
virtual_network_location = "brazilsouth"
subnet_name              = "insurance_subnet"
public_ip_name           = "my_public_ip"
address_space            = ["192.168.0.0/16"]

allocation_method           = "Static"
network_interface_name      = "myNIC"
network_interface_location  = "brazilsouth"
virtual_machine_name        = "my-frontend-machine"
virtual_machine_location    = "brazilsouth"
mysql_server_name           = "insurancesqlserver"
mysql_database_name         = "insurancesqldatabase"
network_security_group_name = "mynsgsecgroup"
key_vault_name              = "insurance-locker"

subnetsv = {
  subnetweb = {
    subnet_name      = "subnet-web"
    address_prefixes = ["192.168.1.0/24"]
  }
  subnetmysql = {
    subnet_name      = "subnet-mysql"
    address_prefixes = ["192.168.2.0/24"]
    delegation = {
      name = "mysqlflexible"
      service_delegation = {
        name = "Microsoft.DBforMySQL/flexibleServers"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    }
  }


}