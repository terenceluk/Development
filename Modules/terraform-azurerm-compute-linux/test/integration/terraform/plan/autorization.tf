locals {
  user_assigned_identity = [
    {
      name                = lower(format("%s-%s-%s-%s-%s-uai", var.brand, var.environment, var.project_name, "cc", "5")),
      resource_group_name = var.resource_group_name
      location            = var.location
    }
  ]
}

module "authorization-uami" {
  source  = "terraform.corp.ad.ctc/azure/authorization/azurerm"
  version = "0.1.1"

  user_assigned_identity = local.user_assigned_identity
}