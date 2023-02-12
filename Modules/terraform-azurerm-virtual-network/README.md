## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.audit](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.custom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_monitor_diagnostic_categories.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | address space where for the vnets to get deployed | `any` | n/a | yes |
| <a name="input_brand"></a> [brand](#input\_brand) | Company Brand | `string` | `"ctc"` | no |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | DDOS protection plan resource ID | `string` | `"/subscriptions/3cfbe6a8-476c-4cb2-861e-2aef20da3113/resourceGroups/connectivity-prod-corenetwork-cc-rg/providers/Microsoft.Network/ddosProtectionPlans/connectivityprodcorenetworkcc-ddos"` | no |
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostic settings for those resources that support it. See README.md for details on configuration. | <pre>object({<br>    destination   = string<br>    eventhub_name = string<br>    logs          = list(string)<br>    metrics       = list(string)<br>  })</pre> | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of DNS servers the Vnet needs to attached | `any` | `null` | no |
| <a name="input_enable_ddos_protection"></a> [enable\_ddos\_protection](#input\_enable\_ddos\_protection) | Enable DDOS protection plan Standard on VNET | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Which enviroment sandbox nonprod prod infra | `string` | `"sandbox"` | no |
| <a name="input_id"></a> [id](#input\_id) | Virtual Network Id Number | `string` | `"1"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the Virtual Network is located. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_override_vnet_name"></a> [override\_vnet\_name](#input\_override\_vnet\_name) | Override Vnet name if it shouldn't be the same as project name | `any` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group Name where Virtual network gets deployed | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Add any additional tags to this map | `map` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | A name of virtual network you would like to create. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | ID of the created virtual network |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | Name of the created virtual network |
| <a name="output_vnet_rg"></a> [vnet\_rg](#output\_vnet\_rg) | Resource Group VNet is created in |


## Usage
See test plans: https://bitbucket.corp.ad.ctc/projects/EFTM/repos/terraform-azurerm-virtual-network/browse/test/integration/terraform/plan 

