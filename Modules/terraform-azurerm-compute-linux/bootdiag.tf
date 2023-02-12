/*
module "storage-account" {
  count                        = var.existing_boot_diagnostics_storage_account_uri == null ? 1 : 0
  source                       = "terraform.corp.ad.ctc/azure/storage-account/azurerm"
  version                      = "7.0.1"
  environment                  = var.environment
  project_name                 = var.project_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  name_override                = lower(replace(local.primary_name, "/[[:^alnum:]]/", ""))
  containers                   = [{ name = "diag", container_access_type = "private" }]
  enable_privatelink           = var.boot_diag.enable_privatelink
  ip_rules                     = concat(["196.54.42.232/30", "196.54.42.236/30"], var.boot_diag.ip_rules)
  bypass                       = ["AzureServices"]
  default_action               = var.boot_diag.default_action
  subnet_name                  = local.subnet_name
  vnet_name                    = local.vnet_name
  vnet_rg                      = local.vnet_rg
  enable_customer_managed_keys = false
  vault_type                   = var.boot_diag.vault_type
  large_file_share_enabled     = false
  is_BootDiag                  = true
  tags = {
    StorageType = "BootDiag"
  }
}

data "azurerm_storage_account" "main" {
  count               = var.existing_boot_diagnostics_storage_account_uri == null ? 1 : 0
  name                = module.storage-account[0].storage_account_name
  resource_group_name = var.resource_group_name
  depends_on          = [module.storage-account[0]]
}
*/