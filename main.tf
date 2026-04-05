# main.tf
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id                 = var.subscription_id
  client_id                       = var.client_id
  client_secret                   = var.client_secret
  tenant_id                       = var.tenant_id
}

# 動作確認用のテストリソースグループ
resource "azurerm_resource_group" "rg" {
  name     = "rg-zero-trust-infrastructure"
  location = "Japan East"
}
