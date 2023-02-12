variable "azure_subscription_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
variable "vault_addr" {}
variable "vault_token" {}
variable "resource_group_name" { default = "ctc-nonprod-tfmodules-cc-rg" }
variable "environment" { default = "nonprod" }
variable "project_name" { default = "tfmodules" }
variable "brand" { default = "ctc" }
variable "location" { default = "Canada Central" }
variable "location_code" { default = "cc" }
