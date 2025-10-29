variable "subscription_id" {
  description = "The subscription id."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}
variable "virtual_network_name" {
  description = "The name of the Virtual Network."
  type        = string
}
variable "virtual_network_location" {
  description = "The location of the Virtual Network."
  type        = string
}
variable "subnet_name" {
  description = "The name of the subnet for nic."
  type        = string
}
variable "subnetsv" {
  description = "The details of the Subnets."
  type = map(object({
    subnet_name = string

    address_prefixes = list(string)
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))
}
variable "public_ip_name" {
  description = "The name of the Public IP."
  type        = string
}
variable "address_space" {
  description = "Address space for Virtual Network."
  type        = list(string)
}

variable "allocation_method" {
  description = "The allocation method"
  type        = string
}
variable "virtual_machine_name" {
  description = "The name of the Virtual Name."
  type        = string
}
variable "network_interface_name" {
  description = "The name of the Network Interface."
  type        = string
}
variable "network_interface_location" {
  description = "The location of the Network Interface."
  type        = string
}
variable "virtual_machine_location" {
  description = "The location of the Virtual Machine."
  type        = string
}
variable "mysql_server_name" {
  description = "The Unique name of the MYSQL Server."
  type        = string
}
variable "mysql_database_name" {
  description = "The Unique name of the MYSQL Database."
  type        = string
}
variable "network_security_group_name" {
  description = "The name of the NSG."
  type        = string
}
variable "key_vault_name" {
  description = "The name of Key Vault."
  type        = string
}
