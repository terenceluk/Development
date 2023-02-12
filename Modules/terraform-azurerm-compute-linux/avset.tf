resource "azurerm_availability_set" "main" {
  count                        = var.existing_avset_id == null && var.availability_zone == null ? 1 : 0
  name                         = lower(format("%s%s-avset", local.prefix, var.short_description))
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = var.avset_platform_fault_domain_count
  platform_update_domain_count = var.avset_platform_update_domain_count
  managed                      = true

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}