output "vm_id" {
  value = module.linux-vm01.vm_id
}

output "vm_name" {
  value = module.linux-vm01.vm_name
}

output "network_interface_id" {
  value = module.linux-vm01.network_interface_id
}

output "network_interface_private_ip" {
  value = module.linux-vm01.network_interface_private_ip
}

output "availability_set_id" {
  value = try(module.linux-vm01.availability_set_id, null)
}
