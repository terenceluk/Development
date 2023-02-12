resource "null_resource" "queue_delay_dns" {
  provisioner "local-exec" {
    command = "sleep 60"
  }

  depends_on = [null_resource.dns["queue"]]
}

resource "azurerm_storage_queue" "main" {
  for_each             = { for queue in var.queues : queue.name => queue }
  name                 = lower(each.key)
  storage_account_name = azurerm_storage_account.main.name
  metadata             = lookup(each.value, "metadata", null)
  depends_on = [
    null_resource.queue_delay_dns
  ]
}
