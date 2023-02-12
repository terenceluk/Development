# Variable values for bastion hosts stored in a map
bastion_hosts = {
  bastion01 = {
    resource_group_name  = "rg-solution"
    virtual_network_rg   = "rg-solution"
    virtual_network_name = "corp-dev-corenetwork-cc-vnet-07"
    subnet_name          = "corp-dev-corenetwork-cc-vnet-07-app-01-snet"
    availability_zone    = 1

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
    } # Need to add Log Analytics Agent referencing workspace_id and workspace_key
  }/*,
  bastion02 = {
    resource_group_name  = "rg-solution"
    virtual_network_rg   = "rg-solution"
    virtual_network_name = "corp-dev-corenetwork-cc-vnet-07"
    subnet_name          = "corp-dev-corenetwork-cc-vnet-07-app-01-snet"
    availability_zone    = 2

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
    } # Need to add Log Analytics Agent referencing workspace_id and workspace_key
  }*/
}