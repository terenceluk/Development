/*
The source argument in a module block tells Terraform where to find the source code for the desired child module.
Terraform uses this during the module installation step of terraform init to download the source code to a directory on local disk so that it can be used by other Terraform commands.
*/

# Module for deploying Azure Compute Gallery
module "setup_bastion_hosts" {
  source = "../Modules/terraform-azurerm-compute-linux" # Repository
  for_each = var.bastion_hosts
  ## General configuration
  vm_name_override    = each.value["name"] 
  project_name        = var.project_name
  environment         = var.environment
  short_description   = var.description
  resource_group_name = each.value["resource_group_name"]
  vnet_name           = each.value["virtual_network_name"]
  subnet_name         = each.value["subnet_name"]
  vnet_rg             = each.value["virtual_network_rg"]
  vm_name_suffix      = 1
  availability_zone   = each.value["availability_zone"]
  domain_name         = "corp.ad.ctc"

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
    publisher = "OpenLogic"
    offer     = "CentOs"
    sku       = "7.7"
    version   = "latest"
  }

 /*marketplace_image = {
    publisher = "center-for-internet-security-inc"
    offer     = "cis-rhel-8-l1"
    sku       = "cis-rhel8-l1"
    version   = "latest"
  }
  plan = {
    name      = "CentOS Server"
    publisher = "cloud-infrastructure-services"
    product   = "centos-8-3"
  }*/
/*
  ## Install Log Analytics Agent
  deploy_log_analytics_agent = {
    workspace_id  = azurerm_log_analytics_workspace.main.workspace_id
    workspace_key = azurerm_log_analytics_workspace.main.primary_shared_key
  }*/
}