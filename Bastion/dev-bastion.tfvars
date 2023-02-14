/*
This file contains all the values for the variables defined in variables.tf
*/

project_name = "cp4d"
environment          = "dev"
resource_group_name  = "rg-solution"
resource_group_location = "Canada Central"
description = "This is a jumpbox for CP4D"

# Variable values for bastion hosts stored in a map
bastion_hosts = {
  bastion01 = {
    name                 = "corp-dev-007-ocpbastion-cc-vm-01"
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

# https://gmusumeci.medium.com/how-to-find-azure-linux-vm-images-for-terraform-or-packer-deployments-24e8e0ac68a
    ## Image configuration
    marketplace_image = {
      publisher = "OpenLogic"
      offer     = "CentOs"
      sku       = "7.7"
       version   = "latest"
    }

    plan = {
      name      = "CentOS Server"
      publisher = "cloud-infrastructure-services"
      product   = "centos-8-3"
    } # Need to add Log Analytics Agent referencing workspace_id and workspace_key
  },
  bastion02 = {
    name                 = "corp-dev-007-ocpbastion-cc-vm-02"
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
      publisher = "RedHat"
      offer     = "rhel"
      sku       = "8.2"
      version   = "latest"
    }

    plan = {
      name      = "cis-rhel8-l1"
      publisher = "center-for-internet-security-inc"
      product   = "cis-rhel-8-l1"
    } # Need to add Log Analytics Agent referencing workspace_id and workspace_key
  }
}

