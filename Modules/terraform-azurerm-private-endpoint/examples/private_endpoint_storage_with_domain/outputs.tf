output "private_endpoint_id" {
  value       = { for k, v in module.private_endpoint : k => v.private_endpoint_id }
  description = "ID of the private endpoint"
}

output "private_endpoint_ip" {
  value       = { for k, v in module.private_endpoint : k => v.private_endpoint_ip }
  description = "IP of the private endpoint"
}
