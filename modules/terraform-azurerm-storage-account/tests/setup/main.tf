provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  type = string
}

variable "web_site_location" {
  type = string
}

variable "resource_group_tags" {
  type = map(string)
}

resource "azurerm_resource_group" "terraform_test" {
  name     = var.resource_group_name
  location = var.web_site_location

  tags = var.resource_group_tags
}

output "azurerm_resource_group_name" {
  value = azurerm_resource_group.terraform_test.name
}