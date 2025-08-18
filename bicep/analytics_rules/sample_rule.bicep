param workspaceName string

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' existing = {
  name: workspaceName
}

// testing

resource alertRule 'Microsoft.SecurityInsights/alertRules@2023-02-01' = {
  name: 'SampleTrainingRule'
  //scope: resourceGroup().id + '/providers/Microsoft.OperationalInsights/workspaces/${workspaceName}'
  scope: logAnalytics
  kind: 'Scheduled'
  properties: {
    displayName: 'Sample Analytics Rule for Training'
    enabled: true
    query: 'SecurityEvent_CL | where EventID == 4624 | where TimeGenerated > ago(1h)'
    queryFrequency: 'PT1H'
    queryPeriod: 'PT1H'
    severity: 'Medium'
    triggerOperator: 'GreaterThan'
    triggerThreshold: 0
    suppressionDuration: 'PT1H'
    suppressionEnabled: false
  }
}
