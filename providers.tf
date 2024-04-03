terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.96.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~>3.4.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~>0.11.0"
    }
  }
}

# Configure the Microsoft Azure provider
provider "azurerm" {
  features {}
}

# Configure the http provider for end-to-end tests
provider "http" {
  # Configuration options
}