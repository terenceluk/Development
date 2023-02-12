variable "brand" {
  description = "Company Brand"
  default     = "ctc"
}

variable "vnet_name" {
  description = "A name of virtual network you would like to create."
}

variable "tags" {
  description = "Add any additional tags to this map"
  default     = {}
}

variable "location" {
  description = "The location/region where the Virtual Network is located. Changing this forces a new resource to be created."
  type        = string
  validation {
    condition = (
      var.location == "Canada Central" || var.location == "Canada East"
    )
    error_message = "Only regions canada central or canada east are currently supported."
  }
}

variable "environment" {
  description = "Which enviroment sandbox nonprod prod infra"
  default     = "sandbox"
}

variable "dns_servers" {
  description = "List of DNS servers the Vnet needs to attached"
  default     = null
}


variable "resource_group_name" {
  description = "Resource Group Name where Virtual network gets deployed"
}


variable "address_space" {
  description = "address space where for the vnets to get deployed"
}

variable "override_vnet_name" {
  description = "Override Vnet name if it shouldn't be the same as project name "
  default     = null
}

variable "diagnostics" {
  description = "Diagnostic settings for those resources that support it. See README.md for details on configuration."
  type = object({
    destination   = string
    eventhub_name = string
    logs          = list(string)
    metrics       = list(string)
  })
  default = null
}


variable "enable_diagnostic_setting" {
  type    = bool
  default = true
}

variable "id" {
  description = "Virtual Network Id Number"
  type        = string
  default     = "1"
}

variable "enable_ddos_protection" {
  description = "Enable DDOS protection plan Standard on VNET"
  type        = bool
  default     = true
}

variable "ddos_protection_plan" {
  description = "DDOS protection plan resource ID"
  type        = string
  default     = "/subscriptions/3cfbe6a8-476c-4cb2-861e-2aef20da3113/resourceGroups/connectivity-prod-corenetwork-cc-rg/providers/Microsoft.Network/ddosProtectionPlans/connectivityprodcorenetworkcc-ddos"
}