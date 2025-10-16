data "azurerm_key_vault" "mydatakv" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}
data "azurerm_key_vault_secret" "myvmusername" {
  name         = "myvmuser"
  key_vault_id = data.azurerm_key_vault.mydatakv.id
}

data "azurerm_key_vault_secret" "myvmpassword" {
  name         = "mypwd"
  key_vault_id = data.azurerm_key_vault.mydatakv.id
}
data "azurerm_network_interface" "mydataNIC" {
  name                = var.network_interface_name
  resource_group_name = var.resource_group_name
}
#frontend Virtual Machine
resource "azurerm_linux_virtual_machine" "frontendVM" {
  name                            = var.virtual_machine_name
  resource_group_name             = var.resource_group_name
  location                        = var.virtual_machine_location
  size                            = "Standard_B1s"
  admin_username                  = data.azurerm_key_vault_secret.myvmusername.value
  admin_password                  = data.azurerm_key_vault_secret.myvmpassword.value
  disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.mydataNIC.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = base64encode(<<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install -y nginx
        sudo systemctl enable nginx
        sudo systemctl start nginx
      EOF
      )
}