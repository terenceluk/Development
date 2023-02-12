
variable "brand" {
  description = "Default brand name."
  type        = string
  default     = "ctc"
}

variable "costcenter" {
  description = "Assigned cost center."
  type        = string
  default     = null
}

variable "projectcode" {
  description = "Assigned project code."
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment. For example: non-prod, dev, qa, stage, prod."
  type        = string
  default     = "non-prod"
}

variable "location" {
  description = "The location/region where the Virtual Network is located. Changing this forces a new resource to be created."
  type        = string
  validation {
    condition     = contains(["Canada Central", "Canada East", "cc", "ce", "canadacentral", "canadaeast"], var.location)
    error_message = "Only regions canada central or canada east are currently supported."
  }
  default = "Canada Central"
}

variable "key_vault_name" {
  description = "Name of the key vault where the secrets has to be created"
  type        = string
}

variable "key_vault_rg" {
  description = "resource group of the keyvault"
  type        = string
}

variable "secrets" {
  description = <<EOVS
This block will create the Key Vault Secrets.
`secret_name` - (Required) The of the secret to be created. Cannot contain char: " _ ".
`secret_value` - (Required) The value of the coresponding secret to be created.
`content_type` - (Required) The content type for example string or bool.
`expiration_date` - (Optional) Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
`not_before_date` - (Optional) Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').
EOVS
  default     = []
  type        = list(any)
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}