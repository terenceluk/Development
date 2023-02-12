data "azurerm_recovery_services_vault" "main" {
  count               = var.recovery_services_vault != null ? 1 : 0
  name                = var.recovery_services_vault.name
  resource_group_name = var.recovery_services_vault.resource_group_name
}

data "azurerm_backup_policy_vm" "main" {
  count               = var.recovery_services_vault != null ? 1 : 0
  name                = var.recovery_services_vault.backup_policy_name
  recovery_vault_name = data.azurerm_recovery_services_vault.main[0].name
  resource_group_name = data.azurerm_recovery_services_vault.main[0].resource_group_name
}

resource "azurerm_backup_protected_vm" "vm-linux" {
  count               = var.recovery_services_vault != null ? 1 : 0
  resource_group_name = data.azurerm_recovery_services_vault.main[0].resource_group_name
  recovery_vault_name = data.azurerm_recovery_services_vault.main[0].name
  source_vm_id        = azurerm_linux_virtual_machine.main.id
  backup_policy_id    = data.azurerm_backup_policy_vm.main[0].id
}