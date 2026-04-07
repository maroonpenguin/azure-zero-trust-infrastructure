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

# 仮想ネットワークの定義
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-zero-trust"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    environment = "portfolio"
  }
}

# サブネット（内部用）の定義
resource "azurerm_subnet" "subnet_internal" {
  name                 = "snet-internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# ネットワークセキュリティグループ (NSG) の定義
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-zerotrust-default"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # セキュリティルール：HTTPS (443) の許可
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# サブネットとNSGの紐付け
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet_internal.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
