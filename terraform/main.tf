provider "azurerm" {
  subscription_id = "8a53693c-b9d9-4b0f-94ad-cd456bb57e73"
  features {}
}

#Resource group
module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

#Log Analytics
module "log_analytics" {
  source              = "./modules/log_analytics"
  workspace_name      = var.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

#Enable Sentinel
module "sentinel" {
  source       = "./modules/sentinel"
  workspace_id = module.log_analytics.workspace_id
}


# resource "azurerm_virtual_machine" "company_vm" {
#   name                  = "company-endpoint"
#   location              = module.resource_group.location
#   resource_group_name   = module.resource_group.name
#   # Additional VM configuration
# }

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "iac-rg"
#     storage_account_name = "sentinelstate"
#     container_name       = "tfstate"
#     key                  = "sentinel-lab-iac.tfstate"
#   }
# }