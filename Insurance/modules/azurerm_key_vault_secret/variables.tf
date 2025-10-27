variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
variable "key_vault_name" {
  description = "The name of Key Vault."
  type        = string
}
variable "secret_name" {
  description = "The name of secret"
  type        = string
}
variable "secret_value" {
  description = "The value of secret"
  type        = string
}