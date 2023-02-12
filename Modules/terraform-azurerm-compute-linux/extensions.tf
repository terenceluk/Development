resource "azurerm_virtual_machine_extension" "custom" {
  count                      = var.custom_extension != null ? 1 : 0
  name                       = format("%s-custom-ext", local.vm_name)
  virtual_machine_id         = azurerm_linux_virtual_machine.main.id
  publisher                  = var.custom_extension.publisher
  type                       = var.custom_extension.type
  auto_upgrade_minor_version = true
  type_handler_version       = var.custom_extension.type_handler_version
  settings                   = try(jsonencode(var.custom_extension.settings), var.custom_extension.settings)
  protected_settings         = try(jsonencode(var.custom_extension.protected_settings), var.custom_extension.protected_settings)
}

resource "azurerm_virtual_machine_extension" "monitorlinuxagent" {
  count                      = var.deploy_log_analytics_agent != null ? 1 : 0
  name                       = "OmsAgentForLinux"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  virtual_machine_id         = azurerm_linux_virtual_machine.main.id

  settings = <<SETTINGS
    {
      "workspaceId": "${var.deploy_log_analytics_agent.workspace_id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${var.deploy_log_analytics_agent.workspace_key}"
    }
  PROTECTED_SETTINGS
  depends_on         = [azurerm_linux_virtual_machine.main]
}

resource "azurerm_virtual_machine_extension" "dependencyagentlinux" {
  count                      = var.deploy_log_analytics_agent != null ? 1 : 0
  name                       = "DependencyAgentLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.main.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentLinux"
  type_handler_version       = "9.10"
  auto_upgrade_minor_version = true
  depends_on = [
    azurerm_linux_virtual_machine.main,
    azurerm_virtual_machine_extension.monitorlinuxagent
  ]
}

resource "azurerm_virtual_machine_extension" "aadsshloginforlinux" {
  count                      = length(var.vm_user_login_assignments) != 0 || length(var.vm_admin_login_assignments) != 0 ? 1 : 0
  name                       = "AADSSHLoginForLinux"
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  virtual_machine_id         = azurerm_linux_virtual_machine.main.id

  depends_on = [azurerm_linux_virtual_machine.main]
}