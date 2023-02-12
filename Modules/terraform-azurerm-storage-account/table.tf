resource "null_resource" "table_dns_delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }

  depends_on = [null_resource.dns["table"]]
}


resource "azurerm_storage_table" "main" {
  for_each             = { for table in var.tables : table.name => table }
  name                 = lower(each.key)
  storage_account_name = azurerm_storage_account.main.name

  dynamic "acl" {
    for_each = lookup(each.value, "acl", [])
    content {
      id = acl.value.id
      dynamic "access_policy" {
        for_each = lookup(acl.value, "access_policy", [])
        content {
          start       = access_policy.value.start
          expiry      = access_policy.value.expiry
          permissions = access_policy.value.permissions
        }
      }
    }
  }

  depends_on = [
    null_resource.table_dns_delay
  ]
}

resource "azurerm_storage_table_entity" "main" {
  for_each             = { for table in var.tables : table.name => table }
  storage_account_name = azurerm_storage_account.main.name
  table_name           = lower(azurerm_storage_table.main[each.key].name)

  partition_key = lower(each.value.partition_key)
  row_key       = lower(each.value.row_key)

  entity     = each.value.entity
  depends_on = [azurerm_storage_account.main, azurerm_storage_table.main]
}
