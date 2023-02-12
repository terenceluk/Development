terraform {
  required_version = ">= 0.13"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.9.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.14.0"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}
