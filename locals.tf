locals {
  subnet_nsg_associations = {
    frontend = {
      subnet_id = azurerm_subnet.hg_subnets["frontend"].id
      nsg_id    = azurerm_network_security_group.nsg["frontend"].id
    }
    backend = {
      subnet_id = azurerm_subnet.hg_subnets["backend"].id
      nsg_id    = azurerm_network_security_group.nsg["backend"].id
    }
    database = {
      subnet_id = azurerm_subnet.hg_subnets["database"].id
      nsg_id    = azurerm_network_security_group.nsg["database"].id
    }
  }

  nsg_configs = {
    frontend = {
      name                  = var.frontend_nsg_name
      destination_port      = "80"
      rule_name             = "Allow_HTTP"
      source_address_prefix = var.allowed_ip_address
      access                = "Allow"
    }
    backend = {
      name                  = var.backend_nsg_name
      destination_port      = "8080"
      rule_name             = "Deny_8080"
      source_address_prefix = "*"
      access                = "Deny"
    }
    database = {
      name                  = var.db_nsg_name
      destination_port      = "1433"
      rule_name             = "Deny_SQL"
      source_address_prefix = "*"
      access                = "Deny"
    }
  }
}