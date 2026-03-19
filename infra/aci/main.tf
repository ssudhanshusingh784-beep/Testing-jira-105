terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "prefix" {}
variable "resource_group_name" {}
variable "location" {}
variable "acr_login_server" {}
variable "acr_username" {}
variable "acr_password" {}
variable "image_name" {}
variable "image_tag" {}
variable "cpu" { type = number default = 0.5 }
variable "memory" { type = number default = 1.0 }
variable "container_port" { type = number default = 8000 }

resource "random_id" "suffix" {
  byte_length = 2
}

resource "azurerm_container_group" "aci" {
  name                = "${var.prefix}-aci-${random_id.suffix.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  ip_address_type     = "public"
  dns_name_label      = lower("${var.prefix}-${var.image_name}-${random_id.suffix.hex}")

  container {
    name   = var.image_name
    image  = "${var.acr_login_server}/${var.image_name}:${var.image_tag}"
    cpu    = var.cpu
    memory = var.memory
    ports {
      port     = var.container_port
      protocol = "TCP"
    }
  }

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_username
    password = var.acr_password
  }
}

output "container_fqdn" {
  description = "Public FQDN for the container group"
  value       = azurerm_container_group.aci.fqdn
}
