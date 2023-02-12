output "az_kv_secret_id" {
  description = "The ID of the Key Vault"
  value       = [for s in azurerm_key_vault_secret.az_key_vault_secrets : s.id]
}

output "az_kv_secret_value" {
  description = "The ID of the Key Vault"
  value       = [for s in azurerm_key_vault_secret.az_key_vault_secrets : s.value]
}