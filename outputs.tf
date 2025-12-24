output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vm_names" {
  description = "Names of the created VMs"
  value       = [for v in azurerm_virtual_machine.vm : v.name]
}

output "private_ips" {
  description = "Private IP addresses for the VMs"
  value       = [for n in azurerm_network_interface.nic : n.private_ip_address]
}

output "public_ips" {
  description = "Public IPs assigned to the VMs (may be empty if create_public_ip=false)"
  value       = [for p in azurerm_public_ip.pip : p.ip_address]
}
