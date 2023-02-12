/*
The source argument in a module block tells Terraform where to find the source code for the desired child module.
Terraform uses this during the module installation step of terraform init to download the source code to a directory on local disk so that it can be used by other Terraform commands.
*/

# Module for deploying Azure Compute Gallery
module "setup_azure_gallery" {
  source              = "../Modules/terraform-azurerm-sharedgallery" # Repository
  gallery_name        = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  description         = var.description
  environment         = var.environment
}