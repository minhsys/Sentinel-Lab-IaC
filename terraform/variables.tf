variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "sentinel-lab-iac-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
  default     = "sentinel-lab-iac-workspace"
}