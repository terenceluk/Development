locals {
  folders_list = { for y, x in var.shares : y => x if lookup(x, "folders", []) != [] }
  folders = local.folders_list != null ? flatten([
    for share_key, share in local.folders_list : [
      for folder_key, folder in share.folders : {
        name       = folder
        share_name = lookup(share, "name", null)
        metadata   = lookup(share, "metadata", null)
      }
    ]
  ]) : null
}

resource "null_resource" "file_dns_delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }

  depends_on = [null_resource.dns["file"]]
}

resource "azurerm_storage_share" "main" {
  for_each             = { for share in var.shares : share.name => share }
  name                 = lower(each.key)
  storage_account_name = azurerm_storage_account.main.name
  access_tier          = lookup(each.value, "access_tier", null)
  enabled_protocol     = lookup(each.value, "enabled_protocol", null)
  quota                = lookup(each.value, "quota", 50)
  metadata             = lookup(each.value, "metadata", null)

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
    null_resource.file_dns_delay
  ]
}

resource "azurerm_storage_share_directory" "main" {
  for_each             = { for folder in local.folders : folder.name => folder }
  name                 = lower(each.key)
  share_name           = azurerm_storage_share.main[lookup(each.value, "share_name")].name
  storage_account_name = azurerm_storage_account.main.name
  metadata             = lookup(each.value, "metadata", null)
}
