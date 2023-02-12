locals {

  pe_list = [
    length(var.containers) != 0 ? "blob" : var.force_create_private_endpoint_containers == true ? "blob" : "",
    length(var.tables) != 0 ? "table" : var.force_create_private_endpoint_tables == true ? "table" : "",
    length(var.queues) != 0 ? "queue" : var.force_create_private_endpoint_queues == true ? "queue" : "",
    length(var.shares) != 0 ? "file" : var.force_create_private_endpoint_shares == true ? "file" : "",
    length(var.gen2fs) != 0 ? "dfs" : var.force_create_private_endpoint_gen2fs == true ? "dfs" : "",
    try(var.static_website.index_document, null) != null ? "web" : var.force_create_private_endpoint_index_document == true ? "web" : ""
  ]
}

resource "azurerm_private_endpoint" "main" {
  for_each            = var.enable_privatelink == false ? [] : toset(compact(local.pe_list))
  name                = format("%s-%s-pe", each.key, azurerm_storage_account.main.name)
  location            = var.location
  resource_group_name = local.resource_group_name
  subnet_id           = local.subnet_id

  private_service_connection {

    name                           = format("%s-%s-pc", each.key, azurerm_storage_account.main.name)
    is_manual_connection           = "false"
    private_connection_resource_id = azurerm_storage_account.main.id
    subresource_names              = [each.key]
  }

  tags = merge(local.default_tags, var.tags)
  lifecycle {
    ignore_changes = [
      tags["costcenter"],
      tags["projectcode"],
      tags["environment"],
    ]
  }

  depends_on = [azurerm_storage_account.main]
}

resource "null_resource" "dns" {
  for_each = var.enable_privatelink == false ? [] : toset(compact(local.pe_list))
  triggers = {
    name = azurerm_storage_account.main.name
    ip   = azurerm_private_endpoint.main[each.key].private_service_connection.0.private_ip_address
  }
  provisioner "local-exec" {
    command = "infoblox.sh -u -h $host -D $domain -i $ip"
    environment = {
      host   = self.triggers.name
      domain = "privatelink.${each.key}.core.windows.net"
      ip     = self.triggers.ip
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "infoblox.sh -d -h $host -D $domain"
    environment = {
      host   = self.triggers.name
      domain = "privatelink.${each.key}.core.windows.net"
    }
  }
  depends_on = [
    azurerm_private_endpoint.main
  ]
}
