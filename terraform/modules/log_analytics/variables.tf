variable "workspace_name" {
  description = "Name of Log Analytics workspace"
  type = string
  default = "sentinel-lab-iac-module-workspace"
}


variable "resource_group_name" {
  type = string
  description = "Name of resource group"

}

# variable "location" {
#   type = string
#   default = "eastus"
# }
variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}