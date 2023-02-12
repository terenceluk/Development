provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  features {}
}

module "storage-account" {
  source       = "terraform.corp.ad.ctc/azure/storage-account/azurerm"
  version      = "5.4.3"
  environment  = "nonprod"
  project_name = "coa"
  containers   = [{ name = "test1", container_access_type = "private" }]
  lifecycles = [
    {
      name         = "rule1"
      enabled      = true
      prefix_match = ["test1/path1"]
      blob_types   = ["blockBlob"]
      base_blob = {
        tier_to_cool_after_days    = 7
        tier_to_archive_after_days = 14
        delete_after_days          = 21
      }
    },
    {
      name         = "rule2"
      enabled      = true
      prefix_match = ["test1/path2", "test1/path3"]
      blob_types   = ["appendBlob", "blockBlob"]
      base_blob = {
        delete_after_days = 7
      }
    },
    {
      name         = "rule3"
      enabled      = false
      prefix_match = ["test1/path4"]
      blob_types   = ["appendBlob"]
    }
  ]
}