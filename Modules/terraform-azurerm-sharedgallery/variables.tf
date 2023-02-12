variable "brand" {
  description = "Company Brand"
  default     = "ctc"
}
variable "override_gallery_name" {
  description = "Override Gallery name if it shouldn't be the same as project name "
  default     = null
}

variable "gallery_name" {
  description = "Enter your project name"
  validation {
    condition = (
    length(var.gallery_name) <= 12
    )
    error_message = "Project Name shouldn't be longer then 12 Characters."
  }
}

variable "environment" {
  description = "Which enviroment sandbox nonprod prod"
  default     = "sandbox"
}

variable "location" {
  description = "Azure location"
  default     = "Canada Central"
}

variable "description" {
  description = "Name of the shared gallery place"
  default     = ""
}

variable "resource_group_name" {
  description = "Name of the resourcegroup the gallery lives in"
}
/*
variable "images" {
  description = "The object to configure image definitions inside your gallery"
  type        = map
}
*/