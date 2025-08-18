param workspaceName string
// Reference to Log Analytics Workspace
// resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' existing = {
//   name: workspaceName
// }

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: workspaceName
}


resource highRiskUsersWatchlist 'Microsoft.SecurityInsights/watchlists@2023-02-01' = {
  name: 'HighRiskUsers'
  scope: logAnalytics
  properties: {
    displayName: 'High Risk Users Watchlist'
    description: 'List of high-risk users for training'
    provider: 'Microsoft'
    source: 'Inline'
    itemsSearchKey: 'UserPrincipalName'
    contentType: 'Text/Csv'
    numberOfLinesToSkip: 0
    rawContent: '''
UserPrincipalName
alice@contoso.com
bob@contoso.com
'''
  }
}


// resource watchlist 'Microsoft.SecurityInsights/watchlists@2023-02-01' = {
//   name: 'HighRiskUsers'
//   scope: logAnalytics
//   properties: {
//     displayName: 'High Risk Users Watchlist'
//     itemsSearchQuery: 'let highRiskUsers = dynamic(["user1@company.com", "user2@company.com"]); highRiskUsers'
//     provider: 'Microsoft'
//   }
// }
