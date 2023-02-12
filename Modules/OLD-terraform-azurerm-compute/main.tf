locals {
  standard_tags_linux   = { osfamily = "linux", ostype = "rhel" }
  standard_tags_windows = { osfamily = "windows" }
  core-rhel7            = "/subscriptions/e321efb2-bff7-4ec0-a4a7-c5f95abef641/resourceGroups/ctc-sandbox-images-cc-rg/providers/Microsoft.Compute/galleries/ctcimagesgallery/images/core-rhel7"
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}


resource "random_password" "main" {
  for_each = { for y, x in merge(var.linux, var.windows) : y => x if lookup(x, "admin_password", null) == null }
  length   = 16
  special  = true

  keepers = {
    randompass = each.value["hostname"]
  }
}

resource "azurerm_virtual_machine" "vm-linux" {
  for_each                         = var.linux
  name                             = each.value["hostname"]
  location                         = data.azurerm_resource_group.main.location
  resource_group_name              = data.azurerm_resource_group.main.name
  availability_set_id              = lookup(each.value, "disable_availability_set", false) == false ? azurerm_availability_set.main[0].id : null
  vm_size                          = lookup(each.value, "vm_size", "Standard_DS1_V2")
  network_interface_ids            = [azurerm_network_interface.main[each.key].id]
  delete_os_disk_on_termination    = lookup(each.value, "delete_os_disk_on_termination", "true")
  delete_data_disks_on_termination = lookup(each.value, "delete_data_disk_on_termination", "true")

  storage_os_disk {
    name              = "osdisk-${each.value["hostname"]}-01"
    create_option     = "FromImage"
    caching           = "ReadWrite"
    managed_disk_type = lookup(each.value, "storage_account_type", "Standard_LRS")
  }

  storage_data_disk {
    name              = "datadisk-${each.value["hostname"]}-01"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = lookup(each.value, "data_disk_size_gb", "50")
    managed_disk_type = lookup(each.value, "data_sa_type", "Standard_LRS")
  }

  os_profile {
    computer_name  = each.value["hostname"]
    admin_username = lookup(each.value, "admin_username", "toberemoved")
    admin_password = lookup(each.value, "admin_password", null) == null ? random_password.main[each.key].result : each.value["admin_password"]
    custom_data    = lookup(each.value, "custom_data", null)
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_image_reference {
    id        = lookup(each.value, "azure_image_publisher", null) == null ? lookup(each.value, "azure_image_id", null) == null ? local.core-rhel7 : each.value["azure_image_id"] : null
    publisher = lookup(each.value, "azure_image_publisher", null)
    offer     = lookup(each.value, "azure_image_offer", "RHEL7")
    sku       = lookup(each.value, "azure_image_sku", "7")
    version   = lookup(each.value, "azure_image_version", "latest")
  }

  plan {
    name      = lookup(each.value, "azure_plan_sku", "cis-rhel7-l1")
    publisher = lookup(each.value, "azure_plan_publisher", "center-for-internet-security-inc")
    product   = lookup(each.value, "azure_plan_offer", "cis-rhel-7-v2-2-0-l1")
  }

  dynamic "boot_diagnostics" {
    for_each = { for y, x in var.linux : y => x if lookup(x, "boot_diagnostics", null) == "true" }
    content {
      enabled     = "true"
      storage_uri = azurerm_storage_account.main[each.key].primary_blob_endpoint
    }
  }

  tags = merge(lookup(each.value, "tags", {}), local.standard_tags_linux)

  lifecycle {
    ignore_changes = all
  }

}

resource "azurerm_availability_set" "main" {
  count                        = var.linux == [] ? 0 : 1
  name                         = lower(format("%s-%s-%s-%s-avset", var.brand, var.environment, var.project_name, var.location_code))
  location                     = data.azurerm_resource_group.main.location
  resource_group_name          = data.azurerm_resource_group.main.name
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  managed                      = true
  tags                         = var.avset_tags == null ? null : var.avset_tags

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

}

resource "azurerm_network_interface" "main" {
  for_each                      = merge(var.linux, var.windows)
  name                          = "nic-${each.value["hostname"]}"
  location                      = data.azurerm_resource_group.main.location
  resource_group_name           = data.azurerm_resource_group.main.name
  enable_accelerated_networking = lookup(each.value, "enable_accelerated_networking", "false")

  ip_configuration {
    name                          = "ipconfig01"
    subnet_id                     = each.value["vnet_subnet_id"]
    private_ip_address            = lookup(each.value, "private_ip_address", null)
    private_ip_address_allocation = lookup(each.value, "private_ip_address", null) == null ? "Dynamic" : "Static"
  }

  tags = lookup(each.value, "tags", null)

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

}
