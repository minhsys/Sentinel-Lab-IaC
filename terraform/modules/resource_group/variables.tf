variable "resource_group_name" {
  description = "Name of resource group"
  type = string
  default = "sentinel-lab-iac-rg"
}

variable "location" {
  description = "Location of resource group"
  type = string
  default = "eastus"
}