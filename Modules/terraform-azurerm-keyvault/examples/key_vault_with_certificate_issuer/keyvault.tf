locals {
  keyvault = {
    // Example keyvault creation with attached certifiacte issuer
    keyvault1 = {
      project_name             = "kvtest"
      instance_number          = "1"
      environment              = "nonprod"
      resource_group_name      = "ctc-nonprod-tfmodules-cc-rg"
      subnet_name              = "ctc-nonprod-corenetwork-cc-vnet-02-app02-snet"
      vnet_name                = "ctc-nonprod-corenetwork-cc-vnet-02"
      purge_protection_enabled = false
      network_acls = {
        bypass         = "AzureServices"
        default_action = "Deny"
      }
      ip_rules = [
        "196.54.42.232/30",
      "196.54.42.236/30"]
      disable_private_endpoint = false
      certificate_issuer = [
        {
          certificate_issuer = "example-issuer"
          org_id             = "ExampleOrgName"
          provider_name      = "DigiCert"
          account_id         = "0000"
          password           = "example-password"
        }
      ]
      disable_private_endpoint = true
      custom_policy = [
        {
          policy_name = "custom01",
          object_id   = data.azurerm_client_config.current.object_id,
          certificate_permissions = [
            "backup",
            "create",
            "delete",
            "deleteissuers",
            "get",
            "getissuers",
            "import",
            "list",
            "listissuers",
            "managecontacts",
            "manageissuers",
            "purge",
            "recover",
            "restore",
            "setissuers",
          "update"],
          key_permissions     = [],
          secret_permissions  = [],
          storage_permissions = []
        }
      ]
    }
  }
}
