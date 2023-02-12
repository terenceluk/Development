/*output "vm_id" {
  description = "Virtual machine ids created."
  value       = azurerm_linux_virtual_machine.main.id
}

output "vm_name" {
  description = "Virtual machine names created."
  value       = azurerm_linux_virtual_machine.main.name
}

output "network_interface_id" {
  description = "ids of the vm nics provisoned."
  value       = azurerm_network_interface.main.id
}

output "network_interface_private_ip" {
  description = "private ip addresses of the vm nics"
  value       = azurerm_network_interface.main.private_ip_address
}

output "availability_set_id" {
  description = "The ID of the Availability Set."
  value       = try(azurerm_availability_set.main[0].id, null)
}

output "data_disk_ids" {
  description = "The ID of the Virtual Machine Data Disk attachment"
  value       = { for k, v in azurerm_virtual_machine_data_disk_attachment.main : k => v.id }
}

output "managed_disk_id" {
  description = "The ID of the Managed Disk"
  value       = { for k, v in azurerm_managed_disk.main : k => v.id }
}
*/