variable "infoblox_creds" {
  description = "Infoblox login:password"
  default     = null
}

variable "domain_name" {
  description = "{Optional) Domain name for private endpoint"
  type        = string
  default     = null
}

variable "subnet_name" {
  description = "(Required) The name of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
  default     = null
}

variable "vnet_name" {
  description = "Specifies the name of the Virtual Network this Subnet is located within"
  default     = null
}

variable "vnet_rg" {
  description = "Specifies the name of the resource group the Virtual Network is located in"
  default     = null
}

variable "custom_network_interface_name" {
  description = "(Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_zone_group" {
  description = <<EOVS
  (Optional) A private_dns_zone_group block as defined below.
  ```
  A private_dns_zone_group block supports the following:
  name - (Required) Specifies the Name of the Private DNS Zone Group. Changing this forces a new private_dns_zone_group resource to be created.
  private_dns_zone_ids - (Required) Specifies the list of Private DNS Zones to include within the private_dns_zone_group.
  ```
  EOVS
  default     = null
  type        = map(any)
}

variable "pe_name_override" {
  default     = null
  description = "Override PE name if it shouldn't be the same as project name"
}

variable "instance_number" {
  default     = "01"
  description = "instance number of azure mysql server"
}

variable "brand" {
  default = "ctc"
}

variable "project_name" {
  description = "Your project name"
}

variable "costcenter" {
  description = "Assigned cost center"
  type        = string
  default     = null
}

variable "projectcode" {
  description = "Assigned project code"
  type        = string
  default     = null
}

variable "environment" {
  description = "The enviroment this private endpoint is in"
}

variable "location" {
  description = "(Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "location_code" {
  description = "The location code of the resource"
  default     = "cc"
}

variable "resource_group_name" {
  description = "(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created."
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "connection_name" {
  description = "Name of connection"
  type        = string
}

variable "is_manual_connection" {
  description = <<EOVS
  (Required) Does the Private Endpoint require Manual Approval from the remote resource owner? 
  Changing this forces a new resource to be created.
  NOTE:
  If you are trying to connect the Private Endpoint to a remote resource without having the correct RBAC permissions 
  on the remote resource set this value to true.
  EOVS
  default     = false
  type        = bool
}

variable "private_connection_resource_id" {
  description = <<EOVS
  (Optional) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. 
  One of private_connection_resource_id or private_connection_resource_alias must be specified. 
  Changing this forces a new resource to be created. For a web app or function app slot, 
  the parent web app should be used in this field instead of a reference to the slot itself.
  EOVS
  type        = string
  default     = null
}

variable "private_connection_resource_alias" {
  description = <<EOVS
  (Optional) The Service Alias of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. 
  One of private_connection_resource_id or private_connection_resource_alias must be specified. 
  Changing this forces a new resource to be created.
  EOVS
  type        = string
  default     = null
}

variable "subresource_names" {
  description = <<EOVS
   (Optional) A list of subresource names which the Private Endpoint is able to connect to. 
   subresource_names corresponds to group_id. Changing this forces a new resource to be created.
   https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
  EOVS
  type        = list(string)
  default     = null
}

variable "request_message" {
  description = <<EOVS
  (Optional) A message passed to the owner of the remote resource when the private endpoint attempts to establish the connection 
  to the remote resource. The request message can be a maximum of 140 characters in length. 
  Only valid if is_manual_connection is set to true.
  EOVS
  type        = string
  default     = null
}

variable "create_private_dns_record" {
  description = "Specifies whether private DNS record should be created through infoblox."
  default     = false
  type        = bool
}

variable "ip_configuration" {
  description = <<EOVS
  (Optional) One or more ip_configuration blocks as defined below. 
  This allows a static IP address to be set for this Private Endpoint, otherwise an address is dynamically allocated from the Subnet. 
  Changing this forces a new resource to be created.
  ```
  name - (Required) Specifies the Name of the IP Configuration. Changing this forces a new resource to be created.
  private_ip_address - (Required) Specifies the static IP address within the private endpoint's subnet to be used. Changing this forces a new resource to be created.
  subresource_name - (Required) Specifies the subresource this IP address applies to. subresource_names corresponds to group_id. Changing this forces a new resource to be created.
  member_name - (Optional) Specifies the member name this IP address applies to. If it is not specified, it will use the value of subresource_name. Changing this forces a new resource to be created.
  ```
  EOVS
  type        = map(any)
  default     = {}
}
