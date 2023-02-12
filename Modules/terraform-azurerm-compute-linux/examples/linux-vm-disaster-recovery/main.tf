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
  name                = "corp-dev-001-3oz5-tfmodules-cc-${random_string.distinct_name.result}-la"
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

resource "azurerm_subnet" "primary" {
  name                                           = lower(format("corp-dev-corenetwork-cc-vnet-01-tfmodules-%s-snet", random_string.distinct_name.result))
  resource_group_name                            = "corp-dev-001-corenetwork-cc-rg"
  virtual_network_name                           = "corp-dev-corenetwork-cc-vnet-01"
  address_prefixes                               = ["10.20.89.0/27"]
  enforce_private_link_endpoint_network_policies = "true"
}

resource "azurerm_subnet" "secondary" {
  name                                           = lower(format("corp-dev-corenetwork-ce-vnet-01-tfmodules-%s-snet", random_string.distinct_name.result))
  resource_group_name                            = "corp-dev-001-corenetwork-ce-rg"
  virtual_network_name                           = "corp-dev-corenetwork-ce-vnet-01"
  address_prefixes                               = ["10.21.90.0/27"]
  enforce_private_link_endpoint_network_policies = "true"
}

module "site_recovery" {
  source  = "terraform.corp.ad.ctc/azure/site-recovery-vault/azurerm"
  version = "0.8.0"

  project_name       = var.project_name
  environment        = var.environment
  enable_replication = true

  ## Main and failover region resource groups
  primary_rg   = var.resource_group_name
  secondary_rg = "corp-dev-001-3oz5-ce-rg"

  primary_subnet_name = azurerm_subnet.primary.name
  primary_vnet_name   = azurerm_subnet.primary.virtual_network_name
  primary_vnet_rg     = azurerm_subnet.primary.resource_group_name

  ## source and destination Virtual Network ids for replication
  source_network_id = "/subscriptions/6808f1d9-4cd5-47a1-a3b3-06c054696aea/resourceGroups/corp-dev-001-corenetwork-cc-rg/providers/Microsoft.Network/virtualNetworks/corp-dev-corenetwork-cc-vnet-01"
  target_network_id = "/subscriptions/6808f1d9-4cd5-47a1-a3b3-06c054696aea/resourceGroups/corp-dev-001-corenetwork-ce-rg/providers/Microsoft.Network/virtualNetworks/corp-dev-corenetwork-ce-vnet-01"
}

module "linux-vm01" {
  source = "../../"

  ## General configuration
  project_name        = var.project_name
  environment         = var.environment
  resource_group_name = var.resource_group_name
  location            = var.location
  short_description   = random_string.distinct_name.result
  vnet_name           = azurerm_subnet.primary.virtual_network_name
  subnet_name         = azurerm_subnet.primary.name
  vnet_rg             = azurerm_subnet.primary.resource_group_name
  vault_type          = "none"
  vm_name_suffix      = 1
  domain_name         = "labcorp.ad.ctc"
  availability_zone   = 1
  enable_replication  = true
  os_disk_caching     = "ReadWrite"
  target_subnet_name  = azurerm_subnet.secondary.name

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

  vm_replication = {
    replication1 = {
      name                                      = "vm-replication"
      recovery_vault_resource_group_name        = "corp-dev-001-3oz5-ce-rg"
      recovery_vault_name                       = module.site_recovery.recovery_services_vault_name
      source_recovery_fabric_name               = module.site_recovery.source_recovery_fabric_name
      recovery_replication_policy_id            = module.site_recovery.site_recovery_replication_policy
      source_recovery_protection_container_name = module.site_recovery.source_recovery_protection_container_name
      target_resource_group_id                  = "/subscriptions/6808f1d9-4cd5-47a1-a3b3-06c054696aea/resourceGroups/corp-dev-001-3oz5-ce-rg"
      target_recovery_fabric_id                 = module.site_recovery.target_recovery_fabric_id
      target_recovery_protection_container_id   = module.site_recovery.target_recovery_protection_container_id
    }
  }

  managed_disk = {
    os_disk1 = {
      disk_id                    = "/subscriptions/6808f1d9-4cd5-47a1-a3b3-06c054696aea/resourceGroups/corp-dev-001-3oz5-cc-rg/providers/Microsoft.Compute/disks/${module.linux-vm01.vm_name}-osdisk-01"
      staging_storage_account_id = module.site_recovery.storage_account_id
      target_resource_group_id   = "/subscriptions/6808f1d9-4cd5-47a1-a3b3-06c054696aea/resourceGroups/corp-dev-001-3oz5-ce-rg"
      target_disk_type           = "Premium_LRS"
      target_replica_disk_type   = "Premium_LRS"
    }
  }
  depends_on = [module.site_recovery]
}