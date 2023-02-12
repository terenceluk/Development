
resource "azurerm_eventgrid_event_subscription" "main" {
  for_each = { for x in var.events : x.name => x }
  name     = each.value.name
  scope    = azurerm_storage_account.main.id

  event_delivery_schema         = try(each.value.event_delivery_schema, null)
  labels                        = try(each.value.labels, null)
  included_event_types          = try(each.value.included_event_types, null)
  eventhub_endpoint_id          = try(each.value.eventhub_id, null)
  service_bus_topic_endpoint_id = try(each.value.service_bus_topic_id, null)
  service_bus_queue_endpoint_id = try(each.value.service_bus_queue_id, null)

  dynamic "storage_queue_endpoint" {
    for_each = try(each.value.storage_account_id, null) == null ? [] : toset(["storage_queue"])
    content {
      storage_account_id = each.value.storage_account_id
      queue_name         = each.value.queue_name
    }
  }

  dynamic "subject_filter" {
    for_each = try(each.value.filters, null) == null ? [] : [each.value.filters]
    content {
      subject_begins_with = try(subject_filter.value.subject_begins_with, null)
      subject_ends_with   = try(subject_filter.value.subject_ends_with, null)
      case_sensitive      = try(subject_filter.value.case_sensitive, false)
    }
  }

  dynamic "delivery_property" {
    for_each = try(each.value.delivery_property, null) == null ? [] : [each.value.delivery_property]
    content {
      header_name  = delivery_property.value.header_name
      type         = delivery_property.value.type
      value        = lower(delivery_property.value.type) == "static" ? delivery_property.value.value : null
      source_field = lower(delivery_property.value.type) == "dynamic" ? delivery_property.value.source_field : null
      secret       = try(delivery_property.value.secret, null)
    }
  }
}
