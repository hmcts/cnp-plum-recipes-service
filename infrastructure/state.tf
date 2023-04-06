terraform {
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source = "hashicorp/random"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.35.0"
    }
    azuread = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
      configuration_aliases = [azurerm.postgres_network]
    }
  }
}
