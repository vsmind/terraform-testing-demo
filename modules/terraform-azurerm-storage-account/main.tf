locals {
  storage_account_name = join("", ["sa", var.storage_account_name])
  tags                 = merge(data.azurerm_resource_group.terraform_test.tags, var.tags)
}

data "azurerm_resource_group" "terraform_test" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "terraform_test" {
  name                          = local.storage_account_name
  location                      = data.azurerm_resource_group.terraform_test.location
  resource_group_name           = data.azurerm_resource_group.terraform_test.name
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  account_kind                  = "StorageV2"
  public_network_access_enabled = var.public_network_access_enabled

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = local.tags

  lifecycle {
    precondition {
      condition     = (contains(["testing"], lookup(local.tags, "department", "")) && contains(["staging"], lookup(local.tags, "environment", ""))) || (contains(["integration"], lookup(local.tags, "department", "")) && contains(["staging"], lookup(local.tags, "environment", ""))) || (contains(["development"], lookup(local.tags, "department", "")) && contains(["dev"], lookup(local.tags, "environment", "")))
      error_message = "Testing department can use only staging environment"
    }

    postcondition {
      condition     = self.public_network_access_enabled == true
      error_message = "Public network access should be enabled"
    }
  }
}
