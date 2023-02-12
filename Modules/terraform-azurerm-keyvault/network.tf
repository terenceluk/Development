locals {
  vnet_rg     = var.disable_private_endpoint ? null : var.vnet_rg == null ? "ctc-${var.environment}-corenetwork-${var.location_code}-rg" : var.vnet_rg
  subnet_name = var.disable_private_endpoint ? null : var.subnet_name == null ? "ctc-${var.environment}-corenetwork-${var.location_code}-vnet-app01-snet" : var.subnet_name
  vnet_name   = var.disable_private_endpoint ? null : var.vnet_name == null ? "ctc-${var.environment}-corenetwork-${var.location_code}-vnet" : var.vnet_name

  subscription_id = replace(regex("subscriptions/[^/]*", azurerm_key_vault.main.id), "subscriptions/", "")
  subnet_id       = var.disable_private_endpoint ? null : format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Network/virtualNetworks/%s/subnets/%s", local.subscription_id, local.vnet_rg, local.vnet_name, local.subnet_name)
}

resource "azurerm_private_endpoint" "main" {
  for_each            = var.disable_private_endpoint ? [] : toset(["0"])
  name                = lower(format("kv-%s-pe", azurerm_key_vault.main.name))
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = local.subnet_id

  private_service_connection {
    name                           = lower(format("kv-%s-pc", azurerm_key_vault.main.name))
    is_manual_connection           = "false"
    private_connection_resource_id = azurerm_key_vault.main.id
    subresource_names              = ["vault"]
  }
  depends_on = [azurerm_key_vault.main]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "null_resource" "main" {
  for_each = var.disable_private_endpoint ? [] : toset(["0"])
  triggers = {
    name = azurerm_key_vault.main.name
    ip   = azurerm_private_endpoint.main[0].private_service_connection.0.private_ip_address
  }
  provisioner "local-exec" {
    command = <<EOT
  infoblox.sh -u -h $host -D $domain -i $ip
  EOT
    environment = {
      host   = self.triggers.name
      domain = "privatelink.vaultcore.azure.net"
      ip     = self.triggers.ip
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
   infoblox.sh -d -h $host -D $domain
  EOT
    environment = {
      host   = self.triggers.name
      domain = "privatelink.vaultcore.azure.net"
    }
  }

  depends_on = [azurerm_private_endpoint.main]
}
