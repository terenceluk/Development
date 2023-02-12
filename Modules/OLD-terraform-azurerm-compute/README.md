# Terraform Azure Compute Module

This module allows you to deploy compute VMs to azure using terraform.

Current versin only supports linux

Default Linux image is core-rhel7:latest 

## Usage:

```
/*Create an Availability Set and a linux VM named t9icazcoa01*/
module "vm" {
  source              = "./../../../"
  project_name        = "coa"
  environment         = "sandbox"
  location_code       = "cc"
  infoblox_creds      = "username:password"
  resource_group_name = "ctc-sandbox-coa-cc-rg"
  linux = {
    vm1 = {
      hostname                      = "t9icazcoa01"
      vnet_subnet_id                = data.azurerm_subnet.sn.id
      data_disk_size_gb             = "20"
      admin_username                = "ctcadm"
      boot_diagnostics              = "true"
    }
  }
}

```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| resource_group_name | Resource Group Name | string |  | yes |
| project_name | Project name | string | | yes |
| environment | Environment (Sandbox,NonProd,Prod) | string | | yes |
| location_code | Your RG Location Code (cc,ce) | string | | yes |
| platform_fault_domain_count | Specifies the number of fault domains that are used. | number | 2 | no |
| platform_update_domain_count | Specifies the number of update domains that are used. | number | 2 | no |
| avset_tags | Specific Tags for avset | map | {} | no |
| linux | Map that creates Linux VMs | any | `<map>` | no |
| windows | Map that creates Linux VMs | any | `<map>` | no |
| infoblox_creds | Infoblox login:password required for privatelink | string | | yes |

## Outputs

| Name | Description |
|------|-------------|
| availability\_set\_id | id of the availability set where the vms are provisioned. |
| network\_interface\_ids | ids of the vm nics provisoned. |
| network\_interface\_private\_ip | private ip addresses of the vm nics |
| random\_password | When random password given print it |
| vm\_ids | Virtual machine ids created. |

## Map Options

| Name | Description |
|------|-------------|
| resource_group_name | The name of the resource group in which the resources will be created|
| hostname | The hostname of the VM your trying to create|
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created.|
| disable_availability_set | Set this to true if your VM does not need to be part of the default AVSET |
| vnet_subnet_id | The subnet id of the virtual network where the virtual machines will reside.|
| admin_password | The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure. Leave blank to have one randomly generated |
| remote_port | Remote tcp port to be used for access to the vms created via the nsg applied to the nics.|
| admin_username | The admin username of the VM that will be deployed|
| custom_data | The custom data to supply to the machine. This can be used as a cloud-init for Linux systems.|
| vm_size | Specifies the size of the virtual machine.|
| tags | A map of the tags to use on the resources that are deployed with this module.|
| allocation_method | Defines how an IP address is assigned. Options are Static or Dynamic.|
| delete_os_disk_on_termination | Delete datadisk when machine is terminated|
| data_sa_type | Data Disk Storage Account type|
| data_disk_size_gb | Storage data disk size size|
| data_disk | Set to true to add a datadisk.|
| enable_accelerated_networking | (Optional) Enable accelerated networking on Network interface|
| network_security_group_id | The Network Security Group ID that will be attached to this vNIC|
| azure_image_sku | Specifies the name of the image from the marketplace.|
| azure_image_publisher | Specifies the publisher of the image|
| azure_image_offer | Specifies the product of the image from the marketplace.|
| recovery_services_vault | Specify the name of the Recovery Vault |
| recovery_service_vault_rg | (Optional) specify if vault is outside default resource group
| backup_policy_name | Name of VM backup to apply

## Requirements

- Terraform >= v0.12.20
- AzureRM >= v2.3.0
