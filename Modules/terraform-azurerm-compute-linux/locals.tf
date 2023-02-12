locals {
  location_code = lower(var.location) == "canada central" ? "cc" : "ce"
  prefix        = lower(var.environment) == "prod" ? "p9vmaz" : lower(var.environment) == "nonprod" ? var.is_dev == true ? "d9vmaz" : "q9vmaz" : "t9vmaz"
  vnet_rg       = var.vnet_rg == null && var.environment != "sandbox" ? "ctc-${var.environment}-corenetwork-${local.location_code}-rg" : var.vnet_rg
  subnet_name   = var.subnet_name == null && var.environment != "sandbox" ? "ctc-${var.environment}-corenetwork-${local.location_code}-vnet01-app02-snet" : var.subnet_name
  vnet_name     = var.vnet_rg == null && var.environment != "sandbox" ? "ctc-${var.environment}-corenetwork-${local.location_code}-vnet01" : var.vnet_name
  primary_name  = format("%s%s%02d", local.prefix, var.short_description, var.vm_name_suffix)
  vm_name       = var.vm_name_override == null ? lower(format("%s", local.primary_name)) : var.vm_name_override

  module_version = file("${path.module}/VERSION")

  default_tags = {
    costcenter     = null
    projectcode    = null
    brand          = var.brand
    environment    = var.environment
    location       = var.location
    resource_group = var.resource_group_name
    deployed_using = "Terraform - terraform.azurerm.compute-linux ${local.module_version}"
  }
}