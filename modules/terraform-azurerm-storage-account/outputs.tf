output "static_web_site_url" {
  description = "The URL of the static web site."
  value       = azurerm_storage_account.terraform_test.primary_web_endpoint
}

output "primary_web_host" {
  description = "The hostname with port if applicable for web storage in the primary location."
  value       = azurerm_storage_account.terraform_test.primary_web_host
}

output "storage_account_tags" {
  description = "A mapping of tags to assign to the resource."
  value       = azurerm_storage_account.terraform_test.tags
}

output "storage_account_name" {
  description = "Specifies the name of the storage account."
  value       = azurerm_storage_account.terraform_test.name
}