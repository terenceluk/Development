provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  features {}
}

module "storage-account" {
  source         = "terraform.corp.ad.ctc/azure/storage-account/azurerm"
  version        = "5.0.0"
  environment    = "nonprod"
  project_name   = "coa"
  bypass         = ["AzureServices"]
  tags           = { "test_module" = "yes" }
  is_hns_enabled = true
  gen2fs = [{
    name                  = "test",
    container_access_type = "private",
    gen2fs_paths          = ["test"]
    }
  ]
}
