output "vault_id" {
  value       = { for k, v in module.keyvault : k => v.vault_id }
  description = "The ID of the Key Vault."
}

output "vault_uri" {
  value       = { for k, v in module.keyvault : k => v.vault_uri }
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
}

output "vault_certificate_generate_secret_id" {
  value       = module.keyvault["keyvault3"].vault_certificate_generate_secret_id
  description = "The ID of the associated Key Vault Secret.."
}

output "vault_certificate_import_secret_id" {
  value       = module.keyvault["keyvault3"].vault_certificate_import_secret_id
  description = "The ID of the associated Key Vault Secret.."
}
