/*
This file contains all the values for the variables defined in variables.tf
*/

# Variable values for Azure Compute Gallery
name                    = "corp-dev-007"
override_gallery_name   = null
resource_group_name     = "rg-solution"
resource_group_location = "canadacentral"
description             = "This image gallery is used to store the RHCOS custom image for OCP."
environment             = "dev"
