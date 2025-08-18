//Parameters
param resourceGroupName string //= resourceGroup().name
param workspaceName string
param location string = resourceGroup().location

// Reference to Log Analytics Workspace
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' existing = {
  name: workspaceName
}

// test to trigger deployment 8 - correct bicep/main.bicetp

var solutionId = 'azuresentinel.azure-sentinel-solution-traininglab' // Derived from GitHub patterns; adjust if needed
var solutionVersion = '1.0.0' // Use latest version; check Content Hub for updates
//var solutionSuffix = '${solutionId}-Solution-${solutionId}-${solutionVersion}'


// Deploy Microsoft Sentinel Training Lab Solution
resource trainingLab 'Microsoft.SecurityInsights/solutions@2023-02-01' = {
  name: 'AzureSentinelTrainingLab'
  scope: logAnalytics 
  //scope: '${resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/${workspaceName}'
  properties: {
    contentKind: 'Solution'
    contentId: 'AzureSentinelTrainingLab'
    displayName: 'Azure Sentinel Training Lab'

  }
}


// param workspaceName string
// param resourceGroupName string = resourceGroup().name
// param location string = resourceGroup().location

// var solutionId = 'azuresentinel.azure-sentinel-solution-traininglab' // Derived from GitHub patterns; adjust if needed
// var solutionVersion = '1.0.0' // Use latest version; check Content Hub for updates
// var solutionSuffix = '${solutionId}-Solution-${solutionId}-${solutionVersion}'

// resource trainingLab 'Microsoft.SecurityInsights/contentPackages@2023-04-01-preview' = {
//   name: 'AzureSentinelTrainingLab'
//   scope: resourceGroupName + '/providers/Microsoft.OperationalInsights/workspaces/' + workspaceName
//   properties: {
//     contentId: solutionId
//     contentProductId: '${take(solutionId, 50)}-sl-${uniqueString(solutionSuffix)}'
//     contentKind: 'Solution'
//     displayName: 'Training Lab'
//     version: solutionVersion
//   }
// }

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
