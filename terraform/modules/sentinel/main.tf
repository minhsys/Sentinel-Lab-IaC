# terraform/modules/sentinel/main.tf
resource "azurerm_sentinel_log_analytics_workspace_onboarding" "sentinel" {
  workspace_id = var.workspace_id
}


