# Module Name

private-endpoint

Manages a Private Endpoint.

Azure Private Endpoint is a network interface that connects you privately and securely to a service powered by Azure Private Link. Private Endpoint uses a private IP address from your VNet, effectively bringing the service into your VNet. The service could be an Azure service such as Azure Storage, SQL, etc. or your own Private Link Service.

## Compatibility

This module is meant for use with Terraform 12.x and azure azurerm ~> 2.2.0

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| brand |  | string | `"ctc"` | no |
| environment | The enviroment this private endpoint is in | string | n/a | yes |
| infoblox\_creds | Infoblox login:password | string | n/a | yes |
| location | The location of this resource group | string | n/a | yes |
| location\_code | The location code of the resource | string | `"cc"` | no |
| private\_endpoint | A map object of the private endpoint settings | any | `<map>` | no |
| project\_name | Your project name | string | n/a | yes |
| resource\_group\_name | The resource group to put the private endpoint(s) in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private\_endpoint\_id | ID of the private endpoint |
| private\_endpoint\_ip | IP of the private endpoint |

## private\_endpoint

| Name | Description |
|------|-------------|
| subnet\_name | (Required) The subnet name where the endpoint will be created |
| pe\_name\_override | (Optional) If you need to override the default pe naming convention |
| instance\_number | (Required) The instance number of the private endpoint in your resource group |
| connection_name | (Required) Specifies the Name of the Private Service Connection. It is all the name of the dns a recorded created for the private endpoint. Changing this forces a new resource to be created. |
| is_manual_connection | (Optional) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created. Defaults to false |
| private_connection_resource_id | (Required) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. Changing this forces a new resource to be created. |
| subresource_names | (Optional) A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id. Changing this forces a new resource to be created. |
| request_message | (Optional) A message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource. The request message can be a maximum of 140 characters in length. Only valid if is_manual_connection is set to true. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK --

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.2.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [null_resource.main](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_brand"></a> [brand](#input\_brand) | n/a | `string` | `"ctc"` | no |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Name of connection | `string` | n/a | yes |
| <a name="input_costcenter"></a> [costcenter](#input\_costcenter) | Assigned cost center | `string` | `null` | no |
| <a name="input_create_private_dns_record"></a> [create\_private\_dns\_record](#input\_create\_private\_dns\_record) | Specifies wheater private DNS record should be created through infoblox. | `bool` | `false` | no |
| <a name="input_custom_network_interface_name"></a> [custom\_network\_interface\_name](#input\_custom\_network\_interface\_name) | (Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | {Optional) Domain name for private endpoint | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The enviroment this private endpoint is in | `any` | n/a | yes |
| <a name="input_infoblox_creds"></a> [infoblox\_creds](#input\_infoblox\_creds) | Infoblox login:password | `any` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | instance number of azure mysql server | `string` | `"01"` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | (Optional) One or more ip\_configuration blocks as defined below. <br>  This allows a static IP address to be set for this Private Endpoint, otherwise an address is dynamically allocated from the Subnet. <br>  Changing this forces a new resource to be created. | <pre>map(object({<br>    name                     = string<br>    kv_sas_linked_svc_name   = string<br>    kv_sas_linked_svc_secret = string<br>    sas_uri                  = string<br>  }))</pre> | `{}` | no |
| <a name="input_is_manual_connection"></a> [is\_manual\_connection](#input\_is\_manual\_connection) | (Required) Does the Private Endpoint require Manual Approval from the remote resource owner? <br>  Changing this forces a new resource to be created.<br>  NOTE:<br>  If you are trying to connect the Private Endpoint to a remote resource without having the correct RBAC permissions <br>  on the remote resource set this value to true. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_location_code"></a> [location\_code](#input\_location\_code) | The location code of the resource | `string` | `"cc"` | no |
| <a name="input_pe_name_override"></a> [pe\_name\_override](#input\_pe\_name\_override) | Override PE name if it shouldn't be the same as project name | `any` | `null` | no |
| <a name="input_private_connection_resource_alias"></a> [private\_connection\_resource\_alias](#input\_private\_connection\_resource\_alias) | (Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. <br>  One of private\_connection\_resource\_id or private\_connection\_resource\_alias must be specified. <br>  Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_private_connection_resource_id"></a> [private\_connection\_resource\_id](#input\_private\_connection\_resource\_id) | (Optional) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. <br>  One of private\_connection\_resource\_id or private\_connection\_resource\_alias must be specified. <br>  Changing this forces a new resource to be created. For a web app or function app slot, <br>  the parent web app should be used in this field instead of a reference to the slot itself. | `string` | `null` | no |
| <a name="input_private_dns_zone_group"></a> [private\_dns\_zone\_group](#input\_private\_dns\_zone\_group) | (Optional) A private\_dns\_zone\_group block as defined below.<pre>A private_dns_zone_group block supports the following:<br>  name - (Required) Specifies the Name of the Private DNS Zone Group. Changing this forces a new private_dns_zone_group resource to be created.<br>  private_dns_zone_ids - (Required) Specifies the list of Private DNS Zones to include within the private_dns_zone_group.</pre> | `any` | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Your project name | `any` | n/a | yes |
| <a name="input_projectcode"></a> [projectcode](#input\_projectcode) | Assigned project code | `string` | `null` | no |
| <a name="input_request_message"></a> [request\_message](#input\_request\_message) | (Optional) A message passed to the owner of the remote resource when the private endpoint attempts to establish the connection <br>  to the remote resource. The request message can be a maximum of 140 characters in length. <br>  Only valid if is\_manual\_connection is set to true. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | (Required) The name of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | (Optional) A list of subresource names which the Private Endpoint is able to connect to. <br>   subresource\_names corresponds to group\_id. Changing this forces a new resource to be created.<br>   <https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource> | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Specifies the name of the Virtual Network this Subnet is located within | `any` | `null` | no |
| <a name="input_vnet_rg"></a> [vnet\_rg](#input\_vnet\_rg) | Specifies the name of the resource group the Virtual Network is located in | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_dns_zone_group_id"></a> [private\_dns\_zone\_group\_id](#output\_private\_dns\_zone\_group\_id) | The ID of the Private DNS Zone Group. |
| <a name="output_private_endpoint_id"></a> [private\_endpoint\_id](#output\_private\_endpoint\_id) | ID of the private endpoint |
| <a name="output_private_endpoint_ip"></a> [private\_endpoint\_ip](#output\_private\_endpoint\_ip) | IP of the private endpoint |
<!-- END_TF_DOCS -->