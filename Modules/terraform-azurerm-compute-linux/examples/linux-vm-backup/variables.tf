variable "azure_subscription_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
variable "resource_group_name" { default = "ctc-nonprod-tfmodules-cc-rg" }
variable "environment" { default = "nonprod" }
variable "project_name" { default = "tfmodules" }
variable "location" { default = "Canada Central" }
variable "brand" { default = "ctc" }