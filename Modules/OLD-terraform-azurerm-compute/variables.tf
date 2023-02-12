variable "project_name" {
  type = string
}

variable "location_code" {
  type = string
}

variable "environment" {
  type = string
}

variable "brand" {
  type    = string
  default = "ctc"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to create these resources in"
}

variable "platform_fault_domain_count" {
  type        = number
  description = "Specifies the number of fault domains that are used."
  default     = 2
}

variable "platform_update_domain_count" {
  type        = number
  description = "Specifies the number of update domains that are used."
  default     = 2
}

variable "avset_tags" {
  type        = map
  description = "Specific Tags for avset"
  default     = {}
}

variable "linux" {
  type        = any
  description = "Map that creates Linux VMs"
  default     = {}
}

variable "windows" {
  type        = any
  description = "Map that creates Linux VMs"
  default     = {}
}

variable "infoblox_creds" {
  description = "Infoblox login:password"
}
