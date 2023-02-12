provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  version         = "2.28.0"

  features {}
}

data "azurerm_client_config" "current" {}

module "keyvault" {
  source                    = "terraform.corp.ad.ctc/azure/keyvault/azurerm"
  version                   = "2.4.0"
  for_each                  = var.keyvault
  environment               = each.value.environment
  name_override             = lookup(each.value, "name_override", null)
  project_name              = each.value.project_name
  resource_group_name       = each.value.resource_group_name
  subnet_name               = lookup(each.value, "subnet_name", null)
  vnet_name                 = lookup(each.value, "vnet_name", null)
  vnet_rg                   = lookup(each.value, "vnet_rg", null)
  ip_rules                  = each.value.ip_rules
  disable_private_endpoint  = lookup(each.value, "disable_private_endpoint", true)
  custom_policy             = lookup(each.value, "custom_policy", [])
  import_certificates       = lookup(each.value, "import_certificates", [])
  generate_certificates     = lookup(each.value, "generate_certificates", [])
  purge_protection_enabled  = lookup(each.value, "purge_protection_enabled", true)
  enable_rbac_authorization = true



}

