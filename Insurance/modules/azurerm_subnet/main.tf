resource "azurerm_subnet" "subnet" {
  for_each = var.subnetsv
  name                 = each.value.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
  
}