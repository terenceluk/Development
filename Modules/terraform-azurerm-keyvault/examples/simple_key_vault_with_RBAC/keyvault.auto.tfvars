keyvault = {
  // Example keyvault creation with enable firewall rules and enabled private link
  keyvault1 = {
    project_name             = "kvtest"
    instance_number          = "1"
    environment              = "nonprod"
    subnet_name              = "ctc-nonprod-corenetwork-cc-vnet-02-app02-snet"
    vnet_name                = "ctc-nonprod-corenetwork-cc-vnet-02"
    resource_group_name      = "ctc-nonprod-tfmodules-cc-rg"
    purge_protection_enabled = false
    network_acls = {
      bypass         = "AzureServices"
      default_action = "Deny"
    }
    ip_rules                 = ["196.54.42.232/30", "196.54.42.236/30"]
    disable_private_endpoint = false
  }
}
