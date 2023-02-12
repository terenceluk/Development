locals {
  log_analytics_workspace_id = "/subscriptions/c1db24d3-f1c5-46b0-8e75-69fc8a0ffd2e/resourceGroups/ctc-prod-loganalytics-workspace-cc-rg/providers/Microsoft.OperationalInsights/workspaces/ctc-prod-log-analytics-workspace"
  diag_resource_list         = var.diagnostics != null ? split("/", var.diagnostics.destination) : []
  location_code              = lower(var.location) == "canada central" ? "cc" : "ce"
  ddos_protection_plan       = var.ddos_protection_plan == null ? "/subscriptions/3cfbe6a8-476c-4cb2-861e-2aef20da3113/resourceGroups/connectivity-prod-corenetwork-cc-rg/providers/Microsoft.Network/ddosProtectionPlans/connectivityprodcorenetworkcc-ddos" : var.ddos_protection_plan
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
    costcenter     = null
    projectcode    = null
    brand          = var.brand
    environment    = var.environment
    location       = var.location
    deployed_using = "Terraform - terraform.vnet ${local.module_version}"
  }

}
resource "azurerm_virtual_network" "main" {
  name                = var.override_vnet_name == null ? lower(format("%s-%s-%s-%s-vnet-%02d", var.brand, var.environment, var.vnet_name, local.location_code, var.id)) : lower(format("%s-%s-%s-%s-vnet-%02d", var.brand, var.environment, var.override_vnet_name, local.location_code, var.id))
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags

  dynamic "ddos_protection_plan" {
    for_each = var.enable_ddos_protection ? [{}] : []
    content {
      id     = local.ddos_protection_plan
      enable = true
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
