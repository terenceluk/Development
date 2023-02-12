/*
This file contains all the variables defined for the terraform code
Refer to {env}-gallery.tfvars for the actual value for these variables
*/

# Variables Definitions

variable "environment" {
  type        = string
  description = "Which enviroment sandbox nonprod prod infra"
  validation {
    condition     = contains(["sandbox", "nonprod", "infra", "dev", "qa", "stage", "prod", ], var.environment)
    error_message = "Allowed values for 'environment' are: 'sanbox', 'nonprod', 'infra', 'dev', 'qa', 'stage', 'prod'."
  }
  default = "sandbox"
}

variable "override_subnet_name" {
  default = null
  type    = string
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network to which to attach the subnet"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the subnet"
}

variable "subnets" {
  type = map(object({
    name = string
    cidr = list(string)
  }))
}

variable "service_endpoints" {
  type        = list(string)
  default     = null
  description = "The list of Service endpoints to associate with the subnet."
}

variable "service_endpoint_policy_ids" {
  type        = list(string)
  default     = null
  description = "(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet."
}

variable "private_link_service_network_policies_enabled" {
  default     = false
  type        = bool
  description = " Enable or Disable network policies for the private link endpoint on the subnet"
}

variable "private_endpoint_network_policies_enabled" {
  default     = false
  type        = bool
  description = " Enable or Disable network policies for the private link endpoint on the subnet"
}

variable "delegation" {
  type        = map(any)
  default     = {}
  description = "The delegate name"
}

# tflint-ignore: terraform_unused_declarations
variable "service_delegation" {
  type        = map(any)
  default     = {}
  description = "The name of service to delegate to"
}

variable "rt_name" {
  type        = string
  default     = null
  description = "The name of the route table"
}

variable "rt_resource_group_name" {
  type        = string
  default     = null
  description = "Specifies the name of the resource group in which the route table exist"
}

variable "nsg_name" {
  type        = string
  default     = null
  description = "Specifies the name of the network security group"
}

variable "nsg_resource_group_name" {
  type        = string
  default     = null
  description = "Specifies the name of the resource group in which network security group exist"
}

# Variables for Service Principal and Tenant
variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure App Registration Application (client) ID"
}

variable "client_secret" {
  type        = string
  description = "Azure App Registration Application secret"
}

variable "tenant_id" {
  type        = string
  description = "Azure App Registration Application Direcotry (tenant) ID"
}