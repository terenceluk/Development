locals {
  subscription_id = element(split("/", azurerm_subnet.main.id), 2)

  route_table_resource_group_name = coalesce(var.rt_resource_group_name, var.resource_group_name)
  nsg_table_resource_group_name   = coalesce(var.nsg_resource_group_name, var.resource_group_name)

}
