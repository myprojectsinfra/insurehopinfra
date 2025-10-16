variable "key_vault_name" {
  description = "The name of Key Vault."
  type        = string
}
variable "network_interface_name" {
  description = "The name of the Network Interface."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group where the public IP will be created."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "virtual_machine_name" {
  description = "The name of the virtual machine."
  type        = string
}
variable "virtual_machine_location" {
  description = "The Azure region where Virtual machine will be created"
  type        = string
}
