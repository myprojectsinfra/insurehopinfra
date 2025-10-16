variable "virtual_network_name" {
  description = "This is the name of the virtual network"
  type        = string
}
variable "virtual_network_location" {
  description = "This is the location of the virtual network"
  type        = string
}
variable "resource_group_name" {
  description = "This is the resource group"
  type        = string
}
variable "address_space" {
  description = "This is address space"
  type        = list(string)
}