# Azure Subnet Module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.29.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | The address prefixes to use for the subnet | `list(string)` | n/a | yes |
| <a name="input_delegation"></a> [delegation](#input\_delegation) | The delegate name | `map(any)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Which enviroment sandbox nonprod prod infra | `string` | `"sandbox"` | no |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | Specifies the name of the network security group | `string` | `null` | no |
| <a name="input_nsg_resource_group_name"></a> [nsg\_resource\_group\_name](#input\_nsg\_resource\_group\_name) | Specifies the name of the resource group in which network security group exist | `string` | `null` | no |
| <a name="input_override_subnet_name"></a> [override\_subnet\_name](#input\_override\_subnet\_name) | n/a | `string` | `null` | no |
| <a name="input_private_endpoint_network_policies_enabled"></a> [private\_endpoint\_network\_policies\_enabled](#input\_private\_endpoint\_network\_policies\_enabled) | Enable or Disable network policies for the private link endpoint on the subnet | `bool` | `false` | no |
| <a name="input_private_link_service_network_policies_enabled"></a> [private\_link\_service\_network\_policies\_enabled](#input\_private\_link\_service\_network\_policies\_enabled) | Enable or Disable network policies for the private link endpoint on the subnet | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the subnet | `string` | n/a | yes |
| <a name="input_rt_name"></a> [rt\_name](#input\_rt\_name) | The name of the route table | `string` | `null` | no |
| <a name="input_rt_resource_group_name"></a> [rt\_resource\_group\_name](#input\_rt\_resource\_group\_name) | Specifies the name of the resource group in which the route table exist | `string` | `null` | no |
| <a name="input_service_delegation"></a> [service\_delegation](#input\_service\_delegation) | The name of service to delegate to | `map(any)` | `{}` | no |
| <a name="input_service_endpoint_policy_ids"></a> [service\_endpoint\_policy\_ids](#input\_service\_endpoint\_policy\_ids) | (Optional) The list of IDs of Service Endpoint Policies to associate with the subnet. | `list(string)` | `null` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | The list of Service endpoints to associate with the subnet. | `list(string)` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet network to which to attach the subnet | `string` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the virtual network to which to attach the subnet | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The Virtual Network Subnet resource ID. |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The Virtual Network Subnet resource ID. |
