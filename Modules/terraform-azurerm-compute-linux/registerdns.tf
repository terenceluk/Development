resource "null_resource" "main" {
  count = var.environment != "sandbox" ? 1 : 0
  triggers = {
    name   = local.vm_name
    domain = var.domain_name
  }

  provisioner "local-exec" {
    command = <<EOT
    infoblox.sh -u -h $host -D $domain -i $ip
  EOT
    environment = {
      host   = self.triggers.name
      domain = self.triggers.domain
      ip     = azurerm_network_interface.main.private_ip_address
    }
  }


  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
    infoblox.sh -d -h $host -D $domain
  EOT
    environment = {
      host   = self.triggers.name
      domain = self.triggers.domain
    }
  }
}