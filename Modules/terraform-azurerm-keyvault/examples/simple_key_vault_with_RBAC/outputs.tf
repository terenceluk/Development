output "vault_id" {
  value       = { for k, v in module.keyvault : k => v.vault_id }
  description = "The ID of the Key Vault."
}

output "vault_uri" {
  value       = { for k, v in module.keyvault : k => v.vault_uri }
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
}
