terraform {
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
      skip_provider_registration = true
      alias                      = "postgres_network"
      subscription_id            = var.aks_subscription_id
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
