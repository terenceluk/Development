provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  features {}
}

provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}

module "storage-account" {
  source       = "terraform.corp.ad.ctc/azure/storage-account/azurerm"
  version      = "5.0.0"
  environment  = "nonprod"
  project_name = "coa"
  vault_type   = "hashicorp"
  containers   = [{ name = "test1", container_access_type = "private" }]
  shares       = [{ name = "share1", folders = ["folder1"] }, ]
  tables = [{
    name          = "test1"
    partition_key = "test1_partition"
    row_key       = "test1_row"
    entity = {
      test_entity = "test_entity"
    }
    }
  ]
}
