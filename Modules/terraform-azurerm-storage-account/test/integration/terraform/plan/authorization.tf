locals {
  user_assigned_identity = [
    {
      name                = lower(format("%s-%s-%s-%s-%s-uas", var.brand, var.environment, var.project_name, var.location_code, "30")),
      resource_group_name = var.resource_group_name
      location            = var.location
    }
  ]
}
