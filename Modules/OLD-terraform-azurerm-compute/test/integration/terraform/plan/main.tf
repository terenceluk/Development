provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  version         = "2.3.0"
  features {}
}

data "azurerm_resource_group" "vnet" {
  name = "ctc-sandbox-corenetwork-cc-rg"
}

data "azurerm_subnet" "sn" {
  name                 = "ctc-sandbox-corenetwork-cc-vnet-app01-snet"
  virtual_network_name = "ctc-sandbox-corenetwork-cc-vnet"
  resource_group_name  = data.azurerm_resource_group.vnet.name
}

resource "azurerm_recovery_services_vault" "example" {
  name                = "coa-recovery-vault"
  location            = "Canada Central"
  resource_group_name = "ctc-sandbox-coa-cc-rg"
  sku                 = "Standard"
}

resource "azurerm_backup_policy_vm" "example" {
  name                = "recovery-vault-policy"
  resource_group_name = "ctc-sandbox-coa-cc-rg"
  recovery_vault_name = azurerm_recovery_services_vault.example.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 10
  }

  retention_weekly {
    count    = 42
    weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
  }

  retention_monthly {
    count    = 7
    weekdays = ["Sunday", "Wednesday"]
    weeks    = ["First", "Last"]
  }

  retention_yearly {
    count    = 77
    weekdays = ["Sunday"]
    weeks    = ["Last"]
    months   = ["January"]
  }
}

module "vm" {
  source              = "../../../../"
  infoblox_creds      = "${var.svc_vco_ipam_username}:${var.svc_vco_ipam_password}"
  project_name        = "coa"
  environment         = "sandbox"
  location_code       = "cc"
  resource_group_name = "ctc-sandbox-coa-cc-rg"
  linux = {
    vm1 = {
      hostname                = "t9icazcoa01"
      vnet_subnet_id          = data.azurerm_subnet.sn.id
      data_disk_size_gb       = "20"
      admin_username          = "ctcadm"
      recovery_services_vault = azurerm_recovery_services_vault.example.name
      backup_policy           = azurerm_backup_policy_vm.example.name
      boot_diagnostics        = "true"
    }
  }
}
