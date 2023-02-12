provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

data "azurerm_client_config" "current" {}

resource "random_string" "distinct_name" {
  length  = 3
  special = false
}

module "keyvault" {
  source                     = "../../../../"
  for_each                   = local.keyvault
  environment                = each.value.environment
  generation                 = lookup(each.value, "generation", "gen1")
  name_override              = lookup(each.value, "name_override", null)
  project_name               = "tfm${random_string.distinct_name.result}"
  resource_group_name        = each.value.resource_group_name
  subnet_name                = lookup(each.value, "subnet_name", null)
  vnet_name                  = lookup(each.value, "vnet_name", null)
  vnet_rg                    = lookup(each.value, "vnet_rg", null)
  ip_rules                   = each.value.ip_rules
  disable_private_endpoint   = each.value.disable_private_endpoint
  custom_policy              = lookup(each.value, "custom_policy", [])
  import_certificates        = lookup(each.value, "import_certificates", [])
  generate_certificates      = lookup(each.value, "generate_certificates", [])
  purge_protection_enabled   = lookup(each.value, "purge_protection_enabled", true)
  instance_number            = lookup(each.value, "instance_number", "01")
  certificate_issuer         = lookup(each.value, "certificate_issuer", [])
  enable_rbac_authorization  = try(each.value.enable_rbac_authorization, true)
  access_mixed_mode          = lookup(each.value, "access_mixed_mode", false)
  log_analytics_workspace_id = try(each.value.log_analytics_workspace_id, null)
  secrets                    = lookup(each.value, "secrets", [])
  keys                       = lookup(each.value, "keys", [])
}
