param workspaceName string
// Reference to Log Analytics Workspace
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' existing = {
  name: workspaceName
}


resource watchlist 'Microsoft.SecurityInsights/watchlists@2023-02-01' = {
  name: 'HighRiskUsers'
  scope: logAnalytics
  properties: {
    displayName: 'High Risk Users Watchlist'
    itemsSearchQuery: 'let highRiskUsers = dynamic(["user1@company.com", "user2@company.com"]); highRiskUsers'
    provider: 'Microsoft'
  }
}
