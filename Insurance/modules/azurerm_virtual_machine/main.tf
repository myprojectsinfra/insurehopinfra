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
  set -e

  # Update package list
  sudo apt-get update -y

  # Install Apache, PHP, MySQL client, and phpMyAdmin
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 php libapache2-mod-php php-mysql phpmyadmin mysql-client

  # Enable required Apache modules
  sudo a2enmod php7.4 || true  # adjust PHP version if needed
  sudo a2enmod rewrite

  # Link phpMyAdmin to the Apache web directory
  if [ ! -L /var/www/html/phpmyadmin ]; then
      sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
  fi

  # Restart Apache to apply changes
  sudo systemctl restart apache2
  sudo systemctl enable apache2

  # Create a PHP info test page
  echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

  # Adjust permissions
  sudo chown www-data:www-data /var/www/html/*.php
  sudo chmod 644 /var/www/html/*.php
EOF
)
}