// For workspace state management in Azure
// This file configures the backend to use Azure Blob Storage for storing the Terraform state file
// We can't create the backend resources using Terraform itself, so make sure these resources already exist before applying this configuration
terraform {
  backend "azurerm" {
    resource_group_name  = "another-rg"
    storage_account_name = "itstgaccounttfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
