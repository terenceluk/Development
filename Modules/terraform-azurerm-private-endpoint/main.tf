data "azurerm_subnet" "main" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg
}


resource "azurerm_private_endpoint" "main" {
  name                          = var.pe_name_override == null ? lower(format("%s%s%s%s-pe%s", var.brand, var.environment, var.project_name, var.location_code, var.instance_number)) : var.pe_name_override
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = data.azurerm_subnet.main.id
  custom_network_interface_name = var.custom_network_interface_name
  tags                          = local.tags

  private_service_connection {
    name                              = var.connection_name
    is_manual_connection              = var.is_manual_connection
    private_connection_resource_id    = var.private_connection_resource_id
    private_connection_resource_alias = var.private_connection_resource_alias
    subresource_names                 = var.subresource_names
    request_message                   = var.is_manual_connection == true ? var.request_message : null
  }

  dynamic "private_dns_zone_group" {
    for_each = try(var.private_dns_zone_group, null) == null ? [] : [var.private_dns_zone_group]
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  dynamic "ip_configuration" {
    for_each = try(var.ip_configuration, null) == null ? [] : [var.ip_configuration]
    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = ip_configuration.value.subresource_name
    }
  }

  lifecycle {
    ignore_changes = [
      tags["costcenter"],
      tags["environment"],
      tags["projectcode"],
    ]
  }
}

resource "null_resource" "main" {
  count = var.create_private_dns_record ? 1 : 0

  triggers = {
    name   = var.connection_name
    domain = var.domain_name
    creds  = var.infoblox_creds
  }

  provisioner "local-exec" {
    command = <<EOT
    ${path.module}/scripts/infoblox.sh -u -h $host -D $domain -l $login -i $ip
  EOT
    environment = {
      host   = self.triggers.name
      domain = self.triggers.domain
      login  = self.triggers.creds
      ip     = azurerm_private_endpoint.main.private_service_connection.0.private_ip_address
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
    ${path.module}/scripts/infoblox.sh -d -h $host -D $domain -l $login
  EOT
    environment = {
      host   = self.triggers.name
      domain = self.triggers.domain
      login  = self.triggers.creds
    }
  }

  depends_on = [
    azurerm_private_endpoint.main
  ]
}
