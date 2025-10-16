variable "subscription_id" {
  description = "Azure Subscription ID"
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
variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}
variable "storagecontainername" {
  description = "The name of the blob container for storage account."
  type        = string
}
