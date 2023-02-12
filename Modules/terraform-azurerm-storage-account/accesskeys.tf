locals {
  key_vault_terraform_default_object_id = {
    sandbox = "2a1d9e1e-f5eb-4231-87fc-ba09575f71c2"
    nonprod = "fb2f32f3-f3d2-4b1b-a376-2d99657100b8"
    infra   = "c1b3dbe7-f6c7-42c4-ad06-187cb31bfa49"
    prod    = "c1cdaab5-8564-4812-a6cc-b25421786fef"
  }
}

module "keyvault" {
  source                    = "terraform.corp.ad.ctc/azure/keyvault/azurerm"
  version                   = "3.3.7"
  for_each                  = (var.enable_customer_managed_keys == true || lower(var.vault_type) == "akv" && var.key_vault_id == null) ? toset(["enabled"]) : []
  project_name              = var.project_name
  name_override             = azurerm_storage_account.main.name
  environment               = var.environment
  resource_group_name       = local.resource_group_name
  subnet_name               = local.subnet_name
  vnet_name                 = local.vnet_name
  vnet_rg                   = local.vnet_rg
  disable_private_endpoint  = var.disable_private_endpoint_kv
  purge_protection_enabled  = var.purge_protection_kv
  bypass                    = "AzureServices"
  default_action            = "Deny"
  ip_rules                  = concat(["196.54.42.232/30", "196.54.42.236/30"], var.ip_rules)
  enable_rbac_authorization = false
  custom_policy = [
    { policy_name             = "storage",
      object_id               = azurerm_storage_account.main.identity.0.principal_id,
      certificate_permissions = [],
      key_permissions         = ["Get", "Create", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"],
      secret_permissions      = ["Get"],
      storage_permissions     = ["Get", "List", "Delete", "Set", "Update", "RegenerateKey", "GetSAS", "ListSAS", "DeleteSAS", "SetSAS", "Recover", "Backup", "Restore", "Purge"]
    }
  ]
  depends_on = [azurerm_storage_account.main]
}

resource "azurerm_role_assignment" "keyvault" {
  for_each             = var.enable_customer_managed_keys == false ? [] : toset(["rbac"])
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = var.vault_principal_id
  depends_on           = [module.keyvault["enabled"]]
}

resource "azurerm_key_vault_key" "main" {
  for_each     = var.enable_customer_managed_keys == false ? [] : toset(["key"])
  name         = "tfex-key"
  key_vault_id = module.keyvault["enabled"].vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [module.keyvault["enabled"]]
}

resource "null_resource" "enable-keyvault-manage-access-keys" {
  for_each = var.enable_customer_managed_keys == false ? [] : toset(["enabled"])
  provisioner "local-exec" {
    command = "${path.module}/scripts/az_key.sh"
    environment = {
      vault_name   = module.keyvault["enabled"].vault_name
      storage_name = azurerm_storage_account.main.name
      storage_id   = azurerm_storage_account.main.id
    }
  }
  depends_on = [module.keyvault["enabled"], azurerm_role_assignment.keyvault["enabled"]]
}

resource "azurerm_storage_account_customer_managed_key" "main" {
  for_each           = var.enable_customer_managed_keys == false ? [] : toset(["cmk"])
  storage_account_id = azurerm_storage_account.main.id
  key_vault_id       = module.keyvault["enabled"].vault_id
  key_name           = azurerm_key_vault_key.main["key"].name
  depends_on         = [module.keyvault["enabled"]]
}

resource "azurerm_storage_encryption_scope" "main" {
  for_each           = var.enable_encryption == false ? [] : toset(["pmk"])
  name               = "microsoftmanaged"
  storage_account_id = azurerm_storage_account.main.id
  source             = "Microsoft.Storage"
}
