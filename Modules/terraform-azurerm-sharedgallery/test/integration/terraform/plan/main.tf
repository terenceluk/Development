provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

module "galary" {
  source                = "../../../../"
  for_each              = var.galary
  environment           = lookup(each.value, "environment", "nonprod")
  location              = lookup(each.value, "location", {})
  resource_group_name   = lookup(each.value, "resource_group_name", {})
  gallery_name          = lookup(each.value, "gallery_name", {})
  images                = lookup(each.value, "images", {})
}

