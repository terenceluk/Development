/*
The source argument in a module block tells Terraform where to find the source code for the desired child module.
Terraform uses this during the module installation step of terraform init to download the source code to a directory on local disk so that it can be used by other Terraform commands.
*/

# Create OpenShift Master Control Plane Nodes, Worker Nodes, and App & VM subnet with for_each
module "setup_virtual_network_subnets" {
  for_each                                      = var.subnets
  source                                        = "../Modules/terraform-azurerm-virtual-network-subnet" # Repository
  subnet_name                                   = "corp-dev-corenetwork-cc-vnet-07-${each.value["name"]}-01-snet"
  override_subnet_name                          = "corp-dev-corenetwork-cc-vnet-07-${each.value["name"]}-01-snet"
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = each.value["cidr"]
  service_endpoints                             = var.service_endpoints
  service_endpoint_policy_ids                   = var.service_endpoint_policy_ids
  private_endpoint_network_policies_enabled     = var.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
}

## Need to pre-create NSG in order to use this module to attach it - depends_on