param (
    [string]$tenantId = "your-tenant-id",
    [string]$clientId = "your-client-id",
    [string]$clientSecret = "your-client-secret",
    [string]$subscriptionId = "your-subscription-id",
    [string]$resourceGroup = "sentinel-training-rg",
    [string]$workspaceName = "sentinel-training-workspace"
)

# Authenticate
$credential = New-Object System.Management.Automation.PSCredential($clientId, (ConvertTo-SecureString $clientSecret -AsPlainText -Force))
Connect-AzAccount -ServicePrincipal -Credential $credential -Tenant $tenantId -Subscription $subscriptionId

# Deploy Training Lab via API (fallback if Bicep fails)
$url = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroup/providers/Microsoft.OperationalInsights/workspaces/$workspaceName/providers/Microsoft.SecurityInsights/contentPackages/AzureSentinelTrainingLab?api-version=2023-02-01"
$body = @{
    properties = @{
        contentKind = "Solution"
        contentId   = "AzureSentinelTrainingLab"
    }
} | ConvertTo-Json

Invoke-AzRestMethod -Method PUT -Uri $url -Payload $body

Write-Host "Training Lab deployed. Authorize playbook manually or use authorize_playbook.ps1."