output "private_endpoint_id" {
  value       = { for k, v in module.private_endpoint : k => v.private_endpoint_id }
  description = "ID of the private endpoint"
}

output "private_endpoint_ip" {
  value       = { for k, v in module.private_endpoint : k => v.private_endpoint_ip }
  description = "IP of the private endpoint"
}

output "private_endpoint1_id" {
  value = module.private_endpoint["private_endpoint1"].private_endpoint_id
}

output "private_endpoint2_id" {
  value = module.private_endpoint["private_endpoint2"].private_endpoint_id
}

output "storage_account_id" {
  value = azurerm_storage_account.test1.id
}