resource "azurerm_virtual_network" "main" {
  name                = "test-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "Canada Central"
  resource_group_name = "ctc-nonprod-tfmodules-cc-rg"
}

resource "azurerm_route_table" "main" {
  name                          = "rt_test"
  location                      = "Canada Central"
  resource_group_name           = "ctc-nonprod-tfmodules-cc-rg"
  disable_bgp_route_propagation = false
}

resource "azurerm_network_security_group" "main" {
  name                = "nsg-test"
  location            = "Canada Central"
  resource_group_name = "ctc-nonprod-tfmodules-cc-rg"
}

module "subnet" {
  source                                        = "../../../../"
  for_each                                      = var.subnet
  resource_group_name                           = lookup(each.value, "resource_group_name", {})
  subnet_name                                   = lookup(each.value, "subnet_name", {})
  delegation                                    = lookup(each.value, "delegation", {})
  service_delegation                            = lookup(each.value, "service_delegation", {})
  private_endpoint_network_policies_enabled     = lookup(each.value, "private_endpoint_network_policies_enabled", false)
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", false)
  address_prefixes                              = lookup(each.value, "address_prefixes", [])
  virtual_network_name                          = azurerm_virtual_network.main.name
  rt_name                                       = lookup(each.value, "rt_name", null)
  nsg_name                                      = lookup(each.value, "nsg_name", null)

  depends_on = [
    azurerm_network_security_group.main,
    azurerm_route_table.main,
    azurerm_virtual_network.main
  ]
}




