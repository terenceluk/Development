provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

resource "random_string" "distint_name" {
  length  = 4
  special = false
  number  = false
  lower   = true
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "ctc-nonprod-tfmodules-cc-${random_string.distint_name.result}-la"
  location            = "Canada Central"
  resource_group_name = azurerm_virtual_network.main.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_log_analytics_solution" "main" {
  solution_name         = "VMInsights"
  location              = "Canada Central"
  resource_group_name   = azurerm_virtual_network.main.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  workspace_name        = azurerm_log_analytics_workspace.main.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/VMInsights"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "ctc-nonprod-tfmodules-cc-vnet-${random_string.distint_name.result}"
  address_space       = ["10.240.0.0/22"]
  location            = "Canada Central"
  resource_group_name = "ctc-nonprod-tfmodules-cc-rg"
}

resource "azurerm_subnet" "main" {
  name                 = "ctc-nonprod-tfmodules-cc-subnet-${random_string.distint_name.result}"
  resource_group_name  = azurerm_virtual_network.main.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.240.1.0/27"]
}

module "linux-vm01" {
  source = "../../"

  ## General configuration
  project_name        = "tfmodules"
  environment         = "nonprod"
  short_description   = random_string.distint_name.result
  resource_group_name = "ctc-nonprod-tfmodules-cc-rg"
  vnet_name           = azurerm_virtual_network.main.name
  subnet_name         = azurerm_subnet.main.name
  vnet_rg             = azurerm_virtual_network.main.resource_group_name
  vm_name_suffix      = 1
  availability_zone   = 1
  domain_name         = "labcorp.ad.ctc"

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
  marketplace_image = {
    publisher = "center-for-internet-security-inc"
    offer     = "cis-rhel-8-l1"
    sku       = "cis-rhel8-l1"
    version   = "latest"
  }

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
}

module "linux-vm02" {
  source = "../../"

  ## General configuration
  project_name        = "tfmodules"
  environment         = "nonprod"
  short_description   = random_string.distint_name.result
  resource_group_name = "ctc-nonprod-tfmodules-cc-rg"
  vnet_name           = azurerm_virtual_network.main.name
  subnet_name         = azurerm_subnet.main.name
  vnet_rg             = azurerm_virtual_network.main.resource_group_name
  vm_name_suffix      = 2
  availability_zone   = 2

  domain_name = "labcorp.ad.ctc"
  public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC64x7o5zRr8NdxBQ/Eg/qMR6sfiVWGj+h6mmbGrCeBeaK+Fewa6HdDXXvsUHpHtL9tg/9oCWKrQXXRmwPA7AzkNU5FqSmb9vuLEV9KxQ3Wo4ErgKLeplpNgVLeYax30RHU5nDDpbaBobREMJ4P4gcIOGJBdQP82UNNWO8/YP3fGwLC9NGHHcX7dtF7OZVHmFTi7mwrbNXEEq24VofihMt9+H0JXay5gGnq/qX7qP5qXUvK8tOxmAOqaGhH/AhSY+fNPYVKZhpsbQGW3sDDMqWRCqUD0tqIVwkU1DjW/cqNOhHmoKOhZMqlYHGgCdo4FBqduty1awIsRc4e19CzmuIf"

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
  marketplace_image = {
    publisher = "center-for-internet-security-inc"
    offer     = "cis-rhel-8-l1"
    sku       = "cis-rhel8-l1"
    version   = "latest"
  }

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
}