variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "web_site_location" {
  description = "The location/region where the web site will be hosted."
  default     = "Norway East"
  type        = string
  validation {
    condition     = contains(["norwayeast", "norwaywest"], var.web_site_location)
    error_message = "The storage account can only be created in Norway East or Norway West"
  }
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)

  validation {
    condition     = contains(["integration", "development", "testing"], lookup(var.tags, "department", ""))
    error_message = "The department should have alpha tag"
  }
}

variable "storage_account_name" {
  description = "The name of the storage account in which to create the resources."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for the storage account."
  type        = bool
}