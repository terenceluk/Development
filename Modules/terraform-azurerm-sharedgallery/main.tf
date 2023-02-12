
resource "azurerm_shared_image_gallery" "main" {
  name                = var.override_gallery_name == null ? lower(format("%s%simnagessg", var.brand, var.environment)) : var.override_gallery_name
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = var.description
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

/*
resource "azurerm_shared_image" "main" {
  for_each              = var.images
  name                  = each.value.name
  gallery_name          = azurerm_shared_image_gallery.main.name
  resource_group_name   = azurerm_shared_image_gallery.main.resource_group_name
  location              = azurerm_shared_image_gallery.main.location
  os_type               = each.value.os_type
  description           = lookup(each.value, "description", null)
  eula                  = lookup(each.value, "eula", null)
  specialized           = lookup(each.value, "specialized", null)
  hyper_v_generation    = lookup(each.value, "hyper_v_generation", null)
  privacy_statement_uri = lookup(each.value, "privacy_statement_uri", null)
  release_note_uri      = lookup(each.value, "release_note_uri", null)

  identifier {
    publisher = lookup(each.value, "publisher_name", "CTC")
    offer     = each.value.offer
    sku       = each.value.sku
  }

  purchase_plan {
    name      = lookup(each.value, "purchase_plan_name", "CTC")
    publisher = lookup(each.value, "purchase_plan_publisher", null)
    product   = lookup(each.value, "product", null)
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
*/