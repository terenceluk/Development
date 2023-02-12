output "user_assigned_identity_id" {
  value       = module.authorization-uami.user_assigned_identity_id
  description = "The ID of the User Assigned Identity."
}

output "storage_account_name" {
  value       = { for k, v in module.storage_account : k => v.storage_account_name }
  description = "Name of storage account create"
}

output "storage_account_id" {
  value       = { for k, v in module.storage_account : k => v.storage_account_id }
  description = "ID of storage account create"
}

output "storage_account_primary_access_key" {
  value       = { for k, v in module.storage_account : k => v.storage_account_primary_access_key }
  description = "The primary access key for the storage account."
  sensitive   = true
}


output "storage_account_secondary_access_key" {
  value       = { for k, v in module.storage_account : k => v.storage_account_secondary_access_key }
  description = "The secondary access key for the storage account."
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  value       = { for k, v in module.storage_account : k => v.storage_account_primary_connection_string }
  description = "The connection string associated with the primary location."
  sensitive   = true
}

output "storage_account_secondary_connection_string" {
  value       = { for k, v in module.storage_account : k => v.storage_account_secondary_connection_string }
  description = "The connection string associated with the secondary location."
  sensitive   = true
}

output "storage_account_primary_blob_connection_string" {
  value       = { for k, v in module.storage_account : k => v.storage_account_primary_blob_connection_string }
  description = "The connection string associated with the primary blob location."
  sensitive   = true
}

output "storage_account_primary_blob_endpoint" {
  value       = { for k, v in module.storage_account : k => v.storage_account_primary_blob_endpoint }
  description = "The endpoint URL for blob storage in the primary location."
}

output "storage_account_secondary_blob_connection_string" {
  value       = { for k, v in module.storage_account : k => v.storage_account_secondary_blob_connection_string }
  description = "The connection string associated with the secondary blob location."
  sensitive   = true
}

output "storag_account_container_name" {
  value       = { for k, v in module.storage_account : k => v.storag_account_container_name }
  description = "Name of the containers"
}

output "storage_account_container_id" {
  value       = { for k, v in module.storage_account : k => v.storage_account_container_id }
  description = "ID of the containers"
}

output "storage_account_share_name" {
  value       = { for k, v in module.storage_account : k => v.storage_account_share_name }
  description = "Names of the shares getting created"
}

output "storage_account_share_id" {
  value       = { for k, v in module.storage_account : k => v.storage_account_share_id }
  description = "ID of the shares getting created"
}

output "storage_account_share_directory_name" {
  value       = { for k, v in module.storage_account : k => v.storage_account_share_directory_name }
  description = "List of the share directories created"
}

output "storage_account_dfs_name" {
  value       = { for k, v in module.storage_account : k => v.storage_account_dfs_name }
  description = "Name of the datalake shares created"
}

output "storage_account_table_id" {
  value       = { for k, v in module.storage_account : k => v.storage_account_table_id }
  description = " The ID of the Table within the Storage Account."
}

output "storage_account_table_entity_id" {
  value       = { for k, v in module.storage_account : k => v.storage_account_table_entity_id }
  description = "The ID of the Entity within the Table in the Storage Account."
}

output "storage_account_queue_id" {
  value       = { for k, v in module.storage_account : k => v.storage_account_queue_id }
  description = " The ID of the Table within the Storage Account."
}

output "storage1" {
  value = module.storage_account["storage1"].storage_account_name
}

output "storage2" {
  value = module.storage_account["storage2"].storage_account_name
}

output "storage3" {
  value = module.storage_account["storage3"].storage_account_name
}

output "storage4" {
  value = module.storage_account["storage4"].storage_account_name
}

output "storage4_id" {
  value = module.storage_account["storage4"].storage_account_id
}