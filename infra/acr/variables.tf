variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "demo"
}

variable "resource_group_name" {
  description = "Resource group name to create or use"
  type        = string
  default     = "demo-acr-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "acr_sku" {
  description = "ACR SKU"
  type        = string
  default     = "Standard"
}
