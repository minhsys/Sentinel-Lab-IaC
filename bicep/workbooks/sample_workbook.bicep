param workbookName string
param location string

resource workbook 'Microsoft.Insights/workbooks@2021-08-01' = {
  //name: workbookName
  name: guid(resourceGroup().id, 'traininglabworkbook')
  location: location
  kind: 'shared'
  properties: {
    displayName: 'Sample Training Workbook'
    serializedData: '{"version":"Notebook/1.0","items":[],"isLocked":false}'
  }
}
