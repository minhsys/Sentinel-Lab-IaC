param workspaceName string

resource watchlist 'Microsoft.SecurityInsights/watchlists@2023-02-01' = {
  name: 'HighRiskUsers'
  scope: resourceGroup().id + '/providers/Microsoft.OperationalInsights/workspaces/${workspaceName}'
  properties: {
    displayName: 'High Risk Users Watchlist'
    itemsSearchQuery: 'let highRiskUsers = dynamic(["user1@company.com", "user2@company.com"]); highRiskUsers'
    provider: 'Microsoft'
  }
}