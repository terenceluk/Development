locals {
  storage_accounts = {
    storage1 = {
      enable_audit_diagnostics = false
      containers               = [{ name = "test1", container_access_type = "private", metadata = null }]
      resource_group_name      = var.resource_group_name
      identity                 = { type = "SystemAssigned" }
      events = [
        {
          name                 = "send-to-storage-queue"
          storage_account_id   = "/subscriptions/42c0910c-ba8d-4218-96f2-e8bbcfdb8dc0/resourceGroups/${var.resource_group_name}/providers/Microsoft.Storage/storageAccounts/tfmodqueuetest007st"
          queue_name           = "mysamplequeue"
          included_event_types = ["Microsoft.Storage.BlobDeleted"]
          filters = {
            subject_begins_with = "test"
          }
        },
        {
          name                 = "send-to-asb-topic"
          service_bus_topic_id = "/subscriptions/42c0910c-ba8d-4218-96f2-e8bbcfdb8dc0/resourceGroups/${var.resource_group_name}/providers/Microsoft.ServiceBus/namespaces/tfmodasbtest07/topics/mysampletopic"
          included_event_types = ["Microsoft.Storage.BlobCreated"]
          filters = {
            subject_begins_with = "/blobServices/default/containers/test"
            subject_ends_with   = ".gz"
          }
          delivery_property = {
            header_name = "example-static"
            type        = "Static"
            value       = "example-static"
          }
        }
      ]
      lifecycles = [
        {
          name         = "rule1"
          enabled      = true
          prefix_match = ["test1/path1"]
          blob_types   = ["blockBlob"]
          base_blob = {
            tier_to_cool_after_days    = 7
            tier_to_archive_after_days = 14
            delete_after_days          = 21
          }
        },
        {
          name         = "rule2"
          enabled      = true
          prefix_match = ["test1/path2", "test1/path3"]
          blob_types   = ["appendBlob", "blockBlob"]
          base_blob = {
            delete_after_days = 7
          }
        },
        {
          name         = "rule3"
          enabled      = false
          prefix_match = ["test1/path4"]
          blob_types   = ["appendBlob"]
        }
      ]
    }

    storage2 = {
      enable_customer_managed_keys = false
      replication_override         = "LRS"
      vault_type                   = "hashicorp"
      bypass                       = ["AzureServices"]
      tags                         = { "test_module" = "yes" }
      resource_group_name          = var.resource_group_name
      enable_privatelink           = false
      identity                     = { type = "SystemAssigned" }

      blob_properties = {
        cors_rule = []
      }
      tables = [{
        name          = "test1"
        partition_key = "test1_partition"
        row_key       = "test1_row"
        entity = {
          test_entity = "test_entity"
        }
        }
      ]
    }

    storage3 = {
      subnet_name                          = "ctc-nonprod-corenetwork-cc-vnet-02-app02-snet"
      vnet_name                            = "ctc-nonprod-corenetwork-cc-vnet-02"
      vnet_rg                              = "ctc-nonprod-corenetwork-cc-rg"
      bypass                               = ["AzureServices"]
      tags                                 = { "test_module" = "yes" }
      enable_privatelink                   = false
      is_hns_enabled                       = true
      force_create_private_endpoint_tables = null
      force_create_private_endpoint_queues = null
      identity                             = { type = "SystemAssigned" }
      queues = [{
        name     = "test1"
        metadata = null
        }
      ]
    }

    storage4 = {
      enable_customer_managed_keys = false
      replication_override         = "LRS"
      vault_type                   = "hashicorp"
      nfsv3_enabled                = true
      is_hns_enabled               = true
      bypass                       = ["AzureServices"]
      tags                         = { "test_module" = "yes" }
      resource_group_name          = var.resource_group_name
      enable_privatelink           = false
      identity                     = { type = "SystemAssigned" }
      identity = {
        type         = "SystemAssigned, UserAssigned"
        identity_ids = values(module.authorization-uami.user_assigned_identity_id)
      }
    }

    storage5 = {
      subnet_name                          = "ctc-nonprod-corenetwork-cc-vnet-02-app02-snet"
      vnet_name                            = "ctc-nonprod-corenetwork-cc-vnet-02"
      vnet_rg                              = "ctc-nonprod-corenetwork-cc-rg"
      bypass                               = ["AzureServices"]
      tags                                 = { "test_module" = "yes" }
      is_hns_enabled                       = true
      force_create_private_endpoint_tables = null
      force_create_private_endpoint_queues = null
      identity                             = { type = "SystemAssigned" }
      shares = [{
        name             = "default",
        folders          = ["default"],
        metadata         = null,
        access_tier      = null,
        acl              = [],
        enabled_protocol = null,
        quota            = 50,
      }]
    }
  }
}
