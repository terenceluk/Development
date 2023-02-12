output "storage_account_name" {
  value       = azurerm_storage_account.main.name
  description = "Name of storage account create"
}

output "storage_account_id" {
  value       = azurerm_storage_account.main.id
  description = "ID of storage account create"
}

output "storage_account_primary_location" {
  value       = azurerm_storage_account.main.primary_location
  description = "The primary location of the storage account"
}

output "storage_account_secondary_location" {
  value       = azurerm_storage_account.main.secondary_location
  description = "The secondary location of the storage account"
}

output "storage_account_primary_blob_endpoint" {
  value       = azurerm_storage_account.main.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location"
}

output "storage_account_primary_blob_host" {
  value       = azurerm_storage_account.main.primary_blob_host
  description = "The hostname with port if applicable for blob storage in the primary location"
}

output "storage_account_secondary_blob_endpoint" {
  value       = azurerm_storage_account.main.secondary_blob_endpoint
  description = "The endpoint URL for blob storage in the secondary location"
}

output "storage_account_secondary_blob_host" {
  value       = azurerm_storage_account.main.secondary_blob_host
  description = "The hostname with port if applicable for blob storage in the secondary location"
}

output "storage_account_primary_queue_endpoint" {
  value       = azurerm_storage_account.main.primary_queue_endpoint
  description = "The endpoint URL for queue storage in the primary location"
}

output "storage_account_primary_queue_host" {
  value       = azurerm_storage_account.main.primary_queue_host
  description = "The hostname with port if applicable for queue storage in the primary location"
}

output "storage_account_secondary_queue_endpoint" {
  value       = azurerm_storage_account.main.secondary_queue_endpoint
  description = "The endpoint URL for queue storage in the secondary location"
}

output "storage_account_secondary_queue_host" {
  value       = azurerm_storage_account.main.secondary_queue_host
  description = "The hostname with port if applicable for queue storage in the secondary location"
}

output "storage_account_primary_table_endpoint" {
  value       = azurerm_storage_account.main.primary_table_endpoint
  description = "The endpoint URL for table storage in the primary location"
}

output "storage_account_primary_table_host" {
  value       = azurerm_storage_account.main.primary_table_host
  description = "The hostname with port if applicable for table storage in the primary location"
}

output "storage_account_secondary_table_endpoint" {
  value       = azurerm_storage_account.main.secondary_table_endpoint
  description = "The endpoint URL for table storage in the secondary location"
}

output "storage_account_secondary_table_host" {
  value       = azurerm_storage_account.main.secondary_table_host
  description = "The hostname with port if applicable for table storage in the secondary location"
}

output "storage_account_primary_file_endpoint" {
  value       = azurerm_storage_account.main.primary_file_endpoint
  description = "The endpoint URL for file storage in the primary location"
}

output "storage_account_primary_file_host" {
  value       = azurerm_storage_account.main.primary_file_host
  description = "The hostname with port if applicable for file storage in the primary location"
}

output "storage_account_secondary_file_endpoint" {
  value       = azurerm_storage_account.main.secondary_file_endpoint
  description = "The endpoint URL for file storage in the secondary location"
}

output "storage_account_secondary_file_host" {
  value       = azurerm_storage_account.main.secondary_file_host
  description = "The hostname with port if applicable for file storage in the secondary location"
}

output "storage_account_primary_dfs_endpoint" {
  value       = azurerm_storage_account.main.primary_dfs_endpoint
  description = "The endpoint URL for DFS storage in the primary location"
}

output "storage_account_primary_dfs_host" {
  value       = azurerm_storage_account.main.primary_dfs_host
  description = "The hostname with port if applicable for DFS storage in the primary location"
}

output "storage_account_secondary_dfs_endpoint" {
  value       = azurerm_storage_account.main.secondary_dfs_endpoint
  description = "The endpoint URL for DFS storage in the secondary location"
}

output "storage_account_secondary_dfs_host" {
  value       = azurerm_storage_account.main.secondary_dfs_host
  description = "The hostname with port if applicable for DFS storage in the secondary location"
}

output "storage_account_primary_web_endpoint" {
  value       = azurerm_storage_account.main.primary_web_endpoint
  description = "The endpoint URL for web storage in the primary location"
}

output "storage_account_primary_web_host" {
  value       = azurerm_storage_account.main.primary_web_host
  description = "The hostname with port if applicable for web storage in the primary location"
}

output "storage_account_secondary_web_endpoint" {
  value       = azurerm_storage_account.main.secondary_web_endpoint
  description = "The endpoint URL for web storage in the secondary location"
}

