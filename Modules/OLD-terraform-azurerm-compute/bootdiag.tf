resource "azurerm_storage_account" "main" {
  for_each                 = { for y, x in "${merge(var.linux, var.windows)}" : y => x if lookup(x, "boot_diagnostics", null) == "true" }
  name                     = "bootdiag${lower(each.value["hostname"])}"
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = lookup(each.value, "tags", null)
}

resource "azurerm_private_endpoint" "main" {
  for_each            = { for y, x in "${merge(var.linux, var.windows)}" : y => x if lookup(x, "boot_diagnostics", null) == "true" }
  name                = lookup(each.value, "pe_name_override", null) == null ? format("%s-pe", azurerm_storage_account.main[each.key].name) : each.value["pe_name_override"]
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  subnet_id           = each.value["vnet_subnet_id"]

  private_service_connection {

    name                           = azurerm_storage_account.main[each.key].name
    is_manual_connection           = "false"
    private_connection_resource_id = azurerm_storage_account.main[each.key].id
    subresource_names              = ["blob"]
  }
  depends_on = [azurerm_storage_account.main]

}

resource "null_resource" "main" {
  for_each = { for y, x in "${merge(var.linux, var.windows)}" : y => x if lookup(x, "boot_diagnostics", null) == "true" }
  triggers = {
    name  = azurerm_storage_account.main[each.key].name
    creds = var.infoblox_creds
    ip    = azurerm_private_endpoint.main[each.key].private_service_connection.0.private_ip_address
  }

  provisioner "local-exec" {
    command = <<EOT
    ${path.module}/scripts/infoblox.sh -u -h $host -D $domain -l $login -i $ip
  EOT
    environment = {
      host   = self.triggers.name
      domain = "privatelink.blob.core.windows.net"
      login  = self.triggers.creds
      ip     = self.triggers.ip
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
    ${path.module}/scripts/infoblox.sh -d -h $host -D $domain -l $login
  EOT
    environment = {
      host   = self.triggers.name
      domain = "privatelink.blob.core.windows.net"
      login  = self.triggers.creds

    }
  }

  depends_on = [
    azurerm_private_endpoint.main
  ]
}

resource "azurerm_storage_account_network_rules" "main" {
  for_each             = { for y, x in "${merge(var.linux, var.windows)}" : y => x if lookup(x, "boot_diagnostics", null) == "true" }
  resource_group_name  = data.azurerm_resource_group.main.name
  storage_account_name = azurerm_storage_account.main[each.key].name
  default_action       = "Deny"
  depends_on           = [null_resource.main]
}
