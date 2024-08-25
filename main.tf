resource "azurerm_resource_group" "hg_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "hg_vnet" {
  name                = var.virtual_network_name
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.hg_rg.location
  resource_group_name = azurerm_resource_group.hg_rg.name
}

resource "azurerm_subnet" "hg_subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.hg_rg.name
  virtual_network_name = azurerm_virtual_network.hg_vnet.name
  address_prefixes     = [cidrsubnet(var.vnet_address_space, 8, each.value)]
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = local.nsg_configs
  name                = each.value.name
  location            = azurerm_resource_group.hg_rg.location
  resource_group_name = azurerm_resource_group.hg_rg.name

  security_rule {
    name                       = each.value.rule_name
    priority                   = 100
    direction                  = "Inbound"
    access                     = each.value.access
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = each.value.destination_port
    source_address_prefix      = each.value.source_address_prefix
    destination_address_prefix = "*"
  }
}


resource "azurerm_subnet_network_security_group_association" "subnet_nsg_associations" {
  for_each                  = local.subnet_nsg_associations
  subnet_id                 = each.value.subnet_id
  network_security_group_id = each.value.nsg_id
}