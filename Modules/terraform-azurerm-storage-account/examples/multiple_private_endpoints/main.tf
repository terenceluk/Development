provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  features {}
}

module "storage-account" {
  source                                   = "terraform.corp.ad.ctc/azure/storage-account/azurerm"
  version                                  = "5.3.4"
  environment                              = "nonprod"
  project_name                             = "myproject"
  force_create_private_endpoint_gen2fs     = true
  force_create_private_endpoint_containers = true
  force_create_private_endpoint_shares     = true
}