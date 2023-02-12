keyvault = {
  // Example keyvault creation
  keyvault2 = {
    project_name             = "proj"
    instance_number          = "2"
    environment              = "nonprod"
    resource_group_name      = "ctc-nonprod-tfmodules-cc-rg"
    subnet_name              = "ctc-nonprod-corenetwork-cc-vnet-02-app02-snet"
    vnet_name                = "ctc-nonprod-corenetwork-cc-vnet-02"
    vnet_rg                  = "ctc-nonprod-corenetwork-cc-rg"
    soft_delete_enabled      = false
    purge_protection_enabled = false

    network_acls = {
      bypass         = "AzureServices"
      default_action = "Deny"
    }
    ip_rules                 = ["196.54.42.232/30", "196.54.42.236/30"]
    disable_private_endpoint = false

    // Adding a custom access policy to keyvault
    custom_policy = [
      {
        policy_name             = "custom01",
        object_id               = data.azurerm_client_config.current.object_id,
        certificate_permissions = ["backup", "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers", "managecontacts", "manageissuers", "purge", "recover", "restore", "setissuers", "update"],
        key_permissions         = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"],
        secret_permissions      = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"],
        storage_permissions     = ["backup", "delete"]
      }
    ]

    // Import a certificate from Hashicorp Vault into Azure Keyvault
    import_certificates = [
      {
        certficate_name = "cert01"
        contents        = data.vault_generic_secret.certificate.data["cert01"],
        password        = data.vault_generic_secret.certificate.data["certpass01"],
        content_type    = "application/x-pkcs12"
        exportable      = true
        key_size        = 2048
        key_type        = "RSA"
        reuse_key       = false
      },

      // Import same certificate using base64 encoded value of pfx file
      {
        certficate_name = "cert02"
        contents        = "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"
        password        = "",
        content_type    = "application/x-pkcs12"
        exportable      = true
        key_size        = 2048
        key_type        = "RSA"
        reuse_key       = false
      }
    ]


    // Generate a new certificate thru Azure keyvault
    generate_certificates = [
      {
        certficate_name    = "cert03"
        issuer_parameters  = "Self"
        days_before_expiry = "30"
        key_usage          = ["cRLSign", "dataEncipherment", "digitalSignature", "keyAgreement", "keyCertSign", "keyEncipherment"]
        subject            = "CN=hello-world"
        validity_in_months = 12
        content_type       = "application/x-pkcs12"
        exportable         = true
        key_size           = 2048
        key_type           = "RSA"
        reuse_key          = false
        action_type        = "AutoRenew"
      }
    ]
  }
}
