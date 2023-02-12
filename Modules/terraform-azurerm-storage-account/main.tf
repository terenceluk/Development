/**
* # AzureRM storage-account module
*/

resource "random_string" "primary" {
  length  = 3
  special = false
  upper   = false
}

resource "azurerm_storage_account" "main" {
  name                              = var.name_override == null ? lower(format("%sst", replace(local.primary_name, "/[[:^alnum:]]/", ""))) : lower(format("%sst", replace(var.name_override, "/[[:^alnum:]]/", "")))
  resource_group_name               = local.resource_group_name
  location                          = local.location
  account_kind                      = "StorageV2"
  account_tier                      = var.account_tier
  account_replication_type          = var.replication_override == null ? local.replication : var.replication_override
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  access_tier                       = var.access_tier
  edge_zone                         = var.edge_zone
  enable_https_traffic_only         = true
  min_tls_version                   = "TLS1_2"
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  shared_access_key_enabled         = var.shared_access_key_enabled
  is_hns_enabled                    = var.gen2fs == [] ? var.is_hns_enabled : true
  nfsv3_enabled                     = var.nfsv3_enabled
  large_file_share_enabled          = var.large_file_share_enabled
  queue_encryption_key_type         = var.queue_encryption_key_type
  table_encryption_key_type         = var.table_encryption_key_type
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled

  dynamic "network_rules" {
    for_each = var.nfsv3_enabled == true ? [1] : []
    content {
      default_action             = var.default_action == null ? "Deny" : var.default_action
      bypass                     = var.bypass
      ip_rules                   = concat(["196.54.42.232/30", "196.54.42.236/30"], var.ip_rules)
      virtual_network_subnet_ids = try(var.virtual_network_subnet_ids, null)
    }
  }

  tags = merge(local.default_tags, var.tags)
  lifecycle {
    ignore_changes = [
      tags["costcenter"],
      tags["projectcode"],
      tags["environment"],
    ]
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? [var.blob_properties] : []
    content {
      dynamic "cors_rule" {
        for_each = lookup(blob_properties.value, "cors_rule", [])
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = lookup(blob_properties.value, "delete_retention_policy", null) != null ? [blob_properties.value.delete_retention_policy] : [{ days = local.default_delete_retention_policy_days }]
        content {
          days = delete_retention_policy.value.days
        }
      }

      versioning_enabled       = var.gen2fs == [] ? var.is_hns_enabled == false ? true : false : false
      change_feed_enabled      = lookup(blob_properties.value, "change_feed_enabled", false)
      default_service_version  = lookup(blob_properties.value, "default_service_version", "2020-06-12")
      last_access_time_enabled = true

      dynamic "container_delete_retention_policy" {
        for_each = lookup(blob_properties.value, "container_delete_retention_policy", null) != null ? [blob_properties.value.container_delete_retention_policy] : [{ days = 7 }]
        content {
          days = container_delete_retention_policy.value.days
        }
      }
    }
  }

  dynamic "custom_domain" {
    for_each = var.custom_domain != null ? [var.custom_domain] : []
    content {
      name          = custom_domain.value.name
      use_subdomain = lookup(custom_domain.value, "use_subdomain", false)
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []
    content {
      key_vault_key_id          = customer_managed_key.value.key_vault_key_id
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.type == "SystemAssigned" ? null : identity.value.identity_ids
    }
  }

  dynamic "azure_files_authentication" {
    for_each = var.azure_files_authentication != null ? [var.azure_files_authentication] : []
    content {
      directory_type = azure_files_authentication.value.directory_type
      dynamic "active_directory" {
        for_each = lookup(azure_files_authentication.value, "active_directory", {}) == {} && azure_files_authentication.value.directory_type != "AD" ? [] : [azure_files_authentication.value.active_directory]
        content {
          storage_sid         = active_directory.value.storage_sid
          domain_name         = active_directory.value.domain_name
          domain_sid          = active_directory.value.domain_sid
          domain_guid         = active_directory.value.domain_guid
          forest_name         = active_directory.value.forest_name
          netbios_domain_name = active_directory.value.netbios_domain_name
        }
      }
    }
  }

  dynamic "routing" {
    for_each = var.routing != null ? [var.routing] : []
    content {
      publish_internet_endpoints  = lookup(routing.value, "publish_internet_endpoints", false)
      publish_microsoft_endpoints = lookup(routing.value, "publish_microsoft_endpoints", false)
      choice                      = lookup(routing.value, "choice", "MicrosoftRouting")
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_properties != null ? [var.queue_properties] : []
    content {
      dynamic "cors_rule" {
        for_each = lookup(queue_properties.value, "cors_rule", [])
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      dynamic "logging" {
        for_each = lookup(queue_properties.value, "logging", null) != null ? [queue_properties.value.logging] : []
        content {
          delete                = logging.value.delete
          read                  = logging.value.read
          version               = logging.value.version
          write                 = logging.value.write
          retention_policy_days = lookup(logging.value, "retention_policy_days", null)
        }
      }
      dynamic "minute_metrics" {
        for_each = lookup(queue_properties.value, "minute_metrics", null) != null ? [queue_properties.value.minute_metrics] : []
        content {
          enabled               = minute_metrics.value.enabled
          version               = minute_metrics.value.version
          include_apis          = lookup(minute_metrics.value, "include_apis", null)
          retention_policy_days = lookup(minute_metrics.value, "retention_policy_days", null)
        }
      }
      dynamic "hour_metrics" {
        for_each = lookup(queue_properties.value, "hour_metrics", null) != null ? [queue_properties.value.hour_metrics] : []
        content {
          enabled               = hour_metrics.value.enabled
          version               = hour_metrics.value.version
          include_apis          = lookup(hour_metrics.valuey, "include_apis", null)
          retention_policy_days = lookup(hour_metrics.value, "retention_policy_days", null)
        }
      }
    }
  }

  dynamic "share_properties" {
    for_each = var.share_properties != null ? [var.share_properties] : []
    content {
      dynamic "cors_rule" {
        for_each = lookup(share_properties.value, "cors_rule", [])

        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      retention_policy {
        days = lookup(share_properties.value.retention_policy, "days", 7)
      }
      dynamic "smb" {
        for_each = lookup(share_properties.value, "smb", null) != null ? [share_properties.value.smb] : []
        content {
          versions                        = lookup(smb.value, "versions", null)
          authentication_types            = lookup(smb.value, "authentication_types", null)
          kerberos_ticket_encryption_type = lookup(smb.value, "kerberos_ticket_encryption_type", null)
          channel_encryption_type         = lookup(smb.value, "channel_encryption_type", null)
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = var.static_website == null ? [] : [var.static_website]
    content {
      index_document     = lookup(static_website.value, "index_document", null)
      error_404_document = lookup(static_website.value, "error_404_document", null)
    }
  }
}

resource "azurerm_advanced_threat_protection" "threat_protection" {
  target_resource_id = azurerm_storage_account.main.id
  enabled            = true
}

resource "azurerm_storage_account_network_rules" "main" {
  count                      = var.nfsv3_enabled != true ? 1 : 0
  storage_account_id         = azurerm_storage_account.main.id
  default_action             = var.default_action
  bypass                     = var.bypass
  ip_rules                   = concat(["196.54.42.232/30", "196.54.42.236/30"], var.ip_rules)
  virtual_network_subnet_ids = try(var.virtual_network_subnet_ids, null)
  depends_on = [
    null_resource.dns["table"],
    null_resource.dns["blob"],
    null_resource.dns["file"],
    null_resource.dns["queue"],
    null_resource.dns["dfs"]
  ]
}

resource "azurerm_storage_management_policy" "storage" {
  count              = length(var.lifecycles) != 0 ? 1 : 0
  storage_account_id = azurerm_storage_account.main.id

  dynamic "rule" {
    for_each = { for lifecycle in var.lifecycles : lifecycle.name => lifecycle }
    content {
      name    = rule.value.name
      enabled = lookup(rule.value, "enabled", true)
      filters {
        prefix_match = rule.value.prefix_match
        blob_types   = rule.value.blob_types
      }
      actions {
        dynamic "base_blob" {
          for_each = lookup(rule.value, "base_blob", {}) == {} ? [] : [rule.value.base_blob]
          content {
            tier_to_cool_after_days_since_modification_greater_than    = lookup(base_blob.value, "tier_to_cool_after_days", null)
            tier_to_archive_after_days_since_modification_greater_than = lookup(base_blob.value, "tier_to_archive_after_days", null)
            delete_after_days_since_modification_greater_than          = lookup(base_blob.value, "delete_after_days", null)
          }
        }
      }
    }
  }
}
