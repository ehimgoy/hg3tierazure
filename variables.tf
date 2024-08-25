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

variable "frontend_subnet_name" {
  type    = string
  default = "frontend"
}

variable "backend_subnet_name" {
  type    = string
  default = "backend"
}

variable "db_subnet_name" {
  type    = string
  default = "db"
}

variable "frontend_subnet_address_prefix" {
  type    = string
  default = "10.0.1.0/24"
}

variable "backend_subnet_address_prefix" {
  type    = string
  default = "10.0.2.0/24"
}

variable "db_subnet_address_prefix" {
  type    = string
  default = "10.0.3.0/24"
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