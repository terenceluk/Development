data "azurerm_monitor_diagnostic_categories" "main" {
  resource_id = azurerm_virtual_network.main.id
}

resource "azurerm_monitor_diagnostic_setting" "custom" {
  count                          = var.diagnostics != null ? 1 : 0
  name                           = "${azurerm_virtual_network.main.name}-custom-diag"
  target_resource_id             = azurerm_virtual_network.main.id
  log_analytics_workspace_id     = local.parsed_diag.log_analytics_id
  eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
  eventhub_name                  = local.parsed_diag.event_hub_auth_id != null ? var.diagnostics.eventhub_name : null
  storage_account_id             = local.parsed_diag.storage_account_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.main.logs
    content {
      category = log.value
      enabled  = contains(local.parsed_diag.log, "all") || contains(local.parsed_diag.log, log.value)

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.main.metrics
    content {
      category = metric.value
      enabled  = contains(local.parsed_diag.metric, "all") || contains(local.parsed_diag.metric, metric.value)

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "audit" {
  count                      = var.environment == "sandbox" ? 0 : 1
  name                       = "azure_policy_audit"
  target_resource_id         = azurerm_virtual_network.main.id
  log_analytics_workspace_id = local.log_analytics_workspace_id

  dynamic "log" {
    iterator = log_category
    for_each = data.azurerm_monitor_diagnostic_categories.main.logs

    content {
      category = log_category.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 0
      }
    }
  }
}