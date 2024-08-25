resource "azurerm_resource_group" "hg_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "hg_vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hg_rg.location
  resource_group_name = azurerm_resource_group.hg_rg.name
}

resource "azurerm_subnet" "frontend_subnet" {
  name                 = var.frontend_subnet_name
  resource_group_name  = azurerm_resource_group.hg_rg.name
  virtual_network_name = azurerm_virtual_network.hg_vnet.name
  address_prefixes     = [var.frontend_subnet_address_prefix]
}

resource "azurerm_subnet" "backend_subnet" {
  name                 = var.backend_subnet_name
  resource_group_name  = azurerm_resource_group.hg_rg.name
  virtual_network_name = azurerm_virtual_network.hg_vnet.name
  address_prefixes     = [var.backend_subnet_address_prefix]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = var.db_subnet_name
  resource_group_name  = azurerm_resource_group.hg_rg.name
  virtual_network_name = azurerm_virtual_network.hg_vnet.name
  address_prefixes     = [var.db_subnet_address_prefix]
}

resource "azurerm_network_security_group" "frontend_nsg" {
  name                = var.frontend_nsg_name
  location            = azurerm_resource_group.hg_rg.location
  resource_group_name = azurerm_resource_group.hg_rg.name

  security_rule {
    name                       = "Allow_HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = var.allowed_ip_address
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "backend_nsg" {
  name                = var.backend_nsg_name
  location            = azurerm_resource_group.hg_rg.location
  resource_group_name = azurerm_resource_group.hg_rg.name

  security_rule {
    name                       = "Allow_HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "db_nsg" {
  name                = var.db_nsg_name
  location            = azurerm_resource_group.hg_rg.location
  resource_group_name = azurerm_resource_group.hg_rg.name

  security_rule {
    name                       = "Allow_SQL"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "frontend_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.frontend_subnet.id
  network_security_group_id = azurerm_network_security_group.frontend_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "backend_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.backend_subnet.id
  network_security_group_id = azurerm_network_security_group.backend_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}