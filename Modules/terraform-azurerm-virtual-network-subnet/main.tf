/*
 * # Azure Subnet Module
 */

resource "azurerm_subnet" "main" {
  name                                          = var.override_subnet_name == null ? lower(format("%s-%s-snet", var.virtual_network_name, var.subnet_name)) : var.override_subnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = var.address_prefixes
  service_endpoints                             = var.service_endpoints
  service_endpoint_policy_ids                   = var.service_endpoint_policy_ids
  private_endpoint_network_policies_enabled     = var.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  dynamic "delegation" {
    for_each = var.delegation
    content {
      name = lookup(delegation.value, "name", null)
      dynamic "service_delegation" {
        for_each = lookup(delegation.value, "service_delegation", [])
        content {
          name    = lookup(service_delegation.value, "name", null)
          actions = lookup(service_delegation.value, "actions", null)
        }
      }
    }
  }
}

resource "azurerm_subnet_route_table_association" "main" {
  for_each       = var.rt_name == null ? [] : toset([var.rt_name])
  subnet_id      = azurerm_subnet.main.id
  route_table_id = "/subscriptions/${local.subscription_id}/resourceGroups/${local.route_table_resource_group_name}/providers/Microsoft.Network/routeTables/${var.rt_name}"
  lifecycle {
    ignore_changes = [route_table_id]
  }
  depends_on = [azurerm_subnet.main]
}

resource "azurerm_subnet_network_security_group_association" "main" {
  for_each                  = var.nsg_name == null ? [] : toset([var.nsg_name])
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = "/subscriptions/${local.subscription_id}/resourceGroups/${local.nsg_table_resource_group_name}/providers/Microsoft.Network/networkSecurityGroups/${var.nsg_name}"
  lifecycle {
    ignore_changes = [network_security_group_id]
  }
  depends_on = [azurerm_subnet.main]
}
