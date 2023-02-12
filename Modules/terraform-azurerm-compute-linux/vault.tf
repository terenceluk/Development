locals {
  secrets = {
    host_machine_admin_username = azurerm_linux_virtual_machine.main.admin_username
    host_machines_privatekey    = lower(var.os_flavor) == "linux" && var.generate_admin_ssh_key ? base64encode(tls_private_key.key.0.private_key_pem) : null
    host_machines_publickey     = lower(var.os_flavor) == "linux" && var.generate_admin_ssh_key ? base64encode(tls_private_key.key.0.public_key_openssh) : null
    host_machine_vm_identity    = azurerm_linux_virtual_machine.main.identity[0].principal_id
  }
}

/*
module "vault_mount_secrets_linux" {
  count       = lower(var.vault_type) == "hashicorp" && lower(var.os_flavor) == "linux" && var.generate_admin_ssh_key == true ? 1 : 0
  source      = "terraform.corp.ad.ctc/azure/mount-secrets/vault"
  version     = "1.1.2"
  type        = "azure"
  secret_name = format("%s/%s", var.resource_group_name, azurerm_linux_virtual_machine.main.name)
  data_json = jsonencode({
    "admin_username" = local.secrets.host_machine_admin_username,
    "private_key"    = base64decode(local.secrets.host_machines_privatekey),
    "public_key"     = base64decode(local.secrets.host_machines_publickey),
    "vm_identity"    = local.secrets.host_machine_vm_identity
  })
  depends_on = [azurerm_linux_virtual_machine.main]
}

resource "azurerm_key_vault_secret" "main" {
  for_each     = lower(var.vault_type) == "akv" && lower(var.os_flavor) == "linux" && var.generate_admin_ssh_key == true ? var.secrets : {}
  name         = each.key
  value        = each.value
  key_vault_id = var.key_vault_id
  depends_on   = [azurerm_linux_virtual_machine.main]
}
*/