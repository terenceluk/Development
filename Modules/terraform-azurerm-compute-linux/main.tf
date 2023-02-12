/**
 * # AzureRM Compute Linux terraform module
*/

data "azurerm_subnet" "main" {
  name                 = local.subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_rg
}

resource "random_password" "passwd" {
  length      = 8
  min_upper   = 2
  min_lower   = 2
  min_numeric = 1
  special     = false
}

resource "random_string" "username" {
  length  = 6
  special = false
}

resource "tls_private_key" "key" {
  count     = var.generate_admin_ssh_key == true && lower(var.os_flavor) == "linux" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_network_interface" "main" {
  name                          = "${local.vm_name}-nic-01"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "ipconfig01"
    subnet_id                     = data.azurerm_subnet.main.id
    private_ip_address            = var.private_ip_address == null ? null : var.private_ip_address
    private_ip_address_allocation = var.private_ip_address == null ? "Dynamic" : "Static"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = local.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  admin_username        = random_string.username.result
  size                  = var.virtual_machine_size
  network_interface_ids = [azurerm_network_interface.main.id]
  source_image_id       = var.shared_image_id

  admin_ssh_key {
    username   = random_string.username.result
    public_key = var.generate_admin_ssh_key == true && var.os_flavor == "linux" ? tls_private_key.key[0].public_key_openssh : file(var.admin_ssh_key_data)
  }

  dynamic "source_image_reference" {
    for_each = var.shared_image_id == null ? tolist([1]) : []
    content {
      publisher = var.marketplace_image.publisher
      offer     = var.marketplace_image.offer
      sku       = var.marketplace_image.sku
      version   = var.marketplace_image.version
    }
  }

  dynamic "plan" {
    for_each = try(var.plan, null) == null ? [] : ["plan"]
    content {
      name      = var.plan.name
      publisher = var.plan.publisher
      product   = var.plan.product
    }
  }

  availability_set_id = var.existing_avset_id == null && var.availability_zone == null ? azurerm_availability_set.main[0].id : var.existing_avset_id
  zone                = var.availability_zone == null ? null : var.availability_zone


  os_disk {
    name                 = "${local.vm_name}-osdisk-01"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb == null ? null : var.os_disk_size_gb

    dynamic "diff_disk_settings" {
      for_each = var.diff_disk_settings ? ["enabled"] : []
      content {
        option = "Local"
      }
    }
  }
/*
  boot_diagnostics {
    storage_account_uri = var.existing_boot_diagnostics_storage_account_uri == null ? data.azurerm_storage_account.main[0].primary_blob_endpoint : var.existing_boot_diagnostics_storage_account_uri
  }
*/
  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }


  additional_capabilities {
    ultra_ssd_enabled = var.ultra_ssd_enabled
  }


  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  tags = merge(local.default_tags, var.tags)
/*
  depends_on = [data.azurerm_storage_account.main[0]]*/
}

resource "azurerm_managed_disk" "main" {
  for_each             = { for v, x in var.additional_data_disks : v => x }
  name                 = format("%s%s%02d", local.vm_name, "-data-", each.key)
  resource_group_name  = var.resource_group_name
  location             = var.location
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size
  storage_account_type = each.value.storage_account_type
  zone                 = var.availability_zone == null ? null : var.availability_zone

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "main" {
  for_each           = { for v, x in var.additional_data_disks : v => x }
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  managed_disk_id    = azurerm_managed_disk.main[each.key].id
  lun                = each.key
  caching            = each.value.caching
}

resource "azurerm_role_assignment" "vm_user_role" {
  for_each             = { for v, x in var.vm_user_login_assignments : v => x }
  scope                = azurerm_linux_virtual_machine.main.id
  role_definition_name = "Virtual Machine User Login"
  principal_id         = each.value
  depends_on           = [azurerm_linux_virtual_machine.main]
}

resource "azurerm_role_assignment" "vm_admin_role" {
  for_each             = { for v, x in var.vm_admin_login_assignments : v => x }
  scope                = azurerm_linux_virtual_machine.main.id
  role_definition_name = "Virtual Machine Administrator Login"
  principal_id         = each.value
  depends_on           = [azurerm_linux_virtual_machine.main]
}
