provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

module "vnet" {
  source                 = "../../../../"
  for_each               = var.vnet
  override_vnet_name     = lookup(each.value, "override_vnet_name", null)
  address_space          = each.value.address_space
  location               = each.value.location
  environment            = each.value.environment
  vnet_name              = lookup(each.value, "vnet_name", {})
  resource_group_name    = each.value.resource_group_name
  enable_ddos_protection = lookup(each.value, "enable_ddos_protection", true)
}
