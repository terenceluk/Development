# Module Name
terraform-azure-sharedgallery

Creates a shared image gallery on Azure.

## Usage

See the (examples/) for a usage example.

```
provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

module "galary" {
  source                = "../../../../"
  for_each              = var.galary
  environment           = lookup(each.value, "environment", "nonprod")
  location              = lookup(each.value, "location", {})
  resource_group_name   = lookup(each.value, "resource_group_name", {})
  gallery_name          = lookup(each.value, "gallery_name", {})
  images                = lookup(each.value, "images", {})
}

galary = {
  galary1 = {
    resource_group_name = "ctc-nonprod-tfmodules-cc-rg"
    environment         = "nonprod"
    location            = "Canada Central"
    images = {
      images1 = {
        name           = "rhel-core7"
        os_type        = "Linux"
        publisher_name = "ctc"
        offer          = "rhel"
        sku            = "7"
      }
      images2 = {
        name           = "win-core"
        os_type        = "Windows"
        publisher_name = "ctc"
        offer          = "windows"
        sku            = "2016"
      }
    }
  }
}

```

## Compatibility

This module is meant for use with Terraform 0.13.0 and azure provider ~> 2.27.0

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment | Name of the environment to be deployed | string | `""` | no |
| gallery\_name | Name of the gallery. | string | n/a | yes |
| images | The object to configure image definitions inside your gallery | map | n/a | yes |
| location | azure region location(canadacentral,canadaeast) | string | `"canadacentral"` | no |
| resource\_group\_name | Name of the resourcegroup the gallery lives in | string | n/a | yes |
| os_type | The type of Operating System present in this Shared Image. Possible values are Linux and Windows. Changing this forces a new resource to be created.| string | n/a | yes |
| publisher | The Publisher Name for this Gallery Image | | string | n/a | yes |
| sku |  The Name of the SKU for this Gallery Image.| string | n/a | yes |
| offer | The Offer Name for this Shared Image. |  string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| gallery\_id |  |
| gallery\_image\_id | ids of the gallery images |
| gallery\_name |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
