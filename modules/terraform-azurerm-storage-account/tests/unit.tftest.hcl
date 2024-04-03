# Unit test syntax
# One to many `run` blocks.
# Zero to one `variables` block.
# Zero to many `provider` blocks.
variables {
  resource_group_name           = "rg-cegal-terraform-test-000"
  web_site_location             = "norwayeast"
  storage_account_name          = "cegalterraformtest001"
  public_network_access_enabled = true
  tags = {
    department = "integration"
  }
}

run "unit_test" {
  command = plan

  assert {
    condition     = contains(["norwayeast", "norwaywest"], azurerm_storage_account.terraform_test.location)
    error_message = "The storage account can only be created in Norway East or Norway West"
  }

  assert {
    condition     = azurerm_storage_account.terraform_test.resource_group_name == var.resource_group_name
    error_message = "The storage account resource group should be configured as ${var.resource_group_name}"
  }

  assert {
    condition     = startswith(azurerm_storage_account.terraform_test.name, "sa")
    error_message = "The storage account name must start with 'sa'"
  }

  assert {
    condition     = contains(["staging"], lookup(azurerm_storage_account.terraform_test.tags, "environment", ""))
    error_message = "The environment tag must be set to 'staging'"
  }

  assert {
    condition     = contains(["integration"], lookup(azurerm_storage_account.terraform_test.tags, "department", ""))
    error_message = "The department tag must be set to 'integration'"
  }
}

run "unit_test_negative" {
  command = plan

  variables {
    web_site_location = "westeurope"

    tags = {
      department = "data"
    }
  }

  expect_failures = [
    var.web_site_location,
    var.tags
  ]
}
