locals {
  resource_group_name = "rg-cegal-terraform-test-000"

  tags = {
    environment = "dev"
  }
}

# Storage account configuration
module "web_site_storage" {
  source = "./modules/terraform-azurerm-storage-account"

  resource_group_name           = local.resource_group_name
  storage_account_name          = "cegaltfdemoprod"
  web_site_location             = "norwayeast"
  public_network_access_enabled = true

  tags = {
    department = "testing"
  }
}

# Simple web page provision to static web site storage account
module "web_page" {
  source = "./modules/terraform-azurerm-web-page"

  index_path           = "${path.root}/web"
  storage_account_name = module.web_site_storage.storage_account_name
}

# Sleep for one minute to allow the web page to be available
resource "time_sleep" "one_minute" {
  create_duration = "60s"

  depends_on = [module.web_page]
}