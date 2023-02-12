# AzureRM Compute Linux terraform module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 2.99.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | <= 2.99.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage-account"></a> [storage-account](#module\_storage-account) | terraform.corp.ad.ctc/azure/storage-account/azurerm | 5.4.7 |
| <a name="module_vault_mount_secrets_linux"></a> [vault\_mount\_secrets\_linux](#module\_vault\_mount\_secrets\_linux) | terraform.corp.ad.ctc/azure/mount-secrets/vault | 1.1.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_backup_protected_vm.vm-linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |
| [azurerm_key_vault_secret.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_role_assignment.vm_admin_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.vm_user_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_site_recovery_replicated_vm.vm-replication](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replicated_vm) | resource |
| [azurerm_virtual_machine_data_disk_attachment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.aadsshloginforlinux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.custom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.dependencyagentlinux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.monitorlinuxagent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [null_resource.disable_replication](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.main](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.passwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_backup_policy_vm.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/backup_policy_vm) | data source |
| [azurerm_recovery_services_vault.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/recovery_services_vault) | data source |
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_data_disks"></a> [additional\_data\_disks](#input\_additional\_data\_disks) | Adding additional disks capacity to add each instance (GB) | <pre>list(object({<br>    disk_size            = string,<br>    caching              = string,<br>    create_option        = string,<br>    storage_account_type = string,<br>  }))</pre> | `[]` | no |
| <a name="input_admin_ssh_key_data"></a> [admin\_ssh\_key\_data](#input\_admin\_ssh\_key\_data) | specify the path to the existing ssh key to authenciate linux vm if generate ssh key is set to false | `string` | `""` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in | `string` | `null` | no |
| <a name="input_avset_platform_fault_domain_count"></a> [avset\_platform\_fault\_domain\_count](#input\_avset\_platform\_fault\_domain\_count) | Specifies the number of update domains that are used. Defaults to 3. Changing this forces a new resource to be created. | `string` | `3` | no |
| <a name="input_avset_platform_update_domain_count"></a> [avset\_platform\_update\_domain\_count](#input\_avset\_platform\_update\_domain\_count) | Specifies the number of fault domains that are used. Defaults to 5. Changing this forces a new resource to be created. | `string` | `5` | no |
| <a name="input_backup_policy"></a> [backup\_policy](#input\_backup\_policy) | The name of the pre-existing backup policy being applied to these VMs | <pre>object({<br>    backup_policy_name = string<br><br>  })</pre> | `null` | no |
| <a name="input_boot_diag"></a> [boot\_diag](#input\_boot\_diag) | Boot Diagnostic Storage Account Configurable options | <pre>object({<br>    enable_privatelink = bool,<br>    default_action     = string,<br>    ip_rules           = list(string)<br>    vault_type         = string,<br>  })</pre> | <pre>{<br>  "default_action": "Deny",<br>  "enable_privatelink": false,<br>  "ip_rules": [],<br>  "vault_type": "hashicorp"<br>}</pre> | no |
| <a name="input_brand"></a> [brand](#input\_brand) | Company Brand | `string` | `"ctc"` | no |
| <a name="input_custom_extension"></a> [custom\_extension](#input\_custom\_extension) | A custom extension block | <pre>object({<br>    publisher            = string<br>    type                 = string<br>    type_handler_version = string<br>    settings             = map(any)<br>    protected_settings   = map(any)<br>  })</pre> | `null` | no |
| <a name="input_deploy_log_analytics_agent"></a> [deploy\_log\_analytics\_agent](#input\_deploy\_log\_analytics\_agent) | Provide the workspace ID and the workspace Key to install the log analytics agent. | <pre>object({<br>    workspace_id  = string<br>    workspace_key = string<br>  })</pre> | `null` | no |
| <a name="input_diff_disk_settings"></a> [diff\_disk\_settings](#input\_diff\_disk\_settings) | Enables the diff disk setting. Currently only Local is supported | `bool` | `false` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The Infoblox DNS domain name where the VM should be registered. Example `corp.azure.ctc`. | `string` | n/a | yes |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | (Optional) Should Accelerated Networking be enabled? | `string` | `"false"` | no |
| <a name="input_enable_replication"></a> [enable\_replication](#input\_enable\_replication) | To enable replication for windows VM | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Which enviroment sandbox nonprod prod | `string` | `"sandbox"` | no |
| <a name="input_existing_avset_id"></a> [existing\_avset\_id](#input\_existing\_avset\_id) | Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created. If one is not specified it will be created | `string` | `null` | no |
| <a name="input_existing_boot_diagnostics_storage_account_uri"></a> [existing\_boot\_diagnostics\_storage\_account\_uri](#input\_existing\_boot\_diagnostics\_storage\_account\_uri) | Storage account URI for boot diagnostics | `string` | `null` | no |
| <a name="input_generate_admin_ssh_key"></a> [generate\_admin\_ssh\_key](#input\_generate\_admin\_ssh\_key) | Generates a secure private key and encodes it as PEM. | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | The ID of a user assigned identity. | `any` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of identity used for the managed cluster. Possible values are `SystemAssigned`, `UserAssigned`. | `string` | `"SystemAssigned"` | no |
| <a name="input_is_dev"></a> [is\_dev](#input\_is\_dev) | Is this VM for a dev environment | `string` | `false` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of the custom Key Vault where the Secret should be created. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"Canada Central"` | no |
| <a name="input_managed_disk"></a> [managed\_disk](#input\_managed\_disk) | A managed disk block for the replication VM | `map(any)` | `{}` | no |
| <a name="input_marketplace_image"></a> [marketplace\_image](#input\_marketplace\_image) | Provide the marketplace image info | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | `null` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite | `string` | `"ReadOnly"` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `string` | `null` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | The type of storage to use for the OS managed disk. Possible values are Standard\_LRS, Premium\_LRS, StandardSSD\_LRS | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_os_flavor"></a> [os\_flavor](#input\_os\_flavor) | Specify the flavour of the operating system image to deploy VM. Valid values are `Ubuntu` and `linux` | `string` | `"linux"` | no |
| <a name="input_override_resource_group_name"></a> [override\_resource\_group\_name](#input\_override\_resource\_group\_name) | This will override the auto naming convention for the resource group. | `string` | `null` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | Provide the marketplace image plan info | <pre>object({<br>    name      = string<br>    publisher = string<br>    product   = string<br>  })</pre> | `null` | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | The Static IP Address which should be used. If not set will use DHCP | `string` | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | (Required)The project name | `string` | `null` | no |
| <a name="input_recovery_services_vault"></a> [recovery\_services\_vault](#input\_recovery\_services\_vault) | The name of the pre-existing Recovery Service Vault and the resource group name that contains the backup policy being applied to these VMs | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>    backup_policy_name  = string<br>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name where the VM will be deployed. | `string` | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Generate secrets for VM | `any` | `{}` | no |
| <a name="input_shared_image"></a> [shared\_image](#input\_shared\_image) | Provide the Shared Image Gallery image info | <pre>object({<br>    image_name         = string,<br>    image_gallery_name = string,<br>    image_gallery_rg   = string,<br>  })</pre> | `null` | no |
| <a name="input_shared_image_id"></a> [shared\_image\_id](#input\_shared\_image\_id) | Use a specific Shared Image using the full ID | `string` | `null` | no |
| <a name="input_short_description"></a> [short\_description](#input\_short\_description) | Three-seven character identifier used in the hostnames to identitify the virtual machines. Example p9icaz"short\_description"01 | `string` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Specify the Subnet name which needs to be connect to the AkS cluster | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources created. | `map(string)` | `{}` | no |
| <a name="input_target_subnet_name"></a> [target\_subnet\_name](#input\_target\_subnet\_name) | Name of the subnet to to use when a failover is done | `string` | `null` | no |
| <a name="input_ultra_ssd_enabled"></a> [ultra\_ssd\_enabled](#input\_ultra\_ssd\_enabled) | Should the capacity to enable Data Disks of the UltraSSD\_LRS storage account type be supported on this Virtual Machine Scale Set? Defaults to false | `string` | `"false"` | no |
| <a name="input_vault_type"></a> [vault\_type](#input\_vault\_type) | Specifies which Vault type will this resource store its secrets. Possible values: 'hashicorp', 'akv', 'none'. | `string` | `"akv"` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | (Required) The SKU which should be used for this Virtual Machine, such as Standard\_F2 | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_vm_admin_login_assignments"></a> [vm\_admin\_login\_assignments](#input\_vm\_admin\_login\_assignments) | The list of ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created. This role assignment will assign Administrator privileges to the VM. | `list(string)` | `[]` | no |
| <a name="input_vm_name_override"></a> [vm\_name\_override](#input\_vm\_name\_override) | Override the default naming convention for the VM resource | `string` | `null` | no |
| <a name="input_vm_name_suffix"></a> [vm\_name\_suffix](#input\_vm\_name\_suffix) | The suffix that should be used for this machine. This value needs to change if multple VMs are create that share the same short description. | `string` | `1` | no |
| <a name="input_vm_replication"></a> [vm\_replication](#input\_vm\_replication) | VM replication block with the parameters required for replication creation | <pre>map(object({<br>    name                                      = string<br>    recovery_vault_resource_group_name        = string<br>    recovery_vault_name                       = string<br>    source_recovery_fabric_name               = string<br>    recovery_replication_policy_id            = string<br>    source_recovery_protection_container_name = string<br>    target_resource_group_id                  = string<br>    target_recovery_fabric_id                 = string<br>    target_recovery_protection_container_id   = string<br>  }))</pre> | `{}` | no |
| <a name="input_vm_user_login_assignments"></a> [vm\_user\_login\_assignments](#input\_vm\_user\_login\_assignments) | The list of ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing thi  s forces a new resource to be created. This role assignment will assign Standard User privileges to the VM. | `list(string)` | `[]` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Specify the VNET or leave null to get a vnet based on environment variable | `string` | `null` | no |
| <a name="input_vnet_rg"></a> [vnet\_rg](#input\_vnet\_rg) | Specify the VNET resource group or leave null to get a vnet based on environment variable | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_set_id"></a> [availability\_set\_id](#output\_availability\_set\_id) | The ID of the Availability Set. |
| <a name="output_data_disk_ids"></a> [data\_disk\_ids](#output\_data\_disk\_ids) | The ID of the Virtual Machine Data Disk attachment |
| <a name="output_managed_disk_id"></a> [managed\_disk\_id](#output\_managed\_disk\_id) | The ID of the Managed Disk |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | ids of the vm nics provisoned. |
| <a name="output_network_interface_private_ip"></a> [network\_interface\_private\_ip](#output\_network\_interface\_private\_ip) | private ip addresses of the vm nics |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | Virtual machine ids created. |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | Virtual machine names created. |
