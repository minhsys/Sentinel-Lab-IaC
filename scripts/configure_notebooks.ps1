param (
    [string]$resourceGroup = "sentinel-training-rg",
    [string]$workspaceName = "sentinel-training-workspace",
    [string]$notebookName = "SampleTrainingNotebook",
    [string]$notebookPath = "../notebooks/sample_notebook.ipynb"  # Assume file exists
)

# Install Az.SecurityInsights module if needed (run locally)
# Install-Module -Name Az.SecurityInsights -Scope CurrentUser

# Authenticate (assume already logged in or add Connect-AzAccount)
$content = Get-Content -Path $notebookPath -Raw

New-AzSentinelNotebook -ResourceGroupName $resourceGroup -WorkspaceName $workspaceName -Name $notebookName -Content $content

Write-Host "Sample notebook configured."