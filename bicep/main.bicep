param resourceGroupName string = resourceGroup().name
param workspaceName string
param location string = resourceGroup().location

// Deploy Microsoft Sentinel Training Lab Solution
resource trainingLab 'Microsoft.SecurityInsights/solutions@2023-02-01' = {
  name: 'AzureSentinelTrainingLab'
  scope: '${resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/${workspaceName}'
  properties: {
    contentKind: 'Solution'
    contentId: 'AzureSentinelTrainingLab'
  }
}

// Deploy Sample Analytics Rule
module sampleRule './analytics_rules/sample_rule.bicep' = {
  name: 'sampleAnalyticsRule'
  params: {
    workspaceName: workspaceName
  }
}

// Deploy Sample Workbook
module sampleWorkbook './workbooks/sample_workbook.bicep' = {
  name: 'sampleWorkbook'
  params: {
    workbookName: 'TrainingLabWorkbook'
    location: location
  }
}

// Deploy Sample Watchlist
module highRiskUsers './watchlists/high_risk_users.bicep' = {
  name: 'highRiskUsersWatchlist'
  params: {
    workspaceName: workspaceName
  }
}

// Deploy Sample Playbook (Logic App stub)
module samplePlaybook './playbooks/sample_playbook.bicep' = {
  name: 'samplePlaybook'
  params: {
    location: location
  }
}