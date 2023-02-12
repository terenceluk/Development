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

module "kv_akv_integration" {
  source                   = "terraform.corp.ad.ctc/azure/keyvault/azurerm"
  version                  = "3.3.6"
  name_override            = "nonprod-tfm-cc-${random_string.distinct_name.result}" //name limits to 3-24 chars
  instance_number          = 1
  environment              = var.environment
  project_name             = var.project_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  disable_private_endpoint = true
  purge_protection_enabled = false
  ip_rules                 = ["196.54.42.232/30", "196.54.42.236/30"]
}

module "linux-vm01" {
  source = "../../../../"

  ## General configuration
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  short_description   = random_string.distinct_name.result
  resource_group_name = var.resource_group_name
  vnet_name           = azurerm_virtual_network.main.name
  vnet_rg             = azurerm_virtual_network.main.resource_group_name
  subnet_name         = azurerm_subnet.main.name
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

  identity_type = "UserAssigned"
  identity_ids  = values(module.authorization-uami.user_assigned_identity_id)

  ## Install Log Analytics Agent
  deploy_log_analytics_agent = {
    workspace_id  = azurerm_log_analytics_workspace.main.workspace_id
    workspace_key = azurerm_log_analytics_workspace.main.primary_shared_key
  }

  ## AKV configuration
  vault_type   = "akv"
  key_vault_id = module.kv_akv_integration.vault_id

  ## AAD user role assignments
  vm_user_login_assignments = ["92d490c5-449d-4e77-b52c-6a41784d0e29"]
}