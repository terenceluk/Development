module "tfmodqueuetest1" {
  source               = "../../../../"
  environment          = var.environment
  project_name         = var.project_name
  resource_group_name  = var.resource_group_name
  name_override        = "tfmodqueuetest007"
  subnet_name          = "ctc-nonprod-corenetwork-cc-vnet-04-app03-snet"
  vnet_name            = "ctc-nonprod-corenetwork-cc-vnet-04"
  vnet_rg              = "ctc-nonprod-corenetwork-cc-rg"
  bypass               = ["AzureServices"]
  replication_override = "GRS"
  tags                 = { "test_module" = "yes" }
  enable_privatelink   = true
  is_hns_enabled       = true
  blob_properties = {
    cors_rule               = []
    change_feed_enabled     = true
    default_service_version = "2020-06-12"
    container_delete_retention_policy = {
      "days" = 99
    }
  }
  queues                               = [{ name = "mysamplequeue", metadata = null }]
  log_analytics_workspace_id           = null
  enable_customer_managed_keys         = false
  purge_protection_kv                  = false
  disable_private_endpoint_kv          = true
  force_create_private_endpoint_queues = true
  large_file_share_enabled             = false
}

// ASB for testing
resource "azurerm_servicebus_namespace" "tfmodasbtest1" {
  name                = "tfmodasbtest07"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_servicebus_topic" "tfmodasbtest1_mysampletopic" {
  name         = "mysampletopic"
  namespace_id = azurerm_servicebus_namespace.tfmodasbtest1.id
}

module "authorization-uami" {
  source  = "terraform.corp.ad.ctc/azure/authorization/azurerm"
  version = "0.1.1"

  user_assigned_identity = local.user_assigned_identity
}

module "storage_account" {
  source                                       = "../../../../"
  for_each                                     = local.storage_accounts
  environment                                  = var.environment
  project_name                                 = var.project_name
  vnet_rg                                      = try(each.value.vnet_rg, "ctc-nonprod-corenetwork-cc-rg")
  vnet_name                                    = try(each.value.vnet_name, "ctc-nonprod-corenetwork-cc-vnet-04")
  subnet_name                                  = try(each.value.subnet_name, "ctc-nonprod-corenetwork-cc-vnet-04-app03-snet")
  resource_group_name                          = try(each.value.resource_group_name, null)
  queues                                       = try(each.value.queues, [])
  containers                                   = try(each.value.containers, [])
  shares                                       = try(each.value.shares, [])
  events                                       = try(each.value.events, [])
  gen2fs                                       = try(each.value.gen2fs, [])
  lifecycles                                   = try(each.value.lifecycles, [])
  enable_customer_managed_keys                 = try(each.value.enable_customer_managed_keys, false)
  ip_rules                                     = try(each.value.ip_rules, [])
  bypass                                       = try(each.value.bypass, null)
  tags                                         = try(each.value.tags, {})
  enable_privatelink                           = try(each.value.enable_privatelink, true)
  is_hns_enabled                               = try(each.value.is_hns_enabled, false)
  nfsv3_enabled                                = try(each.value.nfsv3_enabled, false)
  replication_override                         = try(each.value.replication_override, "LRS")
  log_analytics_workspace_id                   = try(each.value.log_analytics_workspace_id, null)
  vault_type                                   = try(each.value.vault_type, "akv")
  purge_protection_kv                          = try(each.value.purge_protection_kv, false)
  blob_properties                              = try(each.value.blob_properties, null)
  large_file_share_enabled                     = false
  disable_private_endpoint_kv                  = try(each.value.disable_private_endpoint_kv, true)
  force_create_private_endpoint_containers     = try(each.value.force_create_private_endpoint_containers, null)
  force_create_private_endpoint_tables         = try(each.value.force_create_private_endpoint_tables, null)
  force_create_private_endpoint_queues         = try(each.value.force_create_private_endpoint_queues, null)
  force_create_private_endpoint_shares         = try(each.value.force_create_private_endpoint_shares, null)
  force_create_private_endpoint_gen2fs         = try(each.value.force_create_private_endpoint_gen2fs, null)
  force_create_private_endpoint_index_document = try(each.value.force_create_private_endpoint_index_document, null)
  enable_audit_diagnostics                     = try(each.value.enable_audit_diagnostics, true)

  identity = try(each.value.identity, null) == null ? null : {
    type         = lookup(each.value.identity, "type", "SystemAssigned")
    identity_ids = lookup(each.value.identity, "identity_ids", [])
  }

  depends_on = [
    //azurerm_storage_queue.tfmodqueuetest1_mysamplequeue,
    module.tfmodqueuetest1,
    azurerm_servicebus_topic.tfmodasbtest1_mysampletopic
  ]
}