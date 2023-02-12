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
  value       = module.keyvault["keyvault2"].vault_certificate_import_secret_id
  description = "The ID of the associated Key Vault Secret.."
}

output "vault_certificate_generate_versionless_secret" {
  value       = module.keyvault["keyvault2"].vault_certificate_generate_versionless_secret
  description = "The current version of the Key Vault Certificate."
}

output "vault_certificate_import_versionless_secret" {
  value       = module.keyvault["keyvault2"].vault_certificate_import_versionless_secret
  description = "The current version of the Key Vault Certificate."
}

output "vault_secret_id" {
  value       = { for k, v in module.keyvault : k => v.vault_secret_id }
  description = "The ID of the created Key Vault Secret"
}

output "vault_secret_version" {
  value       = { for k, v in module.keyvault : k => v.vault_secret_version }
  description = "The current version of the Key Vault Secret."
}

output "vault_secret_value" {
  value       = { for k, v in module.keyvault : k => v.vault_secret_value }
  description = "The current value of the Key Vault Secret."
  sensitive   = true
}

output "keyvault1_id" {
  value       = module.keyvault["keyvault1"].vault_id
  description = "The ID of the keyvault1."
}

output "keyvault2_id" {
  value       = module.keyvault["keyvault2"].vault_id
  description = "The ID of the keyvault2."
}

output "keyvault3_id" {
  value       = module.keyvault["keyvault3"].vault_id
  description = "The ID of the keyvault3."
}

output "keyvault4_id" {
  value       = module.keyvault["keyvault4"].vault_id
  description = "The ID of the keyvault4."
}

output "keyvault5_id" {
  value       = module.keyvault["keyvault5"].vault_id
  description = "The ID of the keyvault5."
}