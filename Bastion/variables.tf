/*
This file contains all the variables defined for the terraform code
Refer to {env}-gallery.tfvars for the actual value for these variables
*/

# Variables Definitions
/*
variable "name" {
  type        = string
  description = "Configure the name for the shared image gallery"
}

variable "override_gallery_name" {
  type        = string
  description = "Configure the override name for the shared image gallery"
}
*/

variable "bastion_hosts" {
  type = map

}


  
  /*(
    object({
    resource_group_name = string
    virtual_network_rg = string
    virtual_network_name = string
    subnet_name = string
    availability_zone = number 
    type = map(
      object({
      disk_size = number
      caching = string
      create_option = string
      storage_account_name = string
    })
    )
    type = map(
      object({
      publisher = string
      offer = string
      sku = string
      version = string
    })
    )
    type = map(
      object({
      name = string
      publisher = string
      product = string
    })
    )
  })
  )
}*/

variable "resource_group_name" {
  type        = string
  description = "Configure the resource group name"
}

variable "resource_group_location" {
  type        = string
  description = "Configure the resource group location"
}

variable "description" {
  type        = string
  description = "Configure the description for the shared image gallery"
}

variable "environment" {
  type        = string
  description = "Which enviroment sandbox nonprod prod infra"
  validation {
    condition     = contains(["sandbox", "nonprod", "infra", "dev", "qa", "stage", "prod", ], var.environment)
    error_message = "Allowed values for 'environment' are: 'sanbox', 'nonprod', 'infra', 'dev', 'qa', 'stage', 'prod'."
  }
  default = "sandbox"
}

variable "project_name" {
  type        = string
  description = "(Required)The project name"
  default     = null
}

variable "short_description" {
  description = "Three-seven character identifier used in the hostnames to identitify the virtual machines. Example p9icaz\"short_description\"01"
  type        = string
  default     = null
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

