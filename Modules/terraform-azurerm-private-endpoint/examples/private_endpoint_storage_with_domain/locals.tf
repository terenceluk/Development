locals {
  private_endpoint = {
    private_endpoint1 = {
      create_private_dns_record      = true
      subnet_name                    = var.subnet_name
      vnet_name                      = var.vnet_name
      vnet_rg                        = var.vnet_rg
      pe_name_override               = format("ctc-nonprod-private-endpoint-test2-%s", random_string.random.result)
      connection_name                = azurerm_storage_account.test1.name
      private_connection_resource_id = azurerm_storage_account.test1.id
      subresource_names              = ["blob"]
      domain_name                    = "privatelink.blob.core.windows.net"
    }
  }
}
