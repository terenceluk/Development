subnet = {
  subnet1 = {
    resource_group_name                       = "ctc-nonprod-tfmodules-cc-rg"
    environment                               = "nonprod"
    location                                  = "Canada Central"
    subnet_name                               = "subnet01"
    resource_group_name                       = "ctc-nonprod-tfmodules-cc-rg"
    address_prefixes                          = ["10.0.0.0/24", ]
    private_endpoint_network_policies_enabled = true
    rt_name                                   = "rt_test"
    nsg_name                                  = "nsg-test"
    delegation = {
      delegation1 = {
        name = "containers"
        service_delegation = {
          service_delegation1 = {
            name    = "Microsoft.ContainerInstance/containerGroups"
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        }
      }
    }
  }
}