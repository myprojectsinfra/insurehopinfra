variable "resource_group_name" {
  description = "The name of the resource group in which the subnet will be created."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network in which the subnet will be created."
  type        = string
}

variable "subnetsv" {
  description = "The details of the Subnets."
  type        = map(object({
    subnet_name = string
    
    address_prefixes = list(string)
    delegation = optional(object({
      name                = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))
}