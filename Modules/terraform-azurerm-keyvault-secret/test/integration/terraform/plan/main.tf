provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

module "secret" {
  source         = "../../../../"
  environment    = "non-prod"
  projectcode    = "12345"
  costcenter     = "00000"
  key_vault_name = "ctcnonprodtf01-kv"
  key_vault_rg   = "ctc-nonprod-tfmodules-cc-rg"
  secrets = [
    {
      secret_name     = "test-secret1",
      secret_value    = "$eCrEt",
      content_type    = "secret value"
      expiration_date = "2022-12-12T00:00:01Z"
    },
    {
      secret_name  = "test-secret2",
      secret_value = "$eCrEt2",
      content_type = "secret value"
    }
  ]
}