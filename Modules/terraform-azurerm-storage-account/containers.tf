resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }

  depends_on = [null_resource.dns["blob"]]
}

resource "azurerm_storage_container" "main" {
  for_each              = { for container in var.containers : container.name => container }
  name                  = lower(each.key)
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = try(each.value.container_access_type, "private")
  metadata              = try(each.value.metadata, null)
  depends_on = [
    null_resource.delay
  ]
}
