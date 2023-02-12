output "private_endpoint_id" {
  value       = azurerm_private_endpoint.main.id
  description = "ID of the private endpoint"
}

output "private_endpoint_ip" {
  value       = azurerm_private_endpoint.main.private_service_connection[0].private_ip_address
  description = "IP of the private endpoint"
}
