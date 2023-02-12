vnet = {
  cc_vnet1 = {
    environment         = "nonprod"
    project_name        = "tfmodules"
    location            = "Canada Central"
    vnet_name           = "tfmodules"
    address_space       = ["10.0.192.0/20"]
    resource_group_name = "ctc-nonprod-tfmodules-cc-rg"
    dns_servers         = ["10.255.255.253", "10.255.255.254"]
    //  enable_ddos_protection = false
  }
}