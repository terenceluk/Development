data "azurerm_monitor_diagnostic_categories" "main" {
  for_each    = toset(["default", "blobServices", "fileServices", "queueServices", "tableServices"])
  resource_id = each.key == "default" ? azurerm_storage_account.main.id : "${azurerm_storage_account.main.id}/${each.key}/default"
}

resource "azurerm_monitor_diagnostic_setting" "custom" {
  for_each                       = var.diagnostics != null ? toset(["default", "blobServices", "fileServices", "queueServices", "tableServices"]) : []
  name                           = "${azurerm_storage_account.main.name}-custom-diag"
  target_resource_id             = each.key == "default" ? azurerm_storage_account.main.id : "${azurerm_storage_account.main.id}/${each.key}/default"
  log_analytics_workspace_id     = local.parsed_diag.log_analytics_id
  eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
  eventhub_name                  = local.parsed_diag.event_hub_auth_id != null ? var.diagnostics.eventhub_name : null
  storage_account_id             = local.parsed_diag.storage_account_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.main[each.key].logs
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
    for_each = data.azurerm_monitor_diagnostic_categories.main[each.key].metrics
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
  for_each                   = var.environment == "sandbox" || !var.enable_audit_diagnostics ? [] : toset(["default", "blobServices", "fileServices", "queueServices", "tableServices"])
  name                       = "azure_policy_audit"
  target_resource_id         = each.key == "default" ? azurerm_storage_account.main.id : "${azurerm_storage_account.main.id}/${each.key}/default"
  log_analytics_workspace_id = local.log_analytics_workspace_id

  dynamic "log" {
    iterator = log_category
    for_each = data.azurerm_monitor_diagnostic_categories.main[each.key].logs

    content {
      category = log_category.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 0
      }
    }
  }

  dynamic "metric" {
    iterator = metric_category
    for_each = data.azurerm_monitor_diagnostic_categories.main[each.key].metrics

    content {
      category = metric_category.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 365
      }
    }
  }
}
