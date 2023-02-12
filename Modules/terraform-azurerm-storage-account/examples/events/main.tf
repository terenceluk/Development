provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  features {}
}

module "storage-account" {
  source       = "terraform.corp.ad.ctc/azure/storage-account/azurerm"
  version      = "5.0.0"
  environment  = "nonprod"
  project_name = "coa"
  containers   = [{ name = "test1", container_access_type = "private" }]
  events = [
    {
      name                 = "send-to-storage-queue"
      storage_account_id   = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Storage/storageAccounts/mystorageaccount"
      queue_name           = "myqueue"
      included_event_types = ["Microsoft.Storage.BlobCreated", "Microsoft.Storage.BlobDeleted"]
      filters = {
        subject_begins_with = "test1"
      }
    }
  ]
}