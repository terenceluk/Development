output "gallery_name" {
  value = azurerm_shared_image_gallery.main.name
}

output "gallery_id" {
  value = azurerm_shared_image_gallery.main.id
}
/*
output "gallery_image_id" {
  description = "ids of the gallery images"
  value       = { for k, v in azurerm_shared_image.main : k => v.id }
}
*/