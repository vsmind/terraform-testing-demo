# Integration test syntax
# One to many `run` blocks.
# Zero to one `variables` block.
# Zero to many `provider` blocks.
variables {
  resource_group_name           = "rg-cegal-terraform-integration-testing-demo"
  web_site_location             = "norwayeast"
  storage_account_name          = "cegalterraformtest002"
  public_network_access_enabled = true
  resource_group_tags = {
    environment = "dev"
  }
  tags = {
    department = "development"
  }
}

run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "integration_tests" {
  command = apply

  assert {
    condition     = contains(["norwayeast", "norwaywest"], azurerm_storage_account.terraform_test.location)
    error_message = "The storage account can only be created in Norway East or Norway West"
  }

  assert {
    condition     = startswith(azurerm_storage_account.terraform_test.primary_web_endpoint, "https")
    error_message = "Site url should start with https"
  }

  assert {
    condition     = strcontains(azurerm_storage_account.terraform_test.primary_web_host, "sacegalterraformtest002")
    error_message = "The storage account name should be included in web host name"
  }
}
