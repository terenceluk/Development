/*
This file contains all the values for the variables defined in variables.tf
*/

# Variable values for multiple subnets stored in a map
subnets = {
  oscp = {
    name = "oscp"
    cidr = ["10.20.160.0/28"]
  },
  osw = {
    name = "osw"
    cidr = ["10.20.161.0/26"]
  },
  app = {
    name = "app"
    cidr = ["10.20.163.0/28"]
  }
}

resource_group_name                           = "rg-solution"
virtual_network_name                          = "corp-dev-corenetwork-cc-vnet-07"
service_endpoints                             = null
service_endpoint_policy_ids                   = null
private_endpoint_network_policies_enabled     = false
private_link_service_network_policies_enabled = false
environment                                   = "dev"