# Declaring the provider
terraform{
    required_providers{
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 3.0.2"
        }
    }

    required_version = ">= 1.1.0"
}

provider "azurerm" { 
    features {}
}

# End of the provider

# https://github.com/claranet/terraform-azurerm-regions/blob/master/regions.tf 

resource  "azurerm_resource_group" "rg" { 
    // azurerm_resource_group = Type of item we are creating 
    // rg = our label or alias for this resource inside our terraform file
    name = "MyResourceGroup" # or name = var.name_of_variable
    location = "Brazil Southeast"
}

