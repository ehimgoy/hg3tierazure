variable "location" {
  type    = string
  default = "Central India"
}

variable "resource_group_name" {
  type    = string
  default = "hg-resources"
}

variable "virtual_network_name" {
  type    = string
  default = "hg-network"
}

variable "frontend_nsg_name" {
  type    = string
  default = "frontend-nsg"
}

variable "backend_nsg_name" {
  type    = string
  default = "backend-nsg"
}

variable "db_nsg_name" {
  type    = string
  default = "db-nsg"
}

variable "allowed_ip_address" {
  type    = string
  default = ""
}

variable "subscription_id" {
  description = "The ID of the Subscription"
  type        = string
}

variable "subnets" {
  description = "A map of subnet names to CIDR ranges."
  default = {
    frontend = 0
    backend  = 1
    database = 2
  }
}

variable "vnet_address_space" {
  description = "The address space of the virtual network."
  default     = "10.0.0.0/16"
}

