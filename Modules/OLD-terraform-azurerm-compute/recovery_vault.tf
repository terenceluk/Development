data "azurerm_recovery_services_vault" "main" {
  for_each            = { for y, x in "${merge(var.linux, var.windows)}" : y => x if lookup(x, "recovery_services_vault", null) != null }
  name                = each.value["recovery_services_vault"]
  resource_group_name = lookup(each.value, "recovery_services_vault_rg", data.azurerm_resource_group.main.name)
}

data "azurerm_backup_policy_vm" "main" {
  for_each            = { for y, x in "${merge(var.linux, var.windows)}" : y => x if lookup(x, "backup_policy_name", null) != null }
  name                = each.value["backup_policy_name"]
  recovery_vault_name = data.azurerm_recovery_services_vault.main[each.key].name
  resource_group_name = lookup(each.value, "recovery_services_vault_rg", data.azurerm_resource_group.main.name)
}

resource "azurerm_backup_protected_vm" "vm-linux" {
  for_each            = { for y, x in var.linux : y => x if lookup(x, "backup_policy_name", null) != null }
  resource_group_name = lookup(each.value, "recovery_services_vault_rg", data.azurerm_resource_group.main.name)
  recovery_vault_name = data.azurerm_recovery_services_vault.main[each.key].name
  source_vm_id        = azurerm_virtual_machine.vm-linux[each.key].id
  backup_policy_id    = data.azurerm_backup_policy_vm.main[each.key].id
}
