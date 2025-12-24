variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "demo"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "demo-rg"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for Linux VMs (openssh format)"
  type        = string
  default     = ""
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "Size of the virtual machines"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "create_public_ip" {
  description = "Whether to assign public IPs to the VMs (set false for private deployments behind load balancer/bastion)"
  type        = bool
  default     = true
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "image_sku" {
  type    = string
  default = "20_04-lts"
}
