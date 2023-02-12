locals {
  module_version = trimspace(file("${path.module}/VERSION"))
  default_tags = {
    brand          = var.brand
    costcenter     = var.costcenter
    projectcode    = var.projectcode
    environment    = var.environment
    location       = var.location
    resource_group = var.resource_group_name
    deployed_using = "Terraform - terraform.azurerm.private_endpoint${local.module_version}"
  }
  tags = merge(local.default_tags, var.tags)
}
