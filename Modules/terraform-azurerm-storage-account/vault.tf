locals {
  path = format("%s/%s", local.resource_group_name, azurerm_storage_account.main.name)
  secrets = [
    "primary_access_key",
    "secondary_access_key",
    "primary_connection_string",
    "secondary_connection_string",
    "primary_blob_connection_string",
    "secondary_blob_connection_string"
  ]
}

module "vault_mount_secrets" {
  for_each = lower(var.vault_type) == "hashicorp" ? toset(["hashicorp"]) : []
  source   = "terraform.corp.ad.ctc/azure/mount-secrets/vault"
  version  = "1.1.2"

  type        = "azure"
  secret_name = local.path
  data_json   = <<EOT
  {
    "primary_access_key": "${azurerm_storage_account.main.primary_access_key}",
    "secondary_access_key": "${azurerm_storage_account.main.secondary_access_key}",
    "primary_connection_string": "${azurerm_storage_account.main.primary_connection_string}",
    "secondary_connection_string": "${azurerm_storage_account.main.secondary_connection_string}",
    "primary_blob_connection_string": "${azurerm_storage_account.main.primary_blob_connection_string}",
    "secondary_blob_connection_string": "${azurerm_storage_account.main.secondary_blob_connection_string}"
  }
 EOT
  depends_on  = [azurerm_storage_account.main, azurerm_storage_container.main]
}

resource "azurerm_key_vault_secret" "main" {
  for_each     = lower(var.vault_type) == "akv" && var.key_vault_id == null ? toset(local.secrets) : []
  name         = replace(each.key, "_", "-")
  value        = lookup(azurerm_storage_account.main, each.key)
  key_vault_id = module.keyvault["enabled"].vault_id
  depends_on   = [module.keyvault["enabled"]]
}

resource "azurerm_key_vault_secret" "custom_akv" {
  for_each     = lower(var.vault_type) == "akv" && var.key_vault_id != null ? toset(local.secrets) : []
  name         = format("%s-%s", azurerm_storage_account.main.name, replace(each.key, "_", "-"))
  value        = lookup(azurerm_storage_account.main, each.key)
  key_vault_id = var.key_vault_id
}
