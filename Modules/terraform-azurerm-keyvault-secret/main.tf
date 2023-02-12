locals {
  default_tags = {
    costcenter  = var.costcenter
    projectcode = var.projectcode
    brand       = var.brand
    environment = var.environment
    location    = var.location
  }
  time_current  = timestamp()
  time_one_year = timeadd(local.time_current, "8760h")
}

data "azurerm_key_vault" "az_key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}

resource "azurerm_key_vault_secret" "az_key_vault_secrets" {
  for_each        = { for secret in var.secrets : secret.secret_name => secret }
  name            = each.value.secret_name
  value           = each.value.secret_value
  content_type    = lookup(each.value, "content_type", null)
  key_vault_id    = data.azurerm_key_vault.az_key_vault.id
  expiration_date = lookup(each.value, "expiration_date", null) == null ? local.time_one_year : each.value.expiration_date
  not_before_date = lookup(each.value, "not_before_date", null)
  tags            = merge(local.default_tags, var.tags)
  lifecycle {
    ignore_changes = [tags]
  }
}