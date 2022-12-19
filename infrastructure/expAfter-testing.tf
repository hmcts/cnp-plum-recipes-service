resource "azurerm_resource_group" "expAfter_testing_rg" {
  name     = "expAfter-testing-${var.env}"
  location = "UK South"
}

data "azurerm_key_vault" "expAfter_testing_kv" {
  name                = "expAfter-testing-${var.env}"
  resource_group_name = azurerm_key_vault.expAfter_testing_rg.name
}