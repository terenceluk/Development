locals {

  location_map = {
    "Canada Central" = "Canada Central"
    "canadacentral"  = "Canada Central"
    "cc"             = "Canada Central"
    "Canada East"    = "Canada East"
    "canadaeast"     = "Canada East"
    "ce"             = "Canada East"
  }
  location_code_map = {
    "Canada Central" = "cc"
    "canadacentral"  = "cc"
    "cc"             = "cc"
    "Canada East"    = "ce"
    "canadaeast"     = "ce"
    "ce"             = "ce"
  }

  location      = local.location_map[var.location]
  location_code = local.location_code_map[var.location]

  default_delete_retention_policy_days = 90

  vnet_rg                    = var.enable_privatelink == false ? null : var.vnet_rg == null && var.environment != "sandbox" ? "ctc-${var.environment}-corenetwork-${local.location_code}-rg" : var.vnet_rg
  subnet_name                = var.enable_privatelink == false ? null : var.subnet_name == null && var.environment != "sandbox" ? "ctc-${var.environment}-corenetwork-${local.location_code}-vnet-app01-snet" : var.subnet_name
  vnet_name                  = var.enable_privatelink == false ? null : var.vnet_rg == null && var.environment != "sandbox" ? "ctc-${var.environment}-corenetwork-${local.location_code}-vnet" : var.vnet_name
  subscription_id            = replace(regex("subscriptions/[^/]*", azurerm_storage_account.main.id), "subscriptions/", "")
  subnet_id                  = var.enable_privatelink == false ? null : format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/virtualNetworks/%s/subnets/%s", local.subscription_id, local.vnet_rg, local.vnet_name, local.subnet_name)
  resource_group_name        = var.resource_group_name == null ? lower(var.location) == "canada central" ? lower(format("%s-%s-%s-cc-rg", var.brand, var.environment, var.project_name)) : lower(format("%s-%s-%s-ce-rg", var.brand, var.environment, var.project_name)) : var.resource_group_name
  primary_name               = format("%s%s%s", var.project_name, var.environment, random_string.primary.result)
  log_analytics_workspace_id = coalesce(var.log_analytics_workspace_id, "/subscriptions/c1db24d3-f1c5-46b0-8e75-69fc8a0ffd2e/resourceGroups/ctc-prod-loganalytics-workspace-cc-rg/providers/Microsoft.OperationalInsights/workspaces/ctc-prod-log-analytics-workspace")
  diag_resource_list         = var.diagnostics != null ? split("/", var.diagnostics.destination) : []
  parsed_diag = var.diagnostics != null ? {
    log_analytics_id   = contains(local.diag_resource_list, "Microsoft.OperationalInsights") ? var.diagnostics.destination : null
    storage_account_id = contains(local.diag_resource_list, "Microsoft.Storage") ? var.diagnostics.destination : null
    event_hub_auth_id  = contains(local.diag_resource_list, "Microsoft.EventHub") ? var.diagnostics.destination : null
    metric             = var.diagnostics.metrics
    log                = var.diagnostics.logs
    } : {
    log_analytics_id   = null
    storage_account_id = null
    event_hub_auth_id  = null
    metric             = []
    log                = []
  }
  module_version = trimspace(file("${path.module}/VERSION"))
  default_tags = {
    brand          = var.brand
    costcenter     = var.costcenter
    projectcode    = var.projectcode
    environment    = var.environment
    location       = var.location
    resource_group = local.resource_group_name
    deployed_using = "Terraform - terraform.azurerm.storage_account ${local.module_version}"
  }
  replication = lower(var.environment) == "sandbox" ? "LRS" : lower(var.environment) == "nonprod" ? "GRS" : lower(var.environment) == "prod" && local.location_code == "cc" && var.is_BootDiag == false ? "GZRS" : "RAGRS"
}
