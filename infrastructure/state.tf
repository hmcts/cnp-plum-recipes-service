terraform {
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
      skip_provider_registration = true
      alias                      = "postgres_network"
      subscription_id            = bf308a5c-0624-4334-8ff8-8dca9fd43783
    }
    random = {
      source = "hashicorp/random"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.35.0"
    }
  }
}
