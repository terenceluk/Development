provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

resource "random_string" "distinct_name" {
  length  = 4
  special = false
  numeric = false
  lower   = true
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "ctc-nonprod-tfmodules-cc-${random_string.distinct_name.result}-la"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_log_analytics_solution" "main" {
  solution_name         = "VMInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  workspace_name        = azurerm_log_analytics_workspace.main.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/VMInsights"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "ctc-nonprod-tfmodules-cc-vnet-${random_string.distinct_name.result}"
  address_space       = ["10.240.0.0/22"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "main" {
  name                 = "ctc-nonprod-tfmodules-cc-subnet-${random_string.distinct_name.result}"
  resource_group_name  = azurerm_virtual_network.main.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.240.1.0/27"]
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = "ctc-nonprod-tfmodules-cc-rsv-${random_string.distinct_name.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  soft_delete_enabled = false
}

resource "azurerm_backup_policy_vm" "default-ctc-policy" {
  name                = "CTC-Default-VMBackup-Policy"
  resource_group_name = azurerm_recovery_services_vault.vault.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  timezone = "Eastern Standard Time"

  instant_restore_retention_days = 3

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 14
  }
}

module "linux-vm01" {
  source = "../../"

  ## General configuration
  project_name        = var.project_name
  environment         = var.environment
  resource_group_name = var.resource_group_name
  location            = var.location
  short_description   = random_string.distinct_name.result
  vnet_name           = azurerm_subnet.main.virtual_network_name
  subnet_name         = azurerm_subnet.main.name
  vnet_rg             = azurerm_subnet.main.resource_group_name
  vault_type          = "none"
  vm_name_suffix      = 1
  domain_name         = "labcorp.ad.ctc"
  availability_zone   = 1
  os_disk_caching     = "ReadWrite"

  boot_diag = {
    default_action     = "Deny"
    enable_privatelink = false
    ip_rules           = []
    vault_type         = "none"
  }

  ## OS and DataDisks information
  additional_data_disks = [
    {
      disk_size            = 32
      caching              = "ReadOnly"
      create_option        = "Empty"
      storage_account_type = "Premium_LRS"
    }
  ]

  ## Image configuration
  shared_image_id = "/subscriptions/42c0910c-ba8d-4218-96f2-e8bbcfdb8dc0/resourceGroups/ctc-nonprod-images-cc-rg/providers/Microsoft.Compute/galleries/ctcimagesgallery/images/core-rhel8"

  plan = {
    name      = "cis-rhel8-l1"
    publisher = "center-for-internet-security-inc"
    product   = "cis-rhel-8-l1"
  }

  ## Install Log Analytics Agent
  deploy_log_analytics_agent = {
    workspace_id  = azurerm_log_analytics_workspace.main.workspace_id
    workspace_key = azurerm_log_analytics_workspace.main.primary_shared_key
  }

  recovery_services_vault = {
    name                = azurerm_recovery_services_vault.vault.name
    resource_group_name = azurerm_recovery_services_vault.vault.resource_group_name
    backup_policy_name  = "CTC-Default-VMBackup-Policy"
  }
}
