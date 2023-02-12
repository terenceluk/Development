output "vnet_name" {
  value       = azurerm_virtual_network.main.name
  description = "Name of the created virtual network"
}

output "vnet_id" {
  value       = azurerm_virtual_network.main.id
  description = "ID of the created virtual network"
}

output "vnet_rg" {
  value       = azurerm_virtual_network.main.resource_group_name
  description = "Resource Group VNet is created in"
}
