output "vm_ids" {
  description = "Virtual machine ids created."
  value       = { for k, v in azurerm_virtual_machine.vm-linux : k => v.id }
}

output "network_interface_ids" {
  description = "ids of the vm nics provisoned."
  value       = { for k, v in azurerm_network_interface.main : k => v.id }
}

output "network_interface_private_ip" {
  description = "private ip addresses of the vm nics"
  value       = { for k, v in azurerm_network_interface.main : k => v.private_ip_address }
}

output "availability_set_id" {
  description = "id of the availability set where the vms are provisioned."
  value       = azurerm_availability_set.main.id
}

output "random_password" {
  description = "When random password given print it"
  sensitive   = true
  value       = { for k, v in random_password.main : k => v.result }
}
