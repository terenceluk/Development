locals {
  gen2fs_list = { for y, x in var.gen2fs : y => x if lookup(x, "gen2fs_paths", []) != [] }
  gen2fs_paths = local.gen2fs_list != null ? flatten([
    for gen2fs_key, gen2fs in local.gen2fs_list : [
      for gen2fs_path_key, gen2fs_path in gen2fs.gen2fs_paths : {
        path            = gen2fs_path
        filesystem_name = lookup(gen2fs, "name", null)
        owner           = lookup(gen2fs, "owner", null)
        group           = lookup(gen2fs, "group", null)
        ace             = lookup(gen2fs, "ace", [])
      }
    ]
  ]) : null
}

resource "null_resource" "dfs_dns_delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }

  depends_on = [null_resource.dns["dfs"]]
}


resource "azurerm_storage_data_lake_gen2_filesystem" "main" {
  for_each           = { for gen in var.gen2fs : gen.name => gen }
  name               = lower(each.value.name)
  storage_account_id = azurerm_storage_account.main.id
  properties         = lookup(each.value, "properties", null)
  owner              = lookup(each.value, "owner", null)
  group              = lookup(each.value, "group", null)

  dynamic "ace" {
    for_each = lookup(each.value, "ace", [])
    content {
      type        = ace.value.type
      permissions = ace.value.permissions
      scope       = lookup(ace.value, "scope", "access")
      id          = lookup(ace.value, "id", null)
    }
  }
  depends_on = [
    null_resource.dfs_dns_delay
  ]
}

resource "azurerm_storage_data_lake_gen2_path" "main" {
  for_each           = { for gen2fs_path in local.gen2fs_paths : gen2fs_path.path => gen2fs_path }
  path               = lower(each.key)
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.main[each.value.filesystem_name].name
  storage_account_id = azurerm_storage_account.main.id
  resource           = "directory"
  owner              = lookup(each.value, "owner", null)
  group              = lookup(each.value, "group", null)

  dynamic "ace" {
    for_each = lookup(each.value, "ace", [])
    content {
      type        = ace.value.type
      permissions = ace.value.permissions
      scope       = lookup(ace.value, "scope", "access")
      id          = lookup(ace.value, "id", null)
    }
  }
}