output "storage_account_secondary_web_host" {
  value       = azurerm_storage_account.main.secondary_web_host
  description = "The hostname with port if applicable for web storage in the secondary location"
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.main.primary_access_key
  description = "The primary access key for the storage account"
  sensitive   = true
}

output "storage_account_secondary_access_key" {
  value       = azurerm_storage_account.main.secondary_access_key
  description = "The secondary access key for the storage account"
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  value       = azurerm_storage_account.main.primary_connection_string
  description = "The connection string associated with the primary location"
  sensitive   = true
}

output "storage_account_secondary_connection_string" {
  value       = azurerm_storage_account.main.secondary_connection_string
  description = "The connection string associated with the secondary location"
  sensitive   = true
}

output "storage_account_primary_blob_connection_string" {
  value       = azurerm_storage_account.main.primary_blob_connection_string
  description = "The connection string associated with the primary blob location"
  sensitive   = true
}

output "storage_account_secondary_blob_connection_string" {
  value       = azurerm_storage_account.main.secondary_blob_connection_string
  description = "The connection string associated with the secondary blob location"
  sensitive   = true
}

output "storage_account_identity" {
  value       = azurerm_storage_account.main.identity
  description = "The Tenant ID for the Service Principal associated with the Identity of this Storage Account"
}

output "storag_account_container_name" {
  value       = { for k, v in azurerm_storage_container.main : k => v.name }
  description = "Name of the containers"
}

output "storage_account_container_id" {
  value       = { for k, v in azurerm_storage_container.main : k => v.id }
  description = "The ID of the Storage Container"
}

output "storage_account_container_has_immutability_policy" {
  value       = { for k, v in azurerm_storage_container.main : k => v.has_immutability_policy }
  description = "Is there an Immutability Policy configured on this Storage Container?"
}

output "storage_account_container_has_legal_hold" {
  value       = { for k, v in azurerm_storage_container.main : k => v.has_legal_hold }
  description = "Is there a Legal Hold configured on this Storage Container?"
}

output "storage_account_container_resource_manager_id" {
  value       = { for k, v in azurerm_storage_container.main : k => v.resource_manager_id }
  description = "The Resource Manager ID of this Storage Container"
}

output "storage_account_share_name" {
  value       = { for k, v in azurerm_storage_share.main : k => v.name }
  description = "Names of the shares getting created"
}

output "storage_account_share_id" {
  value       = { for k, v in azurerm_storage_share.main : k => v.id }
  description = "ID of the shares getting created"
}

output "storage_account_share_resource_manager_id" {
  value       = { for k, v in azurerm_storage_share.main : k => v.resource_manager_id }
  description = "The Resource Manager ID of this File Share"
}

output "storage_account_share_url" {
  value       = { for k, v in azurerm_storage_share.main : k => v.url }
  description = "The URL of the File Share"
}

output "storage_account_share_directory_name" {
  value       = { for k, v in azurerm_storage_share_directory.main : k => v.name }
  description = "List of the share directories created"
}

output "storage_account_share_directory_id" {
  value       = { for k, v in azurerm_storage_share_directory.main : k => v.id }
  description = "The ID of the Directory within the File Share"
}

output "storage_account_dfs_name" {
  value       = { for k, v in azurerm_storage_data_lake_gen2_filesystem.main : k => v.name }
  description = "Name of the datalake shares created"
}

output "storage_account_dfs_id" {
  value       = { for k, v in azurerm_storage_data_lake_gen2_filesystem.main : k => v.id }
  description = "ID of the datalake shares created"
}

output "storage_account_table_id" {
  value       = { for k, v in azurerm_storage_table.main : k => v.id }
  description = "The ID of the Table within the Storage Account."
}

output "storage_account_table_name" {
  value       = { for k, v in azurerm_storage_table.main : k => v.name }
  description = "Name of the Table within the Storage Account."
}

output "storage_account_table_entity_name" {
  value       = { for k, v in azurerm_storage_table_entity.main : k => v.name }
  description = "Name of the Entity within the Table in the Storage Account."
}

output "storage_account_table_entity_id" {
  value       = { for k, v in azurerm_storage_table_entity.main : k => v.id }
  description = "Name of the Entity within the Table in the Storage Account."
}
output "storage_account_queue_id" {
  value       = { for k, v in azurerm_storage_queue.main : k => v.id }
  description = "The ID of the queue that is created within Storage Account."
}

output "storage_account_queue_name" {
  value       = { for k, v in azurerm_storage_queue.main : k => v.name }
  description = "Name of the queue that is created within Storage Account."
}
