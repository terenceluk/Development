## Replication using ASR
resource "azurerm_site_recovery_replicated_vm" "vm-replication" {
  for_each                                  = var.enable_replication == true ? { for r, v in var.vm_replication : r => v } : {}
  name                                      = each.value.name
  resource_group_name                       = each.value.recovery_vault_resource_group_name
  recovery_vault_name                       = each.value.recovery_vault_name
  source_recovery_fabric_name               = each.value.source_recovery_fabric_name
  source_vm_id                              = azurerm_linux_virtual_machine.main.id
  recovery_replication_policy_id            = each.value.recovery_replication_policy_id
  source_recovery_protection_container_name = each.value.source_recovery_protection_container_name
  target_resource_group_id                  = each.value.target_resource_group_id
  target_recovery_fabric_id                 = each.value.target_recovery_fabric_id
  target_recovery_protection_container_id   = each.value.target_recovery_protection_container_id

  ## Managed disk block for failover region
  dynamic "managed_disk" {

    for_each = var.enable_replication == true ? var.managed_disk : {}
    content {
      disk_id                    = lookup(managed_disk.value, "disk_id", null)
      staging_storage_account_id = lookup(managed_disk.value, "staging_storage_account_id", null)
      target_resource_group_id   = lookup(managed_disk.value, "target_resource_group_id", null)
      target_disk_type           = lookup(managed_disk.value, "target_disk_type", null)
      target_replica_disk_type   = lookup(managed_disk.value, "target_replica_disk_type", null)
    }
  }

  network_interface {
    source_network_interface_id = azurerm_network_interface.main.id
    target_subnet_name          = var.target_subnet_name
  }

  depends_on = [azurerm_linux_virtual_machine.main, azurerm_managed_disk.main, azurerm_virtual_machine_data_disk_attachment.main]
}

resource "null_resource" "disable_replication" {
  count = var.enable_replication == true ? 1 : 0
  triggers = {

    resourcegroupname = "${lookup(var.vm_replication.replication1, "recovery_vault_resource_group_name")}"
    recoveryvaultname = "${lookup(var.vm_replication.replication1, "recovery_vault_name")}"
    fabricname        = "${lookup(var.vm_replication.replication1, "source_recovery_fabric_name")}"
    containername     = "${lookup(var.vm_replication.replication1, "source_recovery_protection_container_name")}"
    replicationvmname = "${lookup(var.vm_replication.replication1, "name")}"
  }
  provisioner "local-exec" {
    when        = destroy
    command     = "pwsh -f './${path.module}/scripts/removereplication.ps1' -resourcegroupname ${self.triggers.resourcegroupname}  -recoveryvaultname ${self.triggers.recoveryvaultname}  -fabricname ${self.triggers.fabricname} -containername ${self.triggers.containername} -replicationvmname ${self.triggers.replicationvmname}"
    interpreter = ["pwsh", "-Command"]
  }
  depends_on = [azurerm_site_recovery_replicated_vm.vm-replication]
}