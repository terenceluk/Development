output "subnet_id" {
  value       = azurerm_subnet.main.id
  description = "The Virtual Network Subnet resource ID."
}

output "subnet_name" {
  value       = azurerm_subnet.main.name
  description = "The Virtual Network Subnet resource ID."
}