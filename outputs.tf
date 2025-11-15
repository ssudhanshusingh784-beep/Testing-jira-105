output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vm_name" {
  value = azurerm_virtual_machine.vm.name
}

output "private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}
