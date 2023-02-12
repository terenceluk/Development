provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

resource "random_string" "random" {
  length  = 3
  lower   = true
  upper   = false
  special = false
}

resource "azurerm_storage_account" "test1" {
  name                            = format("testsasforpe%s", random_string.random.result)
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  shared_access_key_enabled       = true
  allow_nested_items_to_be_public = false

  tags = {
    environment = "testing"
  }
}

module "private_endpoint" {
  source = "../../../../"

  for_each = local.private_endpoint

  infoblox_creds      = "${var.svc_vco_ipam_username}:${var.svc_vco_ipam_password}"
  resource_group_name = var.resource_group_name
  environment         = var.environment
  location            = var.location
  project_name        = var.project_name

  create_private_dns_record      = lookup(each.value, "create_private_dns_record", false)
  subnet_name                    = lookup(each.value, "subnet_name", {})
  vnet_name                      = lookup(each.value, "vnet_name", {})
  vnet_rg                        = lookup(each.value, "vnet_rg", {})
  instance_number                = lookup(each.value, "instance_number", null)
  pe_name_override               = lookup(each.value, "pe_name_override", null)
  connection_name                = lookup(each.value, "connection_name", null)
  is_manual_connection           = lookup(each.value, "is_manual_connection", false)
  private_connection_resource_id = lookup(each.value, "private_connection_resource_id", null)
  subresource_names              = lookup(each.value, "subresource_names", [])
  domain_name                    = lookup(each.value, "domain_name", null)
  tags                           = lookup(each.value, "tags", {})
  ip_configuration               = lookup(each.value, "ip_configuration", null)
}
